create or replace package wksp_doagmcp.ut_ocg_groups_eu as
  --%suite(OCG_GROUPS_EU insert tests)

  --%test(Insert valid row succeeds)
    procedure insert_valid_row;

  --%test(Insert missing required column fails)
    procedure insert_missing_required;

end;
/


-- sqlcl_snapshot {"hash":"688242a27adc3d484dd6426734c5641fd645e099","type":"PACKAGE_SPEC","name":"UT_OCG_GROUPS_EU","schemaName":"WKSP_DOAGMCP","sxml":""}