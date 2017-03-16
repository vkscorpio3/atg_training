drop procedure                                                                  
DMS_QUEUE_FLAG                                                                  
;                                                                               
                                                                                
drop procedure                                                                  
DMS_TOPIC_FLAG                                                                  
;                                                                               
                                                                                
drop view                                                                       
DRPT_ABANDON_ORD                                                                
cascade constraints;                                                            
                                                                                
drop view                                                                       
DRPT_TNS_ABNDN_ORD                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_ID_GENERATOR                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_SECURE_ID_GEN                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_CLUSTER_NAME                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_LIMBO                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_LIMBO_MSG                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_LIMBO_REPLYTO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_LIMBO_BODY                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_LIMBO_PROPS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_LIMBO_PTYPES                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_LIMBO_DELAY                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_CLIENT                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_QUEUE                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_QUEUE_RECV                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_QUEUE_ENTRY                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_TOPIC                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_TOPIC_SUB                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_TOPIC_ENTRY                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_MSG                                                                         
cascade constraints;                                                            
                                                                                
drop table                                                                      
DMS_MSG_PROPERTIES                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_ACCOUNT                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_GROUP_ASSOC                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_ACCT_PREVPWD                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_GSA_SUBSCRIBER                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_SDS                                                                         
cascade constraints;                                                            
                                                                                
drop table                                                                      
IF_INTEG_DATA                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_NUCL_SEC                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_NS_ACLS                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
MEDIA_FOLDER                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
MEDIA_BASE                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
MEDIA_EXT                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
MEDIA_BIN                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
MEDIA_TXT                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_DEPLOYMENT                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_DEPL_PROGRESS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_THREAD_BATCH                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_DEPLOY_DATA                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_DEPLOY_MARK                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_REP_MARK                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_FILE_MARK                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_DEPL_DEPLDAT                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_DEPL_OPTIONS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_DEPL_REPMAPS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_DEPL_ITEM_REF                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_DD_MARKERS                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_DEP_FAIL_INFO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_SITEINDEX                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_SITEMAP                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_SEO_TAG                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_SEO_SITES                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
SITE_TEMPLATE                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
SITE_CONFIGURATION                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
SITE_ADDITIONAL_URLS                                                            
cascade constraints;                                                            
                                                                                
