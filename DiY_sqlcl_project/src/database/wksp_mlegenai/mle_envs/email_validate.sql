create or replace mle env wksp_mlegenai.email_validate imports ( 'validator-module' module wksp_mlegenai.validator_module, 'email-subject-validation'
module wksp_mlegenai.email_subject_validation, 'sample-data-module' module wksp_mlegenai.sample_data_module );


-- sqlcl_snapshot {"hash":"9cd8b82190de29467218697d2dedfcd6d2df7e48","type":"MLE_ENV","name":"EMAIL_VALIDATE","schemaName":"WKSP_MLEGENAI","sxml":""}