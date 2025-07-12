alter table wksp_mlegenai.eml_email_content
    add constraint eml_email_content_recipient_fk
        foreign key ( recipient_id )
            references wksp_mlegenai.eml_recipients ( id )
                on delete cascade
        enable;


-- sqlcl_snapshot {"hash":"01a22a3a25365984967e3e92486917d6aee58286","type":"REF_CONSTRAINT","name":"EML_EMAIL_CONTENT_RECIPIENT_FK","schemaName":"WKSP_MLEGENAI","sxml":""}