drop table                                                                      
SITE_TYPES                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
SITE_GROUP                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
SITE_GROUP_SITES                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
SITE_GROUP_SHAREABLE_TYPES                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_SYS_CONFIG                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DAS_PURGE_PROGRESS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_ORGANIZATION                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_USER                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_CONTACT_INFO                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_USER_ADDRESS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_OTHER_ADDR                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_MAILING                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_MAIL_TRACKDATA                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_MAIL_BATCH                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_MAIL_SERVER                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_USER_MAILING                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_EMAIL_ADDRESS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_ROLE                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_USER_ROLES                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_ORG_ROLE                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_ROLE_REL_ORG                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_RELATIVEROLE                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_USER_ORG                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_USER_ORG_ANC                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_ORG_CHLDORG                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_ORG_ANCESTORS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_FOLDER                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_CHILD_FOLDER                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_ROLEFOLD_CHLD                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_USER_PREVPWD                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_PROFILE_REALM                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_EVENT_TYPE                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_USER_EVENT                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_USER_EVENT_SUM                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_REQUEST                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_REQNAME_SUM                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_SESSION_SUM                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_CON_REQ                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_CON_REQ_SUM                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_PGRP_REQ_SUM                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_PGRP_CON_SUM                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_LOG_ID                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_SEG_LIST                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_SEG_LIST_NAME                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_SEG_LIST_FOLDER                                                             
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_ORGANIZATION                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_USER                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_CONTACT_INFO                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_USER_ADDRESS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_OTHER_ADDR                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_MAILING                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_MAIL_TRACKDATA                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_MAIL_BATCH                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_MAIL_SERVER                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_USER_MAILING                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_EMAIL_ADDRESS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_ROLE                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_TEMPLATE_ROLE                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_ACCESS_RIGHT                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_ROLE_RIGHT                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_USER_ROLES                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_ORG_ROLE                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_ROLE_REL_ORG                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_RELATIVEROLE                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_USER_SITE_GROUPS                                                            
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_USER_SITES                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_USER_ORG                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_USER_SEC_ORGS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_USER_ORG_ANC                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_ORG_CHLDORG                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_ORG_ANCESTORS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_FOLDER                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_CHILD_FOLDER                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_ROLEFOLD_CHLD                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_USER_PREVPWD                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DAS_EVENT                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DAS_FORM                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DPS_EVENT                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DPS_PAGE_VISIT                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DPS_VIEW_ITEM                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DPS_CLICK                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DPS_REFERRER                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DPS_INBOUND                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DPS_ADMIN_REG                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DPS_PROPERTY                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DPS_ADMIN_PROP                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DPS_UPDATE                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DPS_ADMIN_UP                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_SCENARIO_VALUE                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_AUDIT_TRAIL                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_COLL_SCENARIO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_IND_SCENARIO                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_SCENARIO_STRS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_SCENARIO_BOOLS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_SCENARIO_LONGS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_SCENARIO_DBLS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_SCENARIO_DATES                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_USER_SCENARIO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_SCENARIO_INFO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_SCEN_MIG_INFO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_MIG_INFO_SEG                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_TEMPLATE_INFO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_COLL_TRANS                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_IND_TRANS                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DELETION                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_SERVER_ID                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_DEL_SEG_NAME                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_MIGRATION                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_MIG_SEG_NAME                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_XREF                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_PROFILE_SLOT                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_USER_SLOT                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_SLOT_ITEMS                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_SLOT_PRIORITY                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_MARKERS                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPS_USR_MARKERS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DRPT_STAGE_REACHED                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSS_USER_BPMARKERS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_COLL_SCENARIO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_IND_SCENARIO                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_SCENARIO_STRS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_SCENARIO_BOOLS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_SCENARIO_LONGS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_SCENARIO_DBLS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_SCENARIO_DATES                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_USER_SCENARIO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_SCENARIO_INFO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_SCEN_MIG_INFO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_MIG_INFO_SEG                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_TEMPLATE_INFO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_COLL_TRANS                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_IND_TRANS                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_DELETION                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_SERVER_ID                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_DEL_SEG_NAME                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_MIGRATION                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_MIG_SEG_NAME                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_XREF                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_PROFILE_SLOT                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_USER_SLOT                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_SLOT_ITEMS                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DSI_SLOT_PRIORITY                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DPI_SCENARIO_VALUE                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
ALT_USER                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
ALT_GROUP                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
ALT_USER_ALERT_REL                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
ALT_USER_PREF                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
ALT_USERPREF_REL                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
ALT_GEAR                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
ALT_GEAR_REL                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
ALT_GEAR_DEF                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
ALT_GEAR_DEF_REL                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
ALT_CHANNEL                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
ALT_CHAN_USR_REL                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
MEM_MEMBERSHIP_REQ                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_PAGE_VISIT                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
COMM_GEAR_ADD                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
COMM_GEAR_REM                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAGE_GEAR_ADD                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAGE_GEAR_REM                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_FOLDER                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_FOLDER_ACL                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CHILD_FOLDER                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_FLDR_LN_NAMES                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_FLDR_LN_DESCS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GEAR_PARAM                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GEAR_PRMVALS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_DEVICE_OUTPUTS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_DEVICE_OUTPUT                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_DISPLAY_MODES                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_TITLE_TEMPLATE                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GEAR_MODES                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GEAR_DEF                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GD_CPROPS                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GD_IPARAMS                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GD_UPARAMS                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GD_L10N_NAMES                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GD_L10N_DESCS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GEAR                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GEAR_ACL                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GEAR_IPARAMS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GEAR_LN_NAMES                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GEAR_LN_DESCS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_REGION_DEF                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_REGION                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_REGION_GEARS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_STYLE                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_STYL_LN_NAMES                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_STYL_LN_DESCS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_COL_PALETTE                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CPAL_LN_NAMES                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CPAL_LN_DESCS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_LAYOUT                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_LAYOUT_REGDEFS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_PAGE_TEMPLATE                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_PTPL_LN_NAMES                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_PTPL_LN_DESCS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_TEMPLATE                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_COMMUNITY                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_COMM_GEARS                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_COMM_GFLDRS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_COMM_ROLES                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_BASE_COMM_ROLE                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GEAR_ROLES                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_BASE_GEAR_ROLE                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_COMMUNITY_ACL                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_COMM_LNAMES                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_COMM_LDESCS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_PAGE                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_PAGE_LN_NAMES                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_PAGE_LN_DESCS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_PAGE_ACL                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_PAGE_REGIONS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CF_CHILD_ITEM                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CF_GFLDRS                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_PF_CHILD_ITEM                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_GDF_CHILD_ITEM                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_COMM_TEMPLATE                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_FOLDER                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_CHILD_FLDR                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_PAGEFOLDER                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_PAGE                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_REGION                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_PG_REGIONS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_REGION_GRS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_GEAR                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_GR_IPARAMS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_GR_LN_NAMES                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_GR_LN_DESCS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_GR_FLDRS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_GEARS                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_ALT_GEAR                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_ALT_GR_REL                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_ROLES                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_GR_ACL                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
PAF_CT_GR_ROLES                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_HISTORY                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_HIS_ACT_PARM                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_TASKINFO                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_AGENT_TRNPRT                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_AGENT                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_TARGET                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_TR_DEST                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_TABLE_MAPPING                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_TBL_MAP_ONLN                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_TABLE_MAP_SW                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_TR_REP_TBL_MP                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_TOPOLOGY                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_TL_TARGETS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_TR_AGENTS                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PRINC_ASSET                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_INCLUD_ASSET                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_EXCLUD_ASSET                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_DEST_MAP                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PROJECT                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PRJ_TARGT_WS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PR_TG_STATUS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PRJ_TG_SNSHT                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PR_TG_DP_TS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PR_TG_DP_ID                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PR_TG_AP_TS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PR_HISTORY                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PROCESS                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PROC_PRV_PRJ                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PROC_HISTORY                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PROC_TASKINFO                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_DEPLOYMENT                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_DEPLOY_PROJ                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_DEP_ERR_PARM                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_DEP_LOG                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_PROCESS_DATA                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
AVM_DEVLINE                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
AVM_WORKSPACE                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
AVM_ASSET_LOCK                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_FILE_FOLDER                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_FILE_ASSET                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_TEXT_FILE                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_BINARY_FILE                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_COLL_WORKFLOW                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_IND_WORKFLOW                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WORKFLOW_STRS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WORKFLOW_BLS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WORKFLOW_LNGS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WORKFLOW_DBLS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WORKFLOW_DATS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WORKFLOW_RIS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WORKFLOW_VFS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WORKFLOW_INFO                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WF_MIG_INFO                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WF_MG_INF_SEG                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WF_TEMPL_INFO                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WF_COLL_TRANS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WF_IND_TRANS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WF_DELETION                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WF_DEL_SEGS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WF_MIGRATION                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WF_MIG_SEGS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_WF_SERVER_ID                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_INT_USER                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
EPUB_INT_PRJ_HIST                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_IM                                                                         
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_FH                                                                         
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_MODE                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_IVM                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_IM2IVM_REL                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_IV                                                                         
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_PV                                                                         
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_IVM2PVM_REL                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_PVM                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_ATTRVAL                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_ATTRVAL_REL                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_CATTRVAL_REL                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_IV2IVAD_REL                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_IVATTRDEF                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_PV2PVAD_REL                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
VMAP_PVATTRDEF                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ORDER                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SHIP_GROUP                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_PAY_GROUP                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ITEM                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_RELATIONSHIP                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_REL_ORDERS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ORDER_INST                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ORDER_SG                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ORDER_PG                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ORDER_ITEM                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ORDER_REL                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SHIP_INST                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_HRD_SHIP_GRP                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ELE_SHIP_GRP                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ISP_SHIP_GRP                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SHIP_ADDR                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_HAND_INST                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_GIFT_INST                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SG_HAND_INST                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_PAY_INST                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_CONFIG_ITEM                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SUBSKU_ITEM                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ITEM_CI                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_GIFT_CERT                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_STORE_CRED                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_CREDIT_CARD                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_BILL_ADDR                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_PAY_STATUS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_CC_STATUS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_GC_STATUS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SC_STATUS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_AUTH_STATUS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_DEBIT_STATUS                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_CRED_STATUS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SHIPITEM_REL                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_REL_RANGE                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_PAYITEM_REL                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_PAYSHIP_REL                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_PAYORDER_REL                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_AMOUNT_INFO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ORDER_PRICE                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ITEM_PRICE                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_TAX_PRICE                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SHIP_PRICE                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_AMTINFO_ADJ                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_PRICE_ADJUST                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SHIPITEM_SUB                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_TAXSHIPITEM                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_NTAXSHIPITEM                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SHIPITEM_TAX                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ITMPRICE_DET                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_DET_PRICE                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_DET_RANGE                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ORDER_ADJ                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_MANUAL_ADJ                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_SCHED_ORDER                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_SCHED_CLONE                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SCHERR_AUX                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SCHED_ERROR                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_SCHD_ERRMSG                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_APPROVERIDS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_AUTHAPPRIDS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_APPRSYSMSGS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_APPR_MSGS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_INVOICE_REQ                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_COST_CENTER                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_ORDER_CC                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_CCITEM_REL                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_CCSHIP_REL                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_CCORDER_REL                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBCPP_PMT_REQ                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CART_EVENT                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SUBMT_ORD_EVT                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PROM_USED_EVT                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_ORD_MERGE_EVT                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PROMO_RVKD                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PROMO_GRNTD                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_ORDER_MARKERS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_GWP_ORDER_MARKERS                                                           
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_COMMERCE_ITEM_MARKERS                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_GWP_ITEM_MARKERS                                                          
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_GIFTLIST                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_GIFTINST                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_GIFTITEM                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_GIFTLIST_ITEM                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_USER_WISHLIST                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_USER_GIFTLIST                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_USER_OTHERLIST                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_INVENTORY                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_INV_ATP                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBC_INV_DELIVERY                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBC_INV_PMT_TERMS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBC_INVOICE                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBC_CONTRACT                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBC_CONTRACT_TERM                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_ORD_ABANDON                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_USER_ABANDONED                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DRPT_CONV_ORDER                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DRPT_SESSION_ORD                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
WB_WORKBENCH                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
WB_TILE                                                                         
cascade constraints;                                                            
                                                                                
