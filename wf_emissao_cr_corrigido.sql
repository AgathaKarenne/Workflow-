/* =============================================================================
   WF_EMISSAO_CR - Atividades PL/SQL corrigidas
   App 2726 (diego-regula-cac) - APEX 24.2

   Como usar: cole cada bloco no "Code" da atividade correspondente
   (Workflow > Versão WF_EMISSAO_CR > Atividade > PL/SQL Code).
   Itens marcados [CONFIG] são ajustes de propriedades, não código.

   Princípio geral das correções:
   - Erro de banco NÃO é mais engolido com "when others". Se algo falhar,
     a atividade fica em erro e pode ser reexecutada (Workflow > Retry)
     depois de corrigida a causa. Isso evita CR ativado sem histórico,
     histórico gravado com CR ainda ativo, task criada sem CR atualizado etc.
   - V_MOTIVO só é escrito por quem conhece o motivo real.
============================================================================= */


/* -----------------------------------------------------------------------------
   [CONFIG] VARIÁVEIS DA VERSÃO
   - V_MOTIVO e V_SOLICITANTE_NOME: Value Type = NULL
     (hoje o valor estático é o texto literal '' -> e-mail sai "Olá, '',")
   - Manter APPROVER, TASK_OUTCOME e V_TASK_ID: passam a ser usadas abaixo.
   - Remover a variável "NEW" declarada dentro de VALIDAÇÃO PESSOA CIVIL.
----------------------------------------------------------------------------- */


/* -----------------------------------------------------------------------------
   VALIDAÇÃO PESSOA CIVIL  (New_1)
----------------------------------------------------------------------------- */
declare
  l_nome pessoa_civil_prod_ctrldo.nome%type;
begin
  select nome
    into l_nome
    from pessoa_civil_prod_ctrldo
   where cpf = :P_CPF;

  :V_SOLICITANTE_VALIDO := 'S';
  :V_SOLICITANTE_NOME   := l_nome;
  :V_EMAIL_DESTINO      := :P_EMAIL_DESTINO;   -- premissa P5: PF não tem e-mail na tabela
exception
  when no_data_found then
    :V_SOLICITANTE_VALIDO := 'N';
    :V_MOTIVO := 'Pessoa civil não encontrada para o CPF informado.';
  when too_many_rows then
    :V_SOLICITANTE_VALIDO := 'N';
    :V_MOTIVO := 'CPF duplicado no cadastro de pessoa civil. Necessária correção cadastral.';
end;


/* -----------------------------------------------------------------------------
   VALIDAÇÃO EMPRESA  (New_3)
----------------------------------------------------------------------------- */
declare
  l_razao empresa_prod_ctrldo.razao_social%type;
  l_email empresa_prod_ctrldo.e_mail%type;
begin
  select razao_social, e_mail
    into l_razao, l_email
    from empresa_prod_ctrldo
   where codigo_identificador = :P_EMPRESA_COD_ID;

  :V_SOLICITANTE_VALIDO := 'S';
  :V_SOLICITANTE_NOME   := l_razao;
  :V_EMAIL_DESTINO      := nvl(l_email, :P_EMAIL_DESTINO);
exception
  when no_data_found then
    :V_SOLICITANTE_VALIDO := 'N';
    :V_MOTIVO := 'Empresa não encontrada para o código informado.';
  when too_many_rows then
    :V_SOLICITANTE_VALIDO := 'N';
    :V_MOTIVO := 'Código de empresa duplicado no cadastro. Necessária correção cadastral.';
end;


/* -----------------------------------------------------------------------------
   VALIDAÇÃO MILITAR  (New_4)
----------------------------------------------------------------------------- */
declare
  l_nome militar_prod_ctrldo.militar_nome%type;
begin
  select militar_nome
    into l_nome
    from militar_prod_ctrldo
   where militar_numero_identidade = :P_MILITAR_NR_IDT;

  :V_SOLICITANTE_VALIDO := 'S';
  :V_SOLICITANTE_NOME   := l_nome;
  :V_EMAIL_DESTINO      := :P_EMAIL_DESTINO;   -- premissa P5
