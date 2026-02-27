# PROMPTS 

## Data Model & Git
Erstelle direkt in der Datenbank ein Datenmodell mit Oracle Community Gruppen aus Europa als Haupttabelle. Stelle sicher das die Webseite und das Land hinterlegt sind. Alle Events aus 2026 sollen eine Child Tabelle dazu gespeichert werden. Bitte kreiere auch direkt reale Events der realen Usergruppen.


Kannst Du mir basierend darauf eine APEX applikation als .sql file erzeugen, die ich dann über den ORACLE APEX UI Import auch importieren kann?


2. Versuch:
Kannst Du mir basierend darauf eine APEX applikation als .sql file erzeugen mit einer simplen Kalendarseite, die ich dann über den ORACLE APEX UI Import auch importieren kann? nehme als Beispiel nimm die f107.sql Datei und speichere die neu entworfene .sql Datei in DiY_setup_MCP/src/APEX_App


## Database Structure
DOAGMCP
doagmcp


erstelle das ddl und das DML für die Tabelle OCG_GROUPS_EU von der Originaltabelle im Schema und speichere es im src Verzeichnis meines branchs ab.

erstelle das ddl und das DML für die Tabelle OCG_GROUP_EVENTS_2026 von der Originaltabelle im Schema und speichere es im src Verzeichnis meines branchs ab.

erstelle das ddl und das DML für die Tabelle OCG_COUNTRY_CODE_LOOKUP von der Originaltabelle im Schema und speichere es im src Verzeichnis meines branchs ab.


## APEX

bitte baue mir eine applikation mit dashboard, interactive report, faceted search und interactive grid basieren auf den Tabellen OCG_GROUPS_EU, OCG_GROUP_EVENTS_2026, OCG_COUNTRY_CODE_LOOKUP. Bitte keinen Kalender.


## SQLcl Project

SQL> project init -name DOAGMCP -schemas WKSP_DOAGMCP -directory .
    ------------------------
    PROJECT DETAILS
    ------------------------
    Project name:    DOAGMCP 
    Schema(s):       WKSP_DOAGMCP 
    Directory:       /Users/SOMEYER/GitHub/DiY_articles/DiY_setup_MCP/. 
    Connection name: ALWAYS_FREE_DOAGMCP 
    Project root:     .
    Your project has been successfully created


SQL> project export
    The current connection WKSP_DOAGMCP will be used for all operations
    The current connection WKSP_DOAGMCP will be used for all operations
    *** TABLES ***
    *** OBJECT_GRANTS ***
    *** REF_CONSTRAINTS ***
    *** APEX_APPLICATIONS ***
    Exporting Workspace DOAGMCP - application 132:OCG EU Gruppen & Events Hub
    -------------------------------
    APEX_APPLICATION              1
    GRANT                         1
    REF_CONSTRAINT                1
    TABLE                         3
    -------------------------------
    Exported 6 objects
    Elapsed 63 sec
