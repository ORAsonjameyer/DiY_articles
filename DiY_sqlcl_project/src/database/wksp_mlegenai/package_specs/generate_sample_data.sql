create or replace package wksp_mlegenai.generate_sample_data as

   /**
    * Generates a list of sample email recipients.
    * This procedure is implemented using Oracle's Machine Learning Engine (MLE),
    * which allows JavaScript execution inside the database.
    *
    * @param p_num_rows  The number of sample recipients to generate.
    */
    procedure generate_sample_email_recipients (
        p_num_rows number
    ) as mle module new_bundle_data signature 'generateSampleRecipients';

   /**
    * Generates a list of sample emails.
    * This procedure is also executed using Oracle MLE, utilizing 
    * JavaScript functions from the specified module.
    *
    * @param p_num_rows  The number of sample emails to generate.
    */
    procedure generate_sample_email (
        p_num_rows number
    ) as mle module new_bundle_data signature 'generateSampleEmail';
end generate_sample_data;
/


-- sqlcl_snapshot {"hash":"1bde77f92588e59761a0622e16c054f96901e24a","type":"PACKAGE_SPEC","name":"GENERATE_SAMPLE_DATA","schemaName":"WKSP_MLEGENAI","sxml":""}