exception
  when no_data_found then
    :V_SOLICITANTE_VALIDO := 'N';
    :V_MOTIVO := 'Militar não encontrado para a identidade informada.';
  when too_many_rows then
    :V_SOLICITANTE_VALIDO := 'N';
    :V_MOTIVO := 'Identidade militar duplicada no cadastro. Necessária correção cadastral.';
end;


/* -----------------------------------------------------------------------------
   BUSCA ACERVO ARMA  (New_6)

   Mudanças:
   - Conversão segura: datas inválidas viram NULL (não regulares) em vez de
     derrubar a atividade. Requer Oracle 12.2+.
   - Removida a comparação VARCHAR2 x DATE (dependia de NLS).
   - Regra: acervo regular = TODAS as armas com CRAF em dia.
     >>> CONFIRMAR com a área de negócio. Se a regra for "ao menos uma
         válida", troque "l_qtd_regular = l_qtd" por "l_qtd_regular > 0".
----------------------------------------------------------------------------- */
declare
  l_qtd         number := 0;
  l_qtd_regular number := 0;
begin
  select count(*),
         count(case
                 when to_date(acv.data_vencimento_craf default null on conversion error,
                              'DD/MM/YYYY') >= trunc(sysdate)
                 then 1
               end)
    into l_qtd, l_qtd_regular
    from acervo_arma acv
   where ( :P_TIPO_SOLICITANTE = 'PF'
           and acv.pess_civil_prod_ctrldo_cpf = :P_CPF )
      or ( :P_TIPO_SOLICITANTE = 'PJ'
           and acv.empr_prod_ctrldo_cod_id = :P_EMPRESA_COD_ID )
      or ( :P_TIPO_SOLICITANTE = 'MIL'
           and acv.militar_prod_ctrldo_nr_idt = :P_MILITAR_NR_IDT );
  -- TODO (mantido): filtrar por ARMA.STATUS_IND para desconsiderar armas
  -- baixadas/transferidas, se a regra exigir.

  :V_QTD_ARMAS           := to_char(l_qtd);
  :V_QTD_ARMAS_REGULARES := to_char(l_qtd_regular);

  if l_qtd = 0 then
    :V_ACERVO_REGULAR := 'S';
    :V_MOTIVO         := 'Sem acervo cadastrado (Primeira Concessão).';
  elsif l_qtd_regular = l_qtd then
    :V_ACERVO_REGULAR := 'S';
    :V_MOTIVO         := null;
  else
    :V_ACERVO_REGULAR := 'N';
    :V_MOTIVO         := (l_qtd - l_qtd_regular)
                         || ' de ' || l_qtd
                         || ' arma(s) com CRAF vencido ou com data inválida no acervo.';
  end if;
end;


/* -----------------------------------------------------------------------------
   LOG DE AUDITORIA  (New_9)

   V_CR_NUMERO ainda é nulo neste ponto; usa P_CR_NUMERO.
   Obs.: apex_debug só grava com debug ativo. Para auditoria de verdade,
   gravar em tabela própria (ou em historico_cr_prod_ctrldo).
----------------------------------------------------------------------------- */
begin
  apex_debug.info(
    '>>> AUDITORIA CR %s: Armas: %s | Regulares: %s | Acervo regular: %s',
    :P_CR_NUMERO,
    :V_QTD_ARMAS,
    :V_QTD_ARMAS_REGULARES,
    :V_ACERVO_REGULAR);
end;


/* -----------------------------------------------------------------------------
   CR EM VALIDAÇÃO  (New_17)

   - Sem "when others": se não atualizar, a task NÃO é criada.
   - Verifica se o CR existe.
   - status_ind: mantido 'AT' porque não conheço os valores aceitos pela
     check constraint. >>> Se existir um status de "em análise", use-o aqui;
     hoje o CR fica ATIVO antes da aprovação.
----------------------------------------------------------------------------- */
begin
  if :P_CR_NUMERO is null then
    raise_application_error(-20001, 'P_CR_NUMERO não informado ao iniciar o workflow.');
  end if;

  update cr_prod_ctrldo
     set status_ind              = 'AT',   -- ver observação acima
         cadastro_em_validacao   = 'S',
         em_revalidacao          = 'N',
         data_validacao_cadastro = null
   where numero = :P_CR_NUMERO;

  if sql%rowcount = 0 then
    raise_application_error(-20002, 'CR ' || :P_CR_NUMERO || ' não encontrado em CR_PROD_CTRLDO.');
  end if;

  :V_CR_NUMERO := :P_CR_NUMERO;
  :V_MOTIVO    := 'CR encaminhado para a validação do responsável.';
