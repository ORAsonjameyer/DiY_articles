# Do it yourself: updated Developer Playground for Oracle 26ai, APEX 24.2 & ORDS

🆕 **Update November, 2025:** This guide now uses DBfree 23.26.0, ORDS 25.3 latest, APEX 24.2, Podman 5.5.2  
🆕 **Update July 2025:** This guide now uses DBfree 23.8 latest, ORDS 25.2 latest, APEX 24.2, Podman 5.5.1  
🆕 **Created April 2025:** This guide now uses DBfree 23.6, APEX 24.1, Podman 5.3.2

Oracle has set a major milestone with the release of Database 26ai. If you're eager to test APEX 24.2 with the latest stack, this guide has you covered. Whether you're exploring new features or just need a quick dev environment, this containerized Podman setup delivers speed, isolation, and simplicity.

In real-world development, it's common to work with multiple APEX versions in parallel. Containers make this super easy — and in this guide, I'll show you how to spin everything up in no time using the latest versions of Oracle Database Free, ORDS, SQLcl, and APEX.

I personally use Podman and Podman Desktop on my MacBook. For editing YAML files, I work with VSCode — and if you're on Windows, make sure to use a proper editor like VSCode or Notepad++ and save your YAML files with UTF-8 encoding, LF line endings, and no quotes around booleans.

## Why Podman? Why Compose?

Podman is an open-source container engine similar to Docker but rootless and daemonless. Podman Compose lets you run multi-container setups using `docker-compose.yml` files — a great fit for developers transitioning from Docker.

This guide provides a lightweight, high-speed approach to setting up a full-stack environment with Oracle Database 23ai, ORDS, and APEX.

## Prerequisites: Podman Setup (macOS)

Tested with **Podman 5.5.2** on macOS. Use Podman Desktop for the best experience.

⚠️ Increase the Podman VM memory to at least **4 GB**, otherwise APEX installation may fail.

Install podman-compose:

```
brew install podman-compose
```

Upgrade Podman:

```
brew update && brew upgrade podman
brew upgrade --cask podman-desktop
```

If Podman Desktop still shows an older engine version, recreate your VM using:

```
podman machine init
```

## 📦 Software Sources

- Oracle Database Free 26ai  
- Oracle REST Data Services (ORDS)

## Download Container Images

### Database

```
podman pull ghcr.io/gvenzl/oracle-free:23.26.0
```

Or latest:

```
podman pull ghcr.io/gvenzl/oracle-free:latest
```

### ORDS

```
podman pull container-registry.oracle.com/database/ords:25.2.0
```

## 🛠️ Defining the Compose Setup

Place this `compose.yml` in your dev folder (example: `/Users/{username}/dev/apex`).

```
services:
    oraclefree:
        image: ghcr.io/gvenzl/oracle-free:latest
        ports:
            - 1521:1521
        volumes:
            - ora_db_vol:/opt/oracle/oradata
        networks:
            - ora_app_network
        healthcheck:
            test: [ "CMD", "/opt/oracle/healthcheck.sh" ]
            interval: 10s
            timeout: 5s
            retries: 10
        environment:
            - ORACLE_PASSWORD=${ORACLE_PASSWORD}

    ords:
        hostname: ords-node
        image: container-registry.oracle.com/database/ords:latest
        environment:
            - CONN_STRING=${CONN_STRING}
            - ORACLE_PWD=${ORACLE_PWD}
        volumes:
            - ords_config:/etc/ords/config
            - ./apex-images:/opt/oracle/apex/images
        ports:
            - ${HOST_PORT}:8080
        depends_on:
            oraclefree:
                condition: service_healthy
        networks:
            - ora_app_network

volumes:
    ora_db_vol:
        name: apex_ora_db_vol
    ords_config:
        name: apex_ords_config

networks:
    ora_app_network:
```

## `.env` File

```
ORACLE_PASSWORD=YourSecurePassword123
CONN_STRING=oraclefree/freepdb1
ORACLE_PWD=YourSecurePassword123
HOST_PORT=8181
```

## Bootstrapping the Database

Start only the database:

```
podman-compose up -d oraclefree
```

## Install APEX

Copy APEX files:

```
podman cp ~/Downloads/apex-latest apex_oraclefree_1:/tmp/
```

Open a shell:

```
podman exec -it apex_oraclefree_1 bash
```

Start SQL*Plus:

```
sqlplus 'sys/<your_pwd>@localhost:1521/freepdb1 as sysdba'
```

Create tablespace:

```
CREATE TABLESPACE apex
  DATAFILE '/opt/oracle/oradata/FREE/FREEPDB1/apex_001.dbf'
  SIZE 300M
  AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;
```

Install APEX:

```
@/tmp/apex-latest/apex/apexins.sql APEX APEX TEMP /i/
```

Unlock APEX_PUBLIC_USER:

```
alter user apex_public_user account unlock;
```

Reset ADMIN password:

```
@apxchpwd
```

## APEX Static Files

```
mkdir -p apex-images
cp -r /Users/SOMEYER/dev/apex/apex-latest/apex/images/* apex-images/
```

Volume mount:

```
- ./apex-images:/opt/oracle/apex/images
```

## Start ORDS

```
podman-compose up ords
```

Access APEX:

http://localhost:8181/ords/

## Tips: Starting & Stopping

```
podman-compose start
podman-compose stop
podman-compose restart
podman-compose up -d
podman-compose down
podman ps -a
podman rm -f apex_ords_1
podman volume rm apex_ora_db_vol apex_ords_config
podman logs -f apex_oraclefree_1
podman logs -f apex_ords_1
```

## Database Shell

```
podman exec -it apex_oraclefree_1 bash
```

## Test SQL*Plus

```
sqlplus sys/'yourSecurePasswordHere'@localhost:1521/FREEPDB1 as sysdba
```

## Podman Desktop

Check containers visually using Podman Desktop.

---

More help:  
Oracle REST Data Services (ORDS) Developer  
podman-compose
