create index wksp_mlegenai.email_content_indx_1 on
    wksp_mlegenai.eml_email_content (
        recipient_id
    );


-- sqlcl_snapshot {"hash":"951507575121c2a584123545e0c40b4843270c86","type":"INDEX","name":"EMAIL_CONTENT_INDX_1","schemaName":"WKSP_MLEGENAI","sxml":"\n  <INDEX xmlns=\"http://xmlns.oracle.com/ku\" version=\"1.0\">\n   <SCHEMA>WKSP_MLEGENAI</SCHEMA>\n   <NAME>EMAIL_CONTENT_INDX_1</NAME>\n   <TABLE_INDEX>\n      <ON_TABLE>\n         <SCHEMA>WKSP_MLEGENAI</SCHEMA>\n         <NAME>EML_EMAIL_CONTENT</NAME>\n      </ON_TABLE>\n      <COL_LIST>\n         <COL_LIST_ITEM>\n            <NAME>RECIPIENT_ID</NAME>\n         </COL_LIST_ITEM>\n      </COL_LIST>\n      \n   </TABLE_INDEX>\n</INDEX>"}