end;


/* -----------------------------------------------------------------------------
   [CONFIG] VALIDAÇÃO RESPONSÁVEL  (Human Task - Create, New_7)
   - Subject: 'Aprovação de CR nº &P_CR_NUMERO. - &V_SOLICITANTE_NOME.'
     (tira o CPF: vazio para PJ/MIL e expõe dado pessoal na lista de tarefas)
   - Task ID Item: V_TASK_ID        (hoje aponta para P42_TASK_ID, item de página)
   - Outcome:      TASK_OUTCOME
   - Approver:     APPROVER         (opcional, útil para o histórico)
   - Parâmetro P_TIPO_CR -> valor P_TIPO_CR  (hoje recebe V_CR_NUMERO!)
   - Título do workflow: 'Emissão de CR nº &P_CR_NUMERO.'

   [CONFIG] Task Definition VALIDACAO_CADASTRO_CR
   - Initiator Can Complete: NÃO  (evita autoaprovação)
   - Remover AGATHA.AKAM de Potential Owner
   - Se AVALIADOR_SFPC / SERVIDOR_PF forem papéis, trocar Value Type
     de STATIC para SQL Query retornando os usuários do papel.
   - Considerar Expiration Policy (prazo / escalonamento).
----------------------------------------------------------------------------- */


/* -----------------------------------------------------------------------------
   [CONFIG] APROVADO?  (New_10)
   Opção recomendada:
     Switch Type: Check Workflow Variable -> TASK_OUTCOME
     Branch "Aprovado":  Equals APPROVED  -> GERA_CR
     Branch "Rejeitado": Equals REJECTED  -> MOTIVO REJEIÇÃO (nova, abaixo)

   Se preferir manter True/False Check, use este Function Body:
----------------------------------------------------------------------------- */
begin
  return :TASK_OUTCOME = 'APPROVED';
end;


/* -----------------------------------------------------------------------------
   NOVA ATIVIDADE: MOTIVO REJEIÇÃO  (PL/SQL)
   Transições:  APROVADO? --Rejeitado--> MOTIVO REJEIÇÃO --> REGULAR PENDÊNCIA

   Usa o último comentário que o avaliador deixou na task, se houver.
----------------------------------------------------------------------------- */
declare
  l_comentario varchar2(4000);
begin
  begin
    select text
      into l_comentario
      from apex_task_comments
     where task_id = :V_TASK_ID
     order by created_on desc
     fetch first 1 row only;
  exception
    when no_data_found then
      l_comentario := null;
  end;

  :V_MOTIVO := 'Solicitação rejeitada pelo avaliador'
               || case when l_comentario is not null
                       then ': ' || l_comentario
                       else '. Pendência administrativa ou técnica identificada.'
                  end;
end;


/* -----------------------------------------------------------------------------
   REGULAR PENDÊNCIA  (New_8)

   - NÃO sobrescreve mais V_MOTIVO: usa o que veio do caminho de origem
     (solicitante inválido, acervo irregular ou rejeição do avaliador).
   - Só grava histórico / cancela se houver CR.
   - Sem "when others": falha parcial não deixa banco inconsistente.
----------------------------------------------------------------------------- */
declare
  l_cr cr_prod_ctrldo.numero%type := nvl(:V_CR_NUMERO, :P_CR_NUMERO);
