prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>4091478275894304399
,p_default_application_id=>2726
,p_default_id_offset=>2095370998179240442
,p_default_owner=>'ASCHEMA_20241101085900100'
);
end;
/
 
prompt APPLICATION 2726 - diego-regula-cac
--
-- Application Export:
--   Application:     2726
--   Name:            diego-regula-cac
--   Date and Time:   17:19 Thursday October 1, 2026
--   Exported By:     AGATHA.AKAM
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     TASK_DEFINITION: 2351842521209670376
--     WORKFLOW: 2205844388351706543
--   Manifest End
--   Version:         24.2.0
--   Instance ID:     713464445148913
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/workflow/task_definitions/validação_de_cadastro_de_cr
begin
wwv_flow_imp_shared.create_task_def(
 p_id=>wwv_flow_imp.id(2351842521209670376)
,p_name=>unistr('Valida\00E7\00E3o de Cadastro de CR')
,p_static_id=>'VALIDACAO_CADASTRO_CR'
,p_subject=>unistr('An\00E1lise de CR - Solicitante: &V_SOLICITANTE_NOME.')
,p_task_type=>'APPROVAL'
,p_priority=>3
,p_expiration_policy=>'NONE'
,p_max_renewal_count=>3
,p_details_link_target=>'f?p=&APP_ID.:42:&SESSION.::&DEBUG.:RP,42:P42_TASK_ID:&TASK_ID.'
,p_initiator_can_complete=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(2352008042550691207)
,p_task_def_id=>wwv_flow_imp.id(2351842521209670376)
,p_label=>'V Solicitante Nome'
,p_static_id=>'V_SOLICITANTE_NOME'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(2352008471755691208)
,p_task_def_id=>wwv_flow_imp.id(2351842521209670376)
,p_label=>'V Qtd Armas'
,p_static_id=>'V_QTD_ARMAS'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(2352008884333691208)
,p_task_def_id=>wwv_flow_imp.id(2351842521209670376)
,p_label=>'V Qtd Armas Regulares'
,p_static_id=>'V_QTD_ARMAS_REGULARES'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_param(
 p_id=>wwv_flow_imp.id(2352009262085691208)
,p_task_def_id=>wwv_flow_imp.id(2351842521209670376)
,p_label=>'P Tipo Cr'
,p_static_id=>'P_TIPO_CR'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_visible=>true
);
wwv_flow_imp_shared.create_task_def_participant(
 p_id=>wwv_flow_imp.id(2351842891870670377)
,p_task_def_id=>wwv_flow_imp.id(2351842521209670376)
,p_participant_type=>'BUSINESS_ADMIN'
,p_identity_type=>'USER'
,p_value_type=>'STATIC'
,p_value=>'SERVIDOR_PF'
);
wwv_flow_imp_shared.create_task_def_participant(
 p_id=>wwv_flow_imp.id(2661695648715116489)
,p_task_def_id=>wwv_flow_imp.id(2351842521209670376)
,p_participant_type=>'POTENTIAL_OWNER'
,p_identity_type=>'USER'
,p_value_type=>'STATIC'
,p_value=>'AGATHA.AKAM'
);
wwv_flow_imp_shared.create_task_def_participant(
 p_id=>wwv_flow_imp.id(2693281727575835084)
,p_task_def_id=>wwv_flow_imp.id(2351842521209670376)
,p_participant_type=>'POTENTIAL_OWNER'
,p_identity_type=>'USER'
,p_value_type=>'STATIC'
,p_value=>'AVALIADOR_SFPC'
);
end;
/
prompt --application/shared_components/workflow/workflows/wf_emissão_de_cr
begin
wwv_flow_imp_shared.create_workflow(
 p_id=>wwv_flow_imp.id(2205844388351706543)
,p_name=>unistr('WF Emiss\00E3o de CR')
,p_static_id=>'WF_EMISSAO_CR'
,p_title=>unistr('Emiss\00E3o de CR - Documento &P_CPF.')
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2350573165615337816)
,p_workflow_id=>wwv_flow_imp.id(2205844388351706543)
,p_label=>'P_TIPO_SOLICITANTE'
,p_static_id=>'P_TIPO_SOLICITANTE'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2350573228151337817)
,p_workflow_id=>wwv_flow_imp.id(2205844388351706543)
,p_label=>'P_CPF'
,p_static_id=>'P_CPF'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2350573327697337818)
,p_workflow_id=>wwv_flow_imp.id(2205844388351706543)
,p_label=>'P_EMPRESA_COD_ID'
,p_static_id=>'P_EMPRESA_COD_ID'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2350573439128337819)
,p_workflow_id=>wwv_flow_imp.id(2205844388351706543)
,p_label=>'P_MILITAR_NR_IDT'
,p_static_id=>'P_MILITAR_NR_IDT'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2350573593569337820)
,p_workflow_id=>wwv_flow_imp.id(2205844388351706543)
,p_label=>'P_TIPO_CR'
,p_static_id=>'P_TIPO_CR'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2350573613493337821)
,p_workflow_id=>wwv_flow_imp.id(2205844388351706543)
,p_label=>'P_SFPC_RESPONSAVEL'
,p_static_id=>'P_SFPC_RESPONSAVEL'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_is_required=>true
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2350573737091337822)
,p_workflow_id=>wwv_flow_imp.id(2205844388351706543)
,p_label=>'P_EMAIL_DESTINO'
,p_static_id=>'P_EMAIL_DESTINO'
,p_direction=>'IN'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2705922795540426406)
,p_workflow_id=>wwv_flow_imp.id(2205844388351706543)
,p_label=>'P_CR_NUMERO'
,p_static_id=>'P_CR_NUMERO'
,p_direction=>'IN_OUT'
,p_data_type=>'VARCHAR2'
,p_is_required=>false
);
wwv_flow_imp_shared.create_workflow_version(
 p_id=>wwv_flow_imp.id(2738876010902558507)
,p_workflow_id=>wwv_flow_imp.id(2205844388351706543)
,p_version=>'WF_EMISSAO_CR'
,p_state=>'ACTIVE'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2748374040389036101)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_label=>'Approver'
,p_static_id=>'APPROVER'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2748374112506036102)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_label=>'TaskOutcome'
,p_static_id=>'TASK_OUTCOME'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2748374293056036103)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_label=>'V_ACERVO_REGULAR'
,p_static_id=>'V_ACERVO_REGULAR'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2748374367013036104)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_label=>'V_CR_NUMERO'
,p_static_id=>'V_CR_NUMERO'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2748374471092036105)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_label=>'V_EMAIL_DESTINO'
,p_static_id=>'V_EMAIL_DESTINO'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2748374517181036106)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_label=>'V_MOTIVO'
,p_static_id=>'V_MOTIVO'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'STATIC'
,p_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'''''',
''))
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2748374698532036107)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_label=>'V_QTD_ARMAS'
,p_static_id=>'V_QTD_ARMAS'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'STATIC'
,p_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'0',
''))
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2748374772628036108)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_label=>'V_QTD_ARMAS_REGULARES'
,p_static_id=>'V_QTD_ARMAS_REGULARES'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'STATIC'
,p_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'0',
''))
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2748374881365036109)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_label=>'V_SOLICITANTE_NOME'
,p_static_id=>'V_SOLICITANTE_NOME'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'STATIC'
,p_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'''''',
''))
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2748374976519036110)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_label=>'V_SOLICITANTE_VALIDO'
,p_static_id=>'V_SOLICITANTE_VALIDO'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2748375017674036111)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_label=>'V_TASK_ID'
,p_static_id=>'V_TASK_ID'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738876187300558508)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>'Start'
,p_static_id=>'New'
,p_display_sequence=>10
,p_activity_type=>'NATIVE_WORKFLOW_START'
,p_diagram=>'{"position":{"x":0,"y":750},"z":1}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738876371724558510)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>unistr('VALIDA\00C7\00C3O PESSOA CIVIL')
,p_static_id=>'New_1'
,p_display_sequence=>20
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_nome pessoa_civil_prod_ctrldo.nome%TYPE; ',
'begin',
'  select nome',
'    into l_nome',
'    from pessoa_civil_prod_ctrldo',
'   where cpf = :P_CPF;',
'',
'  :V_SOLICITANTE_VALIDO := ''S'';',
'  :V_SOLICITANTE_NOME   := l_nome;',
'  :V_EMAIL_DESTINO      := :P_EMAIL_DESTINO;   -- ver premissa P5',
'exception',
'  when no_data_found then',
'    :V_SOLICITANTE_VALIDO := ''N'';',
'    :V_MOTIVO := ''Pessoa civil nao encontrada para o CPF informado.'';',
'end;'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":400,"y":910},"z":2}'
);
wwv_flow_imp_shared.create_workflow_variable(
 p_id=>wwv_flow_imp.id(2738876417215558511)
,p_activity_id=>wwv_flow_imp.id(2738876371724558510)
,p_label=>'New'
,p_static_id=>'NEW'
,p_direction=>'VARIABLE'
,p_data_type=>'VARCHAR2'
,p_value_type=>'NULL'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738876690371558513)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>'TIPO DE SOLICITANTE'
,p_static_id=>'New_2'
,p_display_sequence=>30
,p_activity_type=>'NATIVE_WORKFLOW_SWITCH'
,p_attribute_01=>'CHECK_WF_VARIABLE'
,p_attribute_10=>'P_TIPO_SOLICITANTE'
,p_diagram=>'{"position":{"x":120,"y":750},"z":3}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738877098333558517)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>unistr('VALIDA\00C7\00C3O EMPRESA')
,p_static_id=>'New_3'
,p_display_sequence=>40
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_razao empresa_prod_ctrldo.razao_social%type;',
'  l_email empresa_prod_ctrldo.e_mail%type;',
'begin',
'  select razao_social, e_mail',
'    into l_razao, l_email',
'    from empresa_prod_ctrldo',
'   where codigo_identificador = :P_EMPRESA_COD_ID;',
'',
'  :V_SOLICITANTE_VALIDO := ''S'';',
'  :V_SOLICITANTE_NOME   := l_razao;',
'  :V_EMAIL_DESTINO      := l_email;',
'exception',
'  when no_data_found then',
'    :V_SOLICITANTE_VALIDO := ''N'';',
'    :V_MOTIVO := ''Empresa nao encontrada para o codigo informado.'';',
'end;'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":470,"y":750},"z":4}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738877200861558519)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>unistr('VALIDA\00C7\00C3O MILITAR')
,p_static_id=>'New_4'
,p_display_sequence=>50
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_nome militar_prod_ctrldo.militar_nome%type;',
'begin',
'  select militar_nome',
'    into l_nome',
'    from militar_prod_ctrldo',
'   where militar_numero_identidade = :P_MILITAR_NR_IDT;',
'',
'  :V_SOLICITANTE_VALIDO := ''S'';',
'  :V_SOLICITANTE_NOME   := l_nome;',
'  :V_EMAIL_DESTINO      := :P_EMAIL_DESTINO;   -- ver premissa P5',
'exception',
'  when no_data_found then',
'    :V_SOLICITANTE_VALIDO := ''N'';',
'    :V_MOTIVO := ''Militar nao encontrado para a identidade informada.'';',
'end;'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":390,"y":570},"z":5}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738877479223558521)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>unistr('SOLICITANTE V\00C1LIDO')
,p_static_id=>'New_5'
,p_display_sequence=>60
,p_activity_type=>'NATIVE_WORKFLOW_SWITCH'
,p_attribute_01=>'TRUE_FALSE_CHECK'
,p_attribute_03=>'EXPRESSION'
,p_attribute_05=>':V_SOLICITANTE_VALIDO = ''S'''
,p_attribute_06=>'PLSQL'
,p_diagram=>'{"position":{"x":920,"y":480},"z":6}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738877730039558524)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>'BUSCA ACERVO ARMA'
,p_static_id=>'New_6'
,p_display_sequence=>70
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'  l_qtd         number := 0;',
'  l_qtd_regular number := 0;',
'begin',
'  select count(*),',
'         count(case ',
'                when REGEXP_LIKE(acv.data_vencimento_craf, ''^\d{2}/\d{2}/\d{4}$'')',
'                and TO_DATE(acv.data_vencimento_craf, ''DD/MM/YYYY'') >= trunc(sysdate)',
'                and acv.data_vencimento_craf >= trunc(sysdate) then 1',
'                   end)',
'    into l_qtd, l_qtd_regular',
'    from acervo_arma acv',
'   where ( :P_TIPO_SOLICITANTE = ''PF''',
'           and acv.pess_civil_prod_ctrldo_cpf = :P_CPF )',
'      or ( :P_TIPO_SOLICITANTE = ''PJ''',
'           and acv.empr_prod_ctrldo_cod_id = :P_EMPRESA_COD_ID )',
'      or ( :P_TIPO_SOLICITANTE = ''MIL''',
'           and acv.militar_prod_ctrldo_nr_idt = :P_MILITAR_NR_IDT );',
'  -- TODO: filtrar tambem por ARMA.STATUS_IND (ver STATUS_ARMA) se a regra exigir',
'',
'  :V_QTD_ARMAS           := l_qtd;',
'  :V_QTD_ARMAS_REGULARES := l_qtd_regular;',
'',
'  if l_qtd_regular > 0 or l_qtd = 0 then',
'    :V_ACERVO_REGULAR := ''S'';',
unistr('    :V_MOTIVO         := case when l_qtd = 0 then ''Sem acervo cadastrado (Primeira Concess\00E3o).'' else null end;'),
'  else',
'    :V_ACERVO_REGULAR := ''N'';',
'    :V_MOTIVO         := ''Existem armas com CRAF vencido ou irregular no acervo.'';',
'  end if;',
'end;'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":710,"y":870},"z":7}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738877958759558526)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>unistr('VALIDA\00C7\00C3O RESPONS\00C1VEL')
,p_static_id=>'New_7'
,p_display_sequence=>80
,p_activity_type=>'NATIVE_CREATE_TASK'
,p_attribute_01=>wwv_flow_imp.id(2351842521209670376)
,p_attribute_02=>unistr('Aprova\00E7\00E3o de CR - Documento &P_CPF.')
,p_attribute_04=>'P42_TASK_ID'
,p_attribute_05=>'P_CR_NUMERO'
,p_attribute_06=>'&APP_USER.'
,p_attribute_09=>'AVALIADOR_SFPC'
,p_attribute_10=>'Y'
,p_diagram=>'{"position":{"x":1780,"y":880},"z":8}'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(2738878134481558528)
,p_workflow_activity_id=>wwv_flow_imp.id(2738877958759558526)
,p_task_def_param_id=>wwv_flow_imp.id(2352009262085691208)
,p_value_type=>'ITEM'
,p_value=>'V_CR_NUMERO'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(2738878236512558529)
,p_workflow_activity_id=>wwv_flow_imp.id(2738877958759558526)
,p_task_def_param_id=>wwv_flow_imp.id(2352008471755691208)
,p_value_type=>'ITEM'
,p_value=>'V_QTD_ARMAS'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(2738878334333558530)
,p_workflow_activity_id=>wwv_flow_imp.id(2738877958759558526)
,p_task_def_param_id=>wwv_flow_imp.id(2352008884333691208)
,p_value_type=>'ITEM'
,p_value=>'V_QTD_ARMAS_REGULARES'
);
wwv_flow_imp_shared.create_task_def_comp_param(
 p_id=>wwv_flow_imp.id(2738878452818558531)
,p_workflow_activity_id=>wwv_flow_imp.id(2738877958759558526)
,p_task_def_param_id=>wwv_flow_imp.id(2352008042550691207)
,p_value_type=>'ITEM'
,p_value=>'V_SOLICITANTE_NOME'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738878546086558532)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>unistr('REGULAR PEND\00CANCIA')
,p_static_id=>'New_8'
,p_display_sequence=>90
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_motivo_tratado varchar2(4000);',
'begin',
unistr('    -- 1. DEFINE A MENSAGEM DE REJEI\00C7\00C3O '),
unistr('    v_motivo_tratado := ''Solicita\00E7\00E3o rejeitada pelo avaliador. Pend\00EAncia administrativa ou t\00E9cnica identificada.'';'),
'    ',
unistr('    -- Atualizamos APENAS a vari\00E1vel oficial e real do Workflow'),
'    :V_MOTIVO := ''CR Rejeitado: '' || v_motivo_tratado;',
'',
unistr('    -- 2. GRAVA O HIST\00D3RICO '),
'    insert into historico_cr_prod_ctrldo (',
'      codigo, data_ocorrencia, tipo_ocorrencia_cr_ind,',
'      cr_prod_ctrldo_numero, sfpc_responsavel_ind,',
'      detalhamento_hist_cr, tipo_atualizacao',
'    ) values (',
'      seq_hist_cr_prod_ctrldo.nextval,   ',
'      sysdate,',
'      ''REJEICAO'',                                    ',
'      :P_CR_NUMERO,        ',
'      :P_SFPC_RESPONSAVEL, ',
unistr('      :V_MOTIVO, -- Aqui tamb\00E9m, usando a vari\00E1vel real!'),
'      ''I''',
'    );',
'',
'    -- 3. TRANCA O CR (Usando a sigla ''CANC'' permitida pela tabela)',
'    update cr_prod_ctrldo',
'       set status_ind = ''CANC'' ',
'     where numero = :P_CR_NUMERO;',
'',
'exception ',
'    when others then',
unistr('        -- Agora sim, se o banco reclamar de algo, o erro ser\00E1 capturado!'),
unistr('        :V_MOTIVO := ''ERRO NA REJEI\00C7\00C3O: '' || sqlerrm;'),
'end;'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":1990,"y":550},"z":9}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738878727486558534)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>'APROVADO?'
,p_static_id=>'New_10'
,p_display_sequence=>100
,p_activity_type=>'NATIVE_WORKFLOW_SWITCH'
,p_attribute_01=>'TRUE_FALSE_CHECK'
,p_attribute_03=>'FUNCTION_BODY'
,p_attribute_06=>'PLSQL'
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_decisao varchar2(255);',
'begin',
'    -- 1. A sua consulta original (Sem o filtro de estado que estava atrapalhando o timing)',
'    select upper(outcome)',
'      into v_decisao',
'      from apex_tasks',
'     where workflow_id = :APEX$WORKFLOW_ID',
'     order by task_id desc',
'     fetch first 1 rows only;',
'',
unistr('    -- 2. A sua regra de valida\00E7\00E3o intacta!'),
'    if v_decisao like ''%APPROV%'' or v_decisao like ''%APROV%'' then',
'        return true;',
'    else',
'        return false;',
'    end if;',
'    ',
'exception ',
'    when others then',
unistr('        -- 3. O Plano B: Se o banco n\00E3o conseguir ler a tabela a tempo, '),
unistr('        -- avaliamos a mesma regra usando a mem\00F3ria instant\00E2nea do clique.'),
'        if upper(:APEX$TASK_OUTCOME) like ''%APPROV%'' or upper(:APEX$TASK_OUTCOME) like ''%APROV%'' then',
'            return true;',
'        else',
'            return false;',
'        end if;',
'end;'))
,p_diagram=>'{"position":{"x":2090,"y":890},"z":10}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738879085316558537)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>'GERA_CR'
,p_static_id=>'New_11'
,p_display_sequence=>110
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'  update cr_prod_ctrldo',
'     set status_ind = ''AT'',',
'         cadastro_em_validacao = ''N'',',
'         data_validacao_cadastro = trunc(sysdate)',
'   where numero = :V_CR_NUMERO;',
'end;'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":2450,"y":890},"z":11}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738879270143558539)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>unistr('REGISTRO HIST\00D3RICO')
,p_static_id=>'New_12'
,p_display_sequence=>120
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    insert into historico_cr_prod_ctrldo (',
'      codigo, data_ocorrencia, tipo_ocorrencia_cr_ind,',
'      cr_prod_ctrldo_numero, sfpc_responsavel_ind,',
'      detalhamento_hist_cr, tipo_atualizacao',
'    ) values (',
'      seq_hist_cr_prod_ctrldo.nextval,   ',
'      sysdate,',
'      ''EMISSAO'',                                    ',
'      :V_CR_NUMERO,        ',
'      :P_SFPC_RESPONSAVEL, ',
'      ''CR emitido via workflow para '' || :V_SOLICITANTE_NOME ||',
'        '' ('' || :V_QTD_ARMAS_REGULARES || '' arma(s) regular(es)).'',',
'      ''I''',
'    );',
'    ',
'    :V_MOTIVO := ''CR Aprovado pelo avaliador e emitido com sucesso!'';',
'',
'exception ',
'    when others then',
'        :V_MOTIVO := ''ERRO DO BANCO: '' || sqlerrm;',
'end;'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":2630,"y":1060},"z":12}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738879443371558541)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>unistr('EMAIL DE CONFIRMA\00C7\00C3O')
,p_static_id=>'New_13'
,p_display_sequence=>130
,p_activity_type=>'NATIVE_SEND_EMAIL'
,p_attribute_01=>'&APP_EMAIL.'
,p_attribute_02=>'&V_EMAIL_DESTINO.'
,p_attribute_06=>unistr('CR emitido - n\00BA &V_CR_NUMERO.')
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Prezado(a) &V_SOLICITANTE_NOME.,',
'',
'Informamos que o seu Certificado de Registro (CR) foi emitido com sucesso.',
unistr('N\00FAmero do CR: &V_CR_NUMERO.'),
'',
'Atenciosamente,',
unistr('Pol\00EDcia Federal')))
,p_attribute_08=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Prezado(a) &V_SOLICITANTE_NOME.,',
'',
'Informamos que o seu Certificado de Registro (CR) foi emitido com sucesso.',
unistr('N\00FAmero do CR: &V_CR_NUMERO.'),
'',
'Atenciosamente,',
unistr('Pol\00EDcia Federal')))
,p_attribute_10=>'N'
,p_diagram=>'{"position":{"x":2790,"y":610},"z":13}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738879631179558543)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>unistr('EMAIL DE PEND\00CANCIA')
,p_static_id=>'New_14'
,p_display_sequence=>140
,p_activity_type=>'NATIVE_SEND_EMAIL'
,p_attribute_01=>'&APP_EMAIL.'
,p_attribute_02=>'agatha.akam@pf.gov.br'
,p_attribute_06=>unistr('CR emitido - n\00BA &V_CR_NUMERO.')
,p_attribute_07=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Ol\00E1, &V_SOLICITANTE_NOME.,'),
'',
unistr('Informamos que a sua solicita\00E7\00E3o de emiss\00E3o de CR (N\00FAmero: &V_CR_NUMERO.) foi paralisada temporariamente durante a nossa an\00E1lise automatizada.'),
'',
unistr('Motivo da pend\00EAncia: '),
'&V_MOTIVO.',
'',
unistr('Por favor, providencie a regulariza\00E7\00E3o para que possamos dar continuidade ao processo.'),
'',
'Atenciosamente,',
unistr('Sistema de Regula\00E7\00E3o - SFPC')))
,p_attribute_08=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('Ol\00E1, &V_SOLICITANTE_NOME.,'),
'',
unistr('Informamos que a sua solicita\00E7\00E3o de emiss\00E3o de CR (N\00FAmero: &V_CR_NUMERO.) foi paralisada temporariamente durante a nossa an\00E1lise automatizada.'),
'',
unistr('Motivo da pend\00EAncia: '),
'&V_MOTIVO.',
'',
unistr('Por favor, providencie a regulariza\00E7\00E3o para que possamos dar continuidade ao processo.'),
'',
'Atenciosamente,',
unistr('Sistema de Regula\00E7\00E3o - SFPC')))
,p_attribute_10=>'N'
,p_diagram=>'{"position":{"x":2390,"y":550},"z":14}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738879856556558545)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>'End'
,p_static_id=>'New_15'
,p_display_sequence=>150
,p_activity_type=>'NATIVE_WORKFLOW_END'
,p_attribute_01=>'COMPLETED'
,p_diagram=>'{"position":{"x":2820,"y":470},"z":15}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738879915679558546)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>'ACERVO REGULAR?'
,p_static_id=>'New_16'
,p_display_sequence=>160
,p_activity_type=>'NATIVE_WORKFLOW_SWITCH'
,p_attribute_01=>'TRUE_FALSE_CHECK'
,p_attribute_03=>'EXPRESSION'
,p_attribute_05=>':V_ACERVO_REGULAR = ''S'''
,p_attribute_06=>'PLSQL'
,p_diagram=>'{"position":{"x":1060,"y":600},"z":16}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2738880256096558549)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>unistr('CR EM VALIDA\00C7\00C3O')
,p_static_id=>'New_17'
,p_display_sequence=>170
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
unistr('    -- 1. Usa o par\00E2metro global rec\00E9m-criado para atualizar o banco'),
'    update cr_prod_ctrldo',
'       set status_ind              = ''AT'', ',
'           cadastro_em_validacao   = ''S'',',
'           em_revalidacao          = ''N'',',
'           data_validacao_cadastro = null',
'     where numero = :P_CR_NUMERO; ',
'',
'    :V_CR_NUMERO := :P_CR_NUMERO;',
'    ',
unistr('    :V_MOTIVO := ''CR encaminhado para a valida\00E7\00E3o do respons\00E1vel'';'),
'exception ',
'    when others then',
unistr('        -- TRUQUE NINJA: Se algo quebrar, a caixinha n\00E3o fica vermelha '),
'        -- e a gente captura o erro exato do banco de dados!',
unistr('        :V_MOTIVO := ''ERRO NA VALIDA\00C7\00C3O: '' || sqlerrm;'),
'end;'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":1360,"y":830},"z":17}'
);
wwv_flow_imp_shared.create_workflow_activity(
 p_id=>wwv_flow_imp.id(2748375337804036114)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_name=>'LOG DE AUDITORIA'
,p_static_id=>'New_9'
,p_display_sequence=>180
,p_activity_type=>'NATIVE_PLSQL'
,p_activity_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_debug.message(''>>> AUDITORIA CR %s: Qtd Armas: %s | Status Acervo: %s'', ',
'                   :V_CR_NUMERO, ',
'                   :V_QTD_ARMAS_REGULARES, ',
'                   :V_ACERVO_REGULAR);'))
,p_activity_code_language=>'PLSQL'
,p_location=>'LOCAL'
,p_diagram=>'{"position":{"x":980,"y":760},"z":39}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738876229697558509)
,p_name=>'inicio'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2738876187300558508)
,p_to_activity_id=>wwv_flow_imp.id(2738876690371558513)
,p_diagram=>'{"source":{"name":"right","args":{"dx":-10,"dy":0}},"target":{"name":"topLeft","args":{"dx":"4.55%","dy":"50%","rotate":true}},"vertices":[],"z":18,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738876569448558512)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2738876371724558510)
,p_to_activity_id=>wwv_flow_imp.id(2738877479223558521)
,p_diagram=>'{"source":{"name":"right","args":{"dx":-10,"dy":0}},"target":{"name":"topLeft","args":{"dx":"40.912%","dy":"100%","rotate":true}},"vertices":[],"z":19,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738876787038558514)
,p_name=>'PF'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(2738876690371558513)
,p_to_activity_id=>wwv_flow_imp.id(2738876371724558510)
,p_condition_type=>'EQUALS'
,p_condition_expr1=>'PF'
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":30,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738876896858558515)
,p_name=>'PJ'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(2738876690371558513)
,p_to_activity_id=>wwv_flow_imp.id(2738877098333558517)
,p_condition_type=>'EQUALS'
,p_condition_expr1=>'PJ'
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":31,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738876905573558516)
,p_name=>'MIL'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(2738876690371558513)
,p_to_activity_id=>wwv_flow_imp.id(2738877200861558519)
,p_condition_type=>'EQUALS'
,p_condition_expr1=>'MIL'
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":32,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738877107924558518)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2738877098333558517)
,p_to_activity_id=>wwv_flow_imp.id(2738877479223558521)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":20,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738877356791558520)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2738877200861558519)
,p_to_activity_id=>wwv_flow_imp.id(2738877479223558521)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":21,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738877586527558522)
,p_name=>'Verdadeira'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(2738877479223558521)
,p_to_activity_id=>wwv_flow_imp.id(2738877730039558524)
,p_condition_expr1=>'TRUE'
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":33,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738877646100558523)
,p_name=>unistr('Inv\00E1lida')
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(2738877479223558521)
,p_to_activity_id=>wwv_flow_imp.id(2738878546086558532)
,p_condition_expr1=>'FALSE'
,p_diagram=>'{"source":{},"target":{},"vertices":[{"x":1550,"y":550}],"z":34,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2748375467157036115)
,p_name=>'New_1'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2738877730039558524)
,p_to_activity_id=>wwv_flow_imp.id(2748375337804036114)
,p_diagram=>'{"source":{},"target":{"pos":{"x":850,"y":1080}},"vertices":[],"z":40,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738878045979558527)
,p_name=>'Incoming'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2738877958759558526)
,p_to_activity_id=>wwv_flow_imp.id(2738878727486558534)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":23,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738878667205558533)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2738878546086558532)
,p_to_activity_id=>wwv_flow_imp.id(2738879631179558543)
,p_diagram=>'{"source":{},"target":{"name":"topLeft","args":{"dx":"50%","dy":"50%","rotate":true}},"vertices":[],"z":24,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738878871132558535)
,p_name=>'Aprovado'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(2738878727486558534)
,p_to_activity_id=>wwv_flow_imp.id(2738879085316558537)
,p_condition_expr1=>'TRUE'
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":35,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738878914263558536)
,p_name=>'Rejeitado'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(2738878727486558534)
,p_to_activity_id=>wwv_flow_imp.id(2738878546086558532)
,p_condition_expr1=>'FALSE'
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":36,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738879155645558538)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2738879085316558537)
,p_to_activity_id=>wwv_flow_imp.id(2738879270143558539)
,p_diagram=>'{"source":{},"target":{"name":"topLeft","args":{"dx":"50%","dy":"50%","rotate":true}},"vertices":[],"z":25,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738879373075558540)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2738879270143558539)
,p_to_activity_id=>wwv_flow_imp.id(2738879443371558541)
,p_diagram=>'{"source":{},"target":{},"vertices":[],"z":26,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738879561418558542)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2738879443371558541)
,p_to_activity_id=>wwv_flow_imp.id(2738879856556558545)
,p_diagram=>'{"source":{},"target":{"args":{"dx":"50%","dy":"50%","rotate":true},"name":"topLeft"},"vertices":[],"z":27,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738879764460558544)
,p_name=>'End'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2738879631179558543)
,p_to_activity_id=>wwv_flow_imp.id(2738879856556558545)
,p_diagram=>'{"source":{},"target":{"name":"topLeft","args":{"dx":"50%","dy":"50%","rotate":true}},"vertices":[],"z":28,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738880054742558547)
,p_name=>'Sim'
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(2738879915679558546)
,p_to_activity_id=>wwv_flow_imp.id(2738880256096558549)
,p_condition_expr1=>'TRUE'
,p_diagram=>'{"source":{},"target":{"name":"topLeft","args":{"dx":"31.818%","dy":"16.667%","rotate":true}},"vertices":[{"x":1420,"y":790}],"z":37,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738880168817558548)
,p_name=>unistr('N\00E3o ')
,p_transition_type=>'BRANCH'
,p_from_activity_id=>wwv_flow_imp.id(2738879915679558546)
,p_to_activity_id=>wwv_flow_imp.id(2738878546086558532)
,p_condition_expr1=>'FALSE'
,p_diagram=>'{"source":{},"target":{},"vertices":[{"x":1420,"y":610},{"x":1650,"y":600}],"z":38,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2738880336566558550)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2738880256096558549)
,p_to_activity_id=>wwv_flow_imp.id(2738877958759558526)
,p_diagram=>'{"source":{},"target":{"name":"topLeft","args":{"dx":"50%","dy":"50%","rotate":true}},"vertices":[],"z":29,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_transition(
 p_id=>wwv_flow_imp.id(2748375575018036116)
,p_name=>'New'
,p_transition_type=>'NORMAL'
,p_from_activity_id=>wwv_flow_imp.id(2748375337804036114)
,p_to_activity_id=>wwv_flow_imp.id(2738879915679558546)
,p_diagram=>'{"source":{},"target":{"pos":{"x":1090,"y":980}},"vertices":[],"z":41,"label":{"distance":0.5,"offset":0}}'
);
wwv_flow_imp_shared.create_workflow_participant(
 p_id=>wwv_flow_imp.id(2748375197313036112)
,p_workflow_version_id=>wwv_flow_imp.id(2738876010902558507)
,p_participant_type=>'OWNER'
,p_name=>'New'
,p_identity_type=>'USER'
,p_value_type=>'STATIC'
,p_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'&APP_USER.',
''))
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
--commit;
end;
/
set verify on feedback on define on
prompt  ...done
