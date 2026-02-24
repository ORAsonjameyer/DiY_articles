create or replace package wksp_mlegenai.sample_data_pkg as
    procedure generate_sample_email_recipients (
        p_num_rows number
    ) as
        mle module sample_data_module signature 'generateSampleRecipients';
    procedure generate_sample_email (
        p_num_rows number
    ) as
        mle module sample_data_module signature 'generateSampleEmail';
end sample_data_pkg;
/


-- sqlcl_snapshot {"hash":"7307e43d67b6271401634c1f7958fc2f745aceb4","type":"PACKAGE_SPEC","name":"SAMPLE_DATA_PKG","schemaName":"WKSP_MLEGENAI","sxml":""}