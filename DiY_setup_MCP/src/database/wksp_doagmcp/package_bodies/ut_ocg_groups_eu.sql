create or replace package body wksp_doagmcp.ut_ocg_groups_eu as

    function uniq (
        p_prefix varchar2
    ) return varchar2 is
    begin
        return p_prefix
               || '_'
               || to_char(systimestamp, 'YYYYMMDDHH24MISSFF3');
    end;

    procedure insert_valid_row is
        l_group_id   wksp_doagmcp.ocg_groups_eu.group_id%type;
        l_group_name wksp_doagmcp.ocg_groups_eu.group_name%type;
    begin
        l_group_name := uniq('UT_GROUP');
        insert into wksp_doagmcp.ocg_groups_eu (
            group_name,
            country_code,
            country_name,
            website_url
        ) values ( l_group_name,
                   'DE',
                   'Germany',
                   'https://example.org' ) returning group_id into l_group_id;

        ut.expect(l_group_id).to_be_not_null;
    end;

    procedure insert_missing_required is
        l_sqlcode number := null;
    begin
        insert into wksp_doagmcp.ocg_groups_eu (
            country_code,
            country_name,
            website_url
        ) values ( 'DE',
                   'Germany',
                   'https://example.org' );

    exception
        when others then
            l_sqlcode := sqlcode;
    end;

end;
/


-- sqlcl_snapshot {"hash":"48d610312ae1463bbbd666ad2c2d8e00fb6fd18c","type":"PACKAGE_BODY","name":"UT_OCG_GROUPS_EU","schemaName":"WKSP_DOAGMCP","sxml":""}