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


-- sqlcl_snapshot {"hash":"f57dd4f64e2d74ea182fe9417e6025ebd1d5e1ac","type":"TRIGGER","name":"EML_EMAIL_CONTENT_BIU","schemaName":"WKSP_MLEGENAI","sxml":""}