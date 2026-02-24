alter table wksp_mlegenai.eml_email_content
    add constraint eml_email_content_recipient_fk
        foreign key ( recipient_id )
            references wksp_mlegenai.eml_recipients ( id )
                on delete cascade
        enable;


-- sqlcl_snapshot {"hash":"1efa1504a25fc104f214e9326f4beaf6a7a4d12a","type":"REF_CONSTRAINT","name":"EML_EMAIL_CONTENT_RECIPIENT_FK","schemaName":"WKSP_MLEGENAI","sxml":""}