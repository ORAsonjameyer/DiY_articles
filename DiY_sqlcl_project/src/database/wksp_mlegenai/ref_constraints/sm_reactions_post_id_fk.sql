alter table wksp_mlegenai.sm_reactions
    add constraint sm_reactions_post_id_fk
        foreign key ( post_id )
            references wksp_mlegenai.sm_posts ( id )
                on delete cascade
        enable;


-- sqlcl_snapshot {"hash":"9af1a442dc8f4087b6c7daa9fd851acb5eb6112f","type":"REF_CONSTRAINT","name":"SM_REACTIONS_POST_ID_FK","schemaName":"WKSP_MLEGENAI","sxml":""}