-- liquibase formatted sql
-- changeset  SqlCl:1772206626739 stripComments:false logicalFilePath:doagmcp-1/_custom/sample-data.sql
-- sqlcl_snapshot dist/releases/next/changes/doagmcp-1/_custom/sample-data.sql:null:null:custom


set echo ON

INSERT INTO ocg_groups_eu (group_id, group_name, country_code, country_name, city, website_url, contact_email, focus_area, active_flag, created_at, updated_at) VALUES (1,'Oracle Developer Community - UK (UKOUG)','GB','United Kingdom','London','https://www.ukoug.org','hello@ukoug.org','Enterprise Applications, Cloud','Y',TO_TIMESTAMP('2026-02-24 16:35:50','YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO ocg_groups_eu (group_id, group_name, country_code, country_name, city, website_url, contact_email, focus_area, active_flag, created_at, updated_at) VALUES (2,'OUG Norway','NO','Norway','Oslo','https://www.ougn.no','styret@ougn.no','Database, Cloud, DevOps','Y',TO_TIMESTAMP('2026-02-24 16:35:53','YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO ocg_groups_eu (group_id, group_name, country_code, country_name, city, website_url, contact_email, focus_area, active_flag, created_at, updated_at) VALUES (3,'Swiss Oracle User Group (SOUG)','CH','Switzerland','Bern','https://www.soug.ch','info@soug.ch','Oracle Database, Analytics','Y',TO_TIMESTAMP('2026-02-24 16:35:55','YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO ocg_groups_eu (group_id, group_name, country_code, country_name, city, website_url, contact_email, focus_area, active_flag, created_at, updated_at) VALUES (4,'nlOUG - Netherlands Oracle User Group','NL','Netherlands','Utrecht','https://www.nloug.nl','info@nloug.nl','Oracle Cloud, APEX','Y',TO_TIMESTAMP('2026-02-24 16:35:58','YYYY-MM-DD HH24:MI:SS'),NULL);
INSERT INTO ocg_groups_eu (group_id, group_name, country_code, country_name, city, website_url, contact_email, focus_area, active_flag, created_at, updated_at) VALUES (5,'DOAG','DE','Germany','Berlin','https://www.doag.org','info@doag.org','Oracle, APEX','Y',TO_TIMESTAMP('2026-02-24 16:35:58','YYYY-MM-DD HH24:MI:SS'),NULL);
COMMIT;


INSERT INTO ocg_group_events_2026 (event_id, group_id, event_name, event_type, start_date, end_date, city, venue, registration_url, agenda_url, created_at) VALUES (1,5,'DOAG Conference and Exhibition 2026','Conference',DATE '2026-11-17',DATE '2026-11-19','Nürnberg','NürnbergConvention Center NCC Ost','https://www.doag.org/en/events/doag-conference-2026','https://www.doag.org/en/events/doag-conference-2026/agenda',TO_TIMESTAMP('2026-02-24 21:56:40','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ocg_group_events_2026 (event_id, group_id, event_name, event_type, start_date, end_date, city, venue, registration_url, agenda_url, created_at) VALUES (2,1,'UKOUG Breakthrough 2026','Conference',DATE '2026-12-01',DATE '2026-12-03','Birmingham','International Convention Centre','https://www.ukoug.org/events/breakthrough-2026','https://www.ukoug.org/events/breakthrough-2026/agenda',TO_TIMESTAMP('2026-02-24 21:56:40','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ocg_group_events_2026 (event_id, group_id, event_name, event_type, start_date, end_date, city, venue, registration_url, agenda_url, created_at) VALUES (3,2,'OUGN Technology Cruise 2026','Conference',DATE '2026-04-16',DATE '2026-04-18','Oslo','Color Fantasy Cruise Ship','https://www.ougn.no/events/technology-cruise-2026','https://www.ougn.no/events/technology-cruise-2026/agenda',TO_TIMESTAMP('2026-02-24 21:56:40','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ocg_group_events_2026 (event_id, group_id, event_name, event_type, start_date, end_date, city, venue, registration_url, agenda_url, created_at) VALUES (4,3,'SOUG Technology Day 2026','Conference',DATE '2026-06-10',DATE '2026-06-10','Bern','Kursaal Bern','https://www.soug.ch/events/technology-day-2026','https://www.soug.ch/events/technology-day-2026/agenda',TO_TIMESTAMP('2026-02-24 21:56:40','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ocg_group_events_2026 (event_id, group_id, event_name, event_type, start_date, end_date, city, venue, registration_url, agenda_url, created_at) VALUES (5,4,'nlOUG Tech Experience 2026','Conference',DATE '2026-05-07',DATE '2026-05-08','Utrecht','DeFabrique Utrecht','https://www.nloug.nl/evenementen/tech-experience-2026','https://www.nloug.nl/evenementen/tech-experience-2026/agenda',TO_TIMESTAMP('2026-02-24 21:56:40','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO ocg_group_events_2026 (event_id, group_id, event_name, event_type, start_date, end_date, city, venue, registration_url, agenda_url, created_at) VALUES (6,5,'doagmcp','doagmcp',DATE '2026-02-27',DATE '2026-02-28',NULL,NULL,NULL,NULL,NULL);
COMMIT;


INSERT INTO ocg_country_code_lookup (country_code_id, country_code) VALUES (1,'DE');
INSERT INTO ocg_country_code_lookup (country_code_id, country_code) VALUES (2,'NO');
INSERT INTO ocg_country_code_lookup (country_code_id, country_code) VALUES (3,'GB');
INSERT INTO ocg_country_code_lookup (country_code_id, country_code) VALUES (4,'CH');
INSERT INTO ocg_country_code_lookup (country_code_id, country_code) VALUES (5,'NL');
COMMIT;