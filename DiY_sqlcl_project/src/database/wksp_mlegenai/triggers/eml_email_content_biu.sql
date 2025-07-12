create or replace editionable trigger wksp_mlegenai.eml_email_content_biu before
    insert or update on wksp_mlegenai.eml_email_content
    for each row
begin
    :new.updated_on := sysdate;
    :new.updated_by := coalesce(
        sys_context('APEX$SESSION', 'APP_USER'),
        user
    );
    if inserting then
        :new.row_version := 1;
        :new.created_on := :new.updated_on;
        :new.created_by := :new.updated_by;
    elsif updating then
        :new.row_version := nvl(:old.row_version,
                                0) + 1;
    end if;

end eml_email_content_biu;
/

alter trigger wksp_mlegenai.eml_email_content_biu enable;


-- sqlcl_snapshot {"hash":"b9fc60bb7057427dad0ae3988e023c344ad3b2ad","type":"TRIGGER","name":"EML_EMAIL_CONTENT_BIU","schemaName":"WKSP_MLEGENAI","sxml":""}