create or replace editionable trigger wksp_mlegenai.eml_recipients_biu before
    insert or update on wksp_mlegenai.eml_recipients
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

end eml_recipients_biu;
/

alter trigger wksp_mlegenai.eml_recipients_biu enable;


-- sqlcl_snapshot {"hash":"6aa719ac98056d76f2378c9e19115f1c710fe2f1","type":"TRIGGER","name":"EML_RECIPIENTS_BIU","schemaName":"WKSP_MLEGENAI","sxml":""}