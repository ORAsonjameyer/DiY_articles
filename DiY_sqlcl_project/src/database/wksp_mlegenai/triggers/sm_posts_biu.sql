create or replace editionable trigger wksp_mlegenai.sm_posts_biu before
    insert or update on wksp_mlegenai.sm_posts
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
end sm_posts_biu;
/

alter trigger wksp_mlegenai.sm_posts_biu enable;


-- sqlcl_snapshot {"hash":"9b722546b9c1e7605d666c012a59344511f33548","type":"TRIGGER","name":"SM_POSTS_BIU","schemaName":"WKSP_MLEGENAI","sxml":""}