drop table                                                                      
WB_TILE_ITEM                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
WB_WBENCH_TILE                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
WB_REPORT                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
WB_BUCKET                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
WB_BUCKET_ITEM                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
WB_REPORT_ITEM                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
WB_REPORT_MSG                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_FOLDER                                                                      
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_MEDIA                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_MEDIA_EXT                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_MEDIA_BIN                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_MEDIA_TXT                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CATEGORY                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CATEGORY_ACL                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRODUCT                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRODUCT_ACL                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKU                                                                         
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_GROUPS                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_CHLDPRD                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_CHLDCAT                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_ANCESTORS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_RLTDCAT                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_KEYWRDS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_MEDIA                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_AUX_MEDIA                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_KEYWRDS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_MEDIA                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_AUX_MEDIA                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_CHLDSKU                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_SKUATTR                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_GROUPS                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_RLTDPRD                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_UPSLPRD                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_ANCESTORS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKU_ATTR                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKU_LINK                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKU_BNDLLNK                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKU_MEDIA                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKU_AUX_MEDIA                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKU_REPLACE                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKU_CONF                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CONFIG_PROP                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CONF_OPTIONS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CONFIG_OPT                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_FOREIGN_CAT                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBC_MANUFACTURER                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DBC_MEASUREMENT                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRM_FOLDER                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_STACKING_RULE                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_EXCL_STACKING_RULES                                                         
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PROMOTION                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PROMO_MEDIA                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_DISCOUNT_PROMO                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PROMO_UPSELL                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_UPSELL_ACTION                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CLOSE_QUALIF                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRM_CLS_QLF                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRM_SITES                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRM_SITE_GRPS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRM_TPL_VALS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRM_CLS_VALS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_UPSELL_PRODS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_EXCL_PROMOTIONS                                                             
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_INCL_PROMOTIONS                                                             
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_CLAIMABLE                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_GIFTCERT                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_STORECRED_CLM                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_CP_FOLDER                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_COUPON                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_COUPON_INFO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_COUPON_BATCH                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCSPP_BATCH_CLAIMABLE                                                           
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRICE_LIST                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_COMPLEX_PRICE                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRICE                                                                       
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRICE_LEVELS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRICE_LEVEL                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_GEN_FOL_PL                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CHILD_FOL_PL                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PLFOL_CHLD                                                                  
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SITE                                                                        
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CATALOG                                                                     
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_ROOT_CATS                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_ALLROOT_CATS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_ROOT_SUBCATS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CATEGORY_INFO                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRODUCT_INFO                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKU_INFO                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_SUBCATS                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_SUBROOTS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_CATINFO                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CATINFO_ANC                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_PRDINFO                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRDINFO_RDPRD                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRDINFO_ANC                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKU_SKUINFO                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKUINFO_RPLC                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_GEN_FOL_CAT                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CHILD_FOL_CAT                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CATFOL_CHLD                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CATFOL_SITES                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_DIR_ANC_CTLGS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_IND_ANC_CTLGS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CTLG_ANC_CATS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_ANC_CATS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_PRNT_CATS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_PRNT_CATS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_ANC_CATS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CAT_CATALOGS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRD_CATALOGS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKU_CATALOGS                                                                
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CATALOG_SITES                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_CATEGORY_SITES                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_PRODUCT_SITES                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_SKU_SITES                                                                   
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_LOCATION                                                                    
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_LOCATION_SITES                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_LOC_SITE_GRPS                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_LOCATION_STORE                                                              
cascade constraints;                                                            
                                                                                
drop table                                                                      
DCS_LOCATION_ADDR                                                               
cascade constraints;                                                            
                                                                                
drop table                                                                      
SRCH_SITE_CNTNT_PRI                                                             
cascade constraints;                                                            
                                                                                
drop table                                                                      
SRCH_SITE_CNTNT                                                                 
cascade constraints;                                                            
                                                                                
drop table                                                                      
CLOTHINGSTORE_CONTACT                                                           
cascade constraints;                                                            
                                                                                
drop table                                                                      
CLOTHINGSTORE_SITE_CONTACT                                                      
cascade constraints;                                                            
                                                                                