begin
  :V_MOTIVO           := nvl(:V_MOTIVO, 'Pendência não especificada.');
  :V_SOLICITANTE_NOME := nvl(:V_SOLICITANTE_NOME, 'Solicitante');
  :V_EMAIL_DESTINO    := nvl(:V_EMAIL_DESTINO, :P_EMAIL_DESTINO);
  :V_CR_NUMERO        := l_cr;

  if l_cr is not null then
    insert into historico_cr_prod_ctrldo (
      codigo, data_ocorrencia, tipo_ocorrencia_cr_ind,
      cr_prod_ctrldo_numero, sfpc_responsavel_ind,
      detalhamento_hist_cr, tipo_atualizacao
    ) values (
      seq_hist_cr_prod_ctrldo.nextval,
      sysdate,
      'REJEICAO',
      l_cr,
      :P_SFPC_RESPONSAVEL,
      substr(:V_MOTIVO, 1, 4000),
      'I'
    );

    -- >>> CONFIRMAR: rejeição cancela o CR (CANC) ou apenas suspende?
    update cr_prod_ctrldo
       set status_ind            = 'CANC',
           cadastro_em_validacao = 'N'
     where numero = l_cr;
  end if;
end;


/* -----------------------------------------------------------------------------
   GERA_CR  (New_11)
----------------------------------------------------------------------------- */
begin
  update cr_prod_ctrldo
     set status_ind              = 'AT',
         cadastro_em_validacao   = 'N',
         data_validacao_cadastro = trunc(sysdate)
   where numero = :V_CR_NUMERO;

  if sql%rowcount = 0 then
    raise_application_error(-20003, 'CR ' || :V_CR_NUMERO || ' não encontrado ao emitir.');
  end if;
end;


/* -----------------------------------------------------------------------------
   REGISTRO HISTÓRICO  (New_12)
   Sem "when others": se falhar, o e-mail de "emitido com sucesso" não sai.
----------------------------------------------------------------------------- */
begin
  insert into historico_cr_prod_ctrldo (
    codigo, data_ocorrencia, tipo_ocorrencia_cr_ind,
    cr_prod_ctrldo_numero, sfpc_responsavel_ind,
    detalhamento_hist_cr, tipo_atualizacao
  ) values (
    seq_hist_cr_prod_ctrldo.nextval,
    sysdate,
    'EMISSAO',
    :V_CR_NUMERO,
    :P_SFPC_RESPONSAVEL,
    'CR emitido via workflow para ' || :V_SOLICITANTE_NOME
      || ' (' || :V_QTD_ARMAS_REGULARES || ' arma(s) regular(es))'
      || case when :APPROVER is not null then '. Aprovado por ' || :APPROVER end
      || '.',
    'I'
  );

  :V_MOTIVO := 'CR aprovado pelo avaliador e emitido com sucesso.';
end;


/* -----------------------------------------------------------------------------
   [CONFIG] EMAIL DE PENDÊNCIA  (New_14)
   To:      &V_EMAIL_DESTINO.          (hoje: agatha.akam@pf.gov.br fixo)
   Subject: Pendência na solicitação de CR nº &V_CR_NUMERO.
   Body (texto) - ajuste se a rejeição for suspensão e não cancelamento:

     Prezado(a) &V_SOLICITANTE_NOME.,

     Sua solicitação de emissão de CR (nº &V_CR_NUMERO.) não pôde ser concluída.

     Motivo: &V_MOTIVO.

     Após a regularização, uma nova solicitação poderá ser apresentada.

     Atenciosamente,
     <assinatura padronizada>

   HTML Body: mesmo texto com <p>/<br>, ou deixe vazio para enviar só texto.

   [CONFIG] EMAIL DE CONFIRMAÇÃO  (New_13)
   - Mesma assinatura do e-mail de pendência (hoje: "Polícia Federal" x "SFPC").
   - Premissa P5: se P_EMAIL_DESTINO pode vir nulo para PF/MIL, torne-o
     obrigatório no início do workflow ou adicione um switch antes do envio.

   [CONFIG] Geral
   - Renomear static IDs New_1..New_17 e transições "New" para nomes
     descritivos (VALIDA_PF, BUSCA_ACERVO, ...). Facilita ler logs/erros.
   - TIPO DE SOLICITANTE não tem caminho para valor fora de PF/PJ/MIL:
     garantir na página que inicia o workflow (select list com esses 3 valores).
----------------------------------------------------------------------------- */
