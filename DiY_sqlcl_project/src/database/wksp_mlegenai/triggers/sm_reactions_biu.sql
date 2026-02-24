create or replace editionable trigger wksp_mlegenai.sm_reactions_biu before
    insert or update on wksp_mlegenai.sm_reactions
    for each row
begin
    if inserting then
        :new.created := sysdate;
        :new.created_by := coalesce(
            sys_context('APEX$SESSION', 'APP_USER'),
            user
        );
    end if;

    :new.updated := sysdate;
    :new.updated_by := coalesce(
        sys_context('APEX$SESSION', 'APP_USER'),
        user
    );
end sm_reactions_biu;
/

alter trigger wksp_mlegenai.sm_reactions_biu enable;


-- sqlcl_snapshot {"hash":"3de8451e5c0785143b41af996dcda4f343e9908b","type":"TRIGGER","name":"SM_REACTIONS_BIU","schemaName":"WKSP_MLEGENAI","sxml":""}