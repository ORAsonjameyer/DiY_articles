-- liquibase formatted sql
-- changeset WKSP_DOAGMCP:1772209983869 stripComments:false  logicalFilePath:doagmcp2/wksp_doagmcp/package_specs/ut_ocg_groups_eu.sql
-- sqlcl_snapshot DiY_setup_MCP/src/database/wksp_doagmcp/package_specs/ut_ocg_groups_eu.sql:null:688242a27adc3d484dd6426734c5641fd645e099:create

create or replace package wksp_doagmcp.ut_ocg_groups_eu as
  --%suite(OCG_GROUPS_EU insert tests)

  --%test(Insert valid row succeeds)
    procedure insert_valid_row;

  --%test(Insert missing required column fails)
    procedure insert_missing_required;

end;
/

