alter table wksp_doagmcp.ocg_group_events_2026
    add constraint ocg_events_2026_fk
        foreign key ( group_id )
            references wksp_doagmcp.ocg_groups_eu ( group_id )
                on delete cascade
        enable;


-- sqlcl_snapshot {"hash":"0c6dfcf2f962b234c1dc2c546c127f9d0dbd721d","type":"REF_CONSTRAINT","name":"OCG_EVENTS_2026_FK","schemaName":"WKSP_DOAGMCP","sxml":""}