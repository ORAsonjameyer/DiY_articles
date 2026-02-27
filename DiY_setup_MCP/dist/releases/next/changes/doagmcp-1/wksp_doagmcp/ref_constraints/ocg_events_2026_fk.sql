-- liquibase formatted sql
-- changeset WKSP_DOAGMCP:1772206516102 stripComments:false  logicalFilePath:doagmcp-1/wksp_doagmcp/ref_constraints/ocg_events_2026_fk.sql
-- sqlcl_snapshot DiY_setup_MCP/src/database/wksp_doagmcp/ref_constraints/ocg_events_2026_fk.sql:null:0c6dfcf2f962b234c1dc2c546c127f9d0dbd721d:create

alter table wksp_doagmcp.ocg_group_events_2026
    add constraint ocg_events_2026_fk
        foreign key ( group_id )
            references wksp_doagmcp.ocg_groups_eu ( group_id )
                on delete cascade
        enable;

