Do it yourself: updated Developer Playground for Oracle 26ai, APEX 24.2 & ORDS

🆕 Update November, 2025: This guide now uses DBfree 23.26.0, ORDS 25.3 latest, APEX 24.2, Podman 5.5.2

🆕 Update Juli 2025: This guide now uses DBfree 23.8 latest, ORDS 25.2 latest, APEX 24.2, Podman 5.5.1

🆕 Created April 2025: This guide now uses DBfree 23.6, APEX 24.1, Podman 5.3.2

Oracle has set a major milestone with the release of Database 26ai. If you’re eager to test APEX 24.2 with the latest stack, this guide has you covered. Whether you’re exploring new features or just need a quick dev environment, this containerized Podman setup delivers speed, isolation, and simplicity.

In real-world development, it’s common to work with multiple APEX versions in parallel. Containers make this super easy — and in this guide, I’ll show you how to spin everything up in no time using the latest versions of Oracle Database Free, ORDS, SQLcl, and APEX.

I personally use Podman and Podman Desktop on my MacBook. For editing YAML files, I work with VSCode — and if you’re on Windows, make sure to use a proper editor like VSCode or Notepad++ and save your YAML files with UTF-8 encoding, LF line endings, and no quotes around booleans. Podman Desktop is a great visual aid with logs, terminals, and container insights, but I’ll also walk you through all steps via the terminal for those who prefer the CLI. Let’s get started and bring this stack to life!


Why Podman? Why Compose?

Podman is an open-source container engine that lets you build, run, and manage containers — similar to Docker, but without a daemon. It uses the same image format and supports most of the familiar Docker commands. The key difference: Podman runs containers as regular processes, making it more secure and ideal for rootless environments.

Podman Compose is the Podman-native counterpart to Docker Compose. It allows you to run multi-container setups using docker-compose.yml files. It translates your defined services, networks, and volumes into Podman pods and containers. While it's not a feature-for-feature drop-in replacement, it's a great fit for developers moving from Docker to Podman—especially in rootless or systemd-based environments.

This guide shows you a lightweight, high-speed approach to setting up a full-stack development environment with Oracle Database 23ai, ORDS, and APEX — all powered by Compose. One command spins everything up, with automatic networking and service discovery baked in.

Prerequisites: Podman Setup (macOS)
This setup was developed and tested on macOS using Podman Desktop as the container engine. Tested version: podman 5.5.2. To ensure a smooth and reliable container experience on macOS, use Podman Desktop. It provides a clean UI, built-in terminal access, and integrated logs.

⚠️ Important:
Increase the memory allocated to the Podman virtual machine to at least 4 GB. Otherwise, the APEX installation may fail during setup.

brew install podman-compose
💡 Tip for users upgrading from older Podman installations: If you installed Podman previously via Homebrew, you can upgrade to the latest version like this:

brew update && brew upgrade podman
==> Updating Homebrew...

brew upgrade --cask podman-desktop
==> Upgrading 1 outdated package:
podman-desktop 1.15.0 -> 1.20.2
==> Upgrading podman-desktop
If Podman Desktop still shows an older engine version, try creating a new machine with podman machine init. Old machines will stay in the old podman version until you create them new.

The container images used in this setup are sourced from the following registries:

📦 Software Sources
Oracle Database Free 26ai
Oracle REST Data Services (ORDS)
✨Why download the Images first?
Container images can be several gigabytes in size, so depending on your internet connection, pulling them might take a few minutes. To keep your setup process smooth and efficient, it’s smart to start downloading the images early. While they download in the background, you can continue reading or preparing your configuration.

Lets download the image for the database…

podman pull ghcr.io/gvenzl/oracle-free:23.26.0

# or but needs more time at first start
podman pull ghcr.io/gvenzl/oracle-free:latest
This pulls the latest Oracle Database 26ai Free image (currently version 23.26.0) from GitHub’s Container Registry

Lets download the image for ORDS…

This command pulls the newest Oracle Database 26ai Free latest supported container image (currently version 23.8) from GitHub’s Container Registry using Podman, so you can use it locally.

podman pull container-registry.oracle.com/database/ords:25.2.0
This command fetches the ORDS 25.2 container image from Oracle’s Container Registry.

In my previous article, I used a secrets-based password file to pass credentials securely. For this version, that’s no longer necessary: we’ll use simple environment variables instead. This keeps the setup cleaner and simpler while still offering full control and clarity.

🛠️ Defining the Compose Setup

Now it’s time to look at the compose.yml file. This configuration is designed for the Podman engine and defines the full setup for both the Oracle Database and ORDS services in my local environment and I placed it in my local development folder: /Users/{username}/dev/apex.

I keep it there so the configuration, environment files, and related scripts for APEX and ORDS are all in one dedicated workspace. This makes it easier to version-control the whole stack, share it as a GitHub project, and quickly spin up or tear down the environment without touching unrelated files on my system. The compose.yml defines the full setup for both the Oracle Database and ORDS services, tailored for the Podman engine in my local environment. you can find it in my public Git repository.

services:
    oraclefree:
        image: ghcr.io/gvenzl/oracle-free:23.26.0
        ports:
            - 1521:1521
        volumes:
            - ora_db_vol26ai:/opt/oracle/oradata
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
    ora_db_vol26ai:
    ords_config:

networks:
    ora_app_network:
Make sure the paths and configuration settings fit your environment. The passwords are stored in the .env file.

The oraclefree container runs the Oracle 23ai Free database image and exposes port 1521 for SQL*Net access. Once the database is fully ready, the ords service detects this using the health check mechanism defined in the compose file. The depends_on condition ensures that ORDS doesn't even attempt to start until the database is marked as healthy. After that, ORDS connects automatically using two key environment variables: CONN_STRING=oraclefree/freepdb1 defines the target database service and pluggable database name, and ORACLE_PWD=<yourpassword> provides the password for the database connection.

Become a member
Using these variables, ORDS can configure itself entirely without the need for any manual setup files. The result is a clean, fully automated, and non-interactive installation that’s ready to go right out of the box.

💡Simplifying Podman Compose with a .env File
When working with containerized Oracle environments using podman-compose, it's good practice to keep sensitive data like passwords and connection strings out of your compose.yml. The easiest way to achieve this is by using a .env file. Sharing your project securely:

ORACLE_PASSWORD=YourSecurePassword123
CONN_STRING=oraclefree/freepdb1
ORACLE_PWD=YourSecurePassword123
HOST_PORT=8181
By default, podman-compose automatically looks for a file named .env in the same directory as your compose.yml. There's no need to reference or execute it manually — it's picked up behind the scenes and used to resolve environment variables in your services.


Bootstrapping the Database Environment
Before we launch the full stack, we’ll start by bringing up only the database container. This gives us a chance to install Oracle APEX right away — avoiding the extra step of registering it with ORDS later. Once APEX is in place, we’ll add ORDS into the mix. So for now, we’ll spin up just the database using:

podman-compose up -d oraclefree
Press enter or click to view image in full size

beginning of the output of starting database service
You see now the database compose environment is up and running:

Press enter or click to view image in full size

✨Lets now install APEX into our database…
To install APEX manually, follow these steps. Download APEX latest version


Unzip the downloaded file to your local machine if it is not unzipped already and copy the folder apex-latest to your podman machine:

podman cp ~/Downloads/apex-latest apex_oraclefree_1:/tmp/
Start a shell in the container to perform the remaining installation steps and start sql plus:

podman exec -it apex_oraclefree_1 bash
-- change directory (not in sql)
cd /tmp/apex-latest/apex/
-- please with '' cause bash interpretation of bash is not so good
sqlplus 'sys/<your_pwd_please>@localhost:1521/freepdb1 as sysdba'
Before running the installation script, we need to create a dedicated tablespace for APEX. But first, let’s check whether the expected directory for the tablespace already exists inside the database container. You can do this either by using Podman directly to open a shell in the container, or by connecting to the database and running a quick SQL query to determine the correct default datafile location.

ls /opt/oracle/oradata/FREE/FREEPDB1/
sysaux01.dbf  system01.dbf  temp01.dbf undotbs01.dbf  users01.dbf
podman exec -it apex_oraclefree_1

SET LINESIZE 150
SET PAGESIZE 100
COLUMN file_name FORMAT A65
COLUMN tablespace_name FORMAT A15
COLUMN size_mb FORMAT 999999.99

SELECT file_name, tablespace_name, bytes/1024/1024 AS size_mb
FROM dba_data_files
ORDER BY file_name;


# output - do not copy - only to compare for you
# FILE_NAME         TABLESPACE_NAME    SIZE_MB
# ---------------------------------------------- --------------- ----------
#/opt/oracle/oradata/FREE/FREEPDB1/sysaux01.dbf     SYSAUX       400.00
#/opt/oracle/oradata/FREE/FREEPDB1/system01.dbf     SYSTEM       280.00
#/opt/oracle/oradata/FREE/FREEPDB1/undotbs01.dbf    UNDOTBS1     100.00
#/opt/oracle/oradata/FREE/FREEPDB1/users01.dbf      USERS          1.00
Next step we will create an APEX tablespace and then install APEX into our newly created tablespace:

-- create tablespace for APEX Installation
CREATE TABLESPACE apex
  DATAFILE '/opt/oracle/oradata/FREE/FREEPDB1/apex_001.dbf'
  SIZE 300M
  AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED;
-- run the install script into the new tablespace
@/tmp/apex-latest/apex/apexins.sql APEX APEX TEMP /i/


/* what does this command mean
APEX: Tablespace for APEX objects
APEX: also for FLOWS_FILES (can be the same)
TEMP: Temporary tablespace
/i/: Path to APEX images, required by ORDS


last rows of the putput:
Thank you for installing Oracle APEX 24.2.0

Oracle APEX is installed in the APEX_240200 schema. 

timing for: Phase 3 (Switch)
Elapsed:    0.15

The structure of the link to the Oracle APEX Administration Services is as follows:
http://host:port/ords/apex_admin

The structure of the link to the Oracle APEX development environment is as follows:
http://host:port/ords/apex

timing for: Complete Installation
Elapsed:    4.05
*/
Next step, there’s two more administrative tasks we need to do. First, we need to unlock the APEX_PUBLIC_USER account. This is needed for ORDS to properly connect to the database. To unlock APEX_PUBLIC_USER, run the following command:

alter user apex_public_user account unlock;
Lastly, let’s reset the APEX administrator account so we will be able to login to the Internal workspace once ORDS is up and running. Run the following command and follow the prompts:

SYS> @apxchpwd

--- output - do not copy - only to compare for you
...set_appun.sql
================================================================================
This script can be used to change the password of an Oracle APEX
instance administrator. If the user does not yet exist, a user record will be
created.
================================================================================
Enter the administrator's username [ADMIN] ADMIN
User "ADMIN" does not yet exist and will be created.
Enter ADMIN's email [ADMIN] 
Enter ADMIN's password [] 
Created instance administrator ADMIN.
You might wonder why we install APEX before launching ORDS. The reason is simple: when ORDS detects APEX is already installed, it automatically configures support for it during bootstrap.

💡APEX Static Files
One important piece of this setup is giving ORDS access to the static APEX files. To render APEX correctly in the browser, ORDS must serve all required assets — images, CSS, JavaScript, and more. For that, we create a local directory called apex-images and copy the contents of the APEX /images folder into it:

mkdir -p apex-images
cp -r /Users/SOMEYER/dev/apex/apex-latest/apex/images/* apex-images/
volumes:
  -./apex-images:/opt/oracle/apex/images
This makes your local ./apex-images directory available inside the container at /opt/oracle/apex/images. ORDS uses this exact path to serve static APEX resources via the /i/ URL. Without it, the APEX UI would load with missing styles, icons, and scripts. With it, everything is fully functional and looks exactly as it should—styled, interactive, and ready for development.

✨ORDS, Meet Your Database…
At launch, the ORDS container no longer relies on an external conn_string.txt file (like in my latest article). Instead, it reads the connection information directly from the environment variables defined in the compose.yml file. Using the CONN_STRING and ORACLE_PWD values, ORDS automatically connects to the Oracle database and initiates the installation of its internal components as well as the APEX REST configuration if required. This streamlined setup removes the need for manual bootstrap files and supports repeatable, container-native deployments.

podman-compose up ords
Press enter or click to view image in full size

beginning of the output of starting ORDS service from podman desktop logs
✨ And now start
With everything in place and the containers up and running, your APEX environment is now live. ORDS has completed the configuration, and you can access the APEX landing page via:

http://localhost:8181/ords/

Welcome to your fully containerized APEX playground — served fresh by ORDS and powered by Podman.

Press enter or click to view image in full size

Next step is to create your Workspace and setup your environment in this blank installation. You’ll be prompted to log in as the ADMIN user. This account belongs to a special built-in workspace called INTERNAL.

The INTERNAL workspace is reserved for administration tasks—it’s where you:

Create new workspaces
Manage APEX users
Configure instance-level settings
So yes, you’ll use the INTERNAL workspace at first to bootstrap your environment. Once you've created your own workspace (e.g., DEV, HR, or anything you like), you can switch to it for app development and schema-level work.

Press enter or click to view image in full size

💡 Tips
Stopping and Restarting the APEX Environment

You can gracefully stop your entire APEX and database environment using:

# Starts previously stopped containers
podman-compose start

# Gracefully stops all running containers (they're not removed and can be restarted)
podman-compose stop

# Restarts previously stopped containers
podman-compose restart


#### be careful with the next commands:

# Starts all containers defined in the podman-compose.yml file (detached mode)
podman-compose up -d

# Shuts down the environment and removes all associated containers and networks
# Note: named volumes (and their data) are preserved unless removed manually
podman-compose down

# Lists all containers, including stopped ones (useful for debugging)
podman ps -a

# Force-removes a specific container, e.g., if ORDS needs to be rebuilt
podman rm -f apex_ords_1

# Deletes named volumes to start completely fresh — WARNING: this also deletes data!
podman volume rm apex_ora_db_vol apex_ords_config

# Shows logs of a container — essential for troubleshooting issues
podman logs -f apex_oraclefree_1
podman logs -f apex_ords_1
Accessing the Database Container

To interact directly with the running Oracle container, open your Mac’s terminal and run:

podman exec -it apex_oraclefree_1 bash
This command launches an interactive shell inside the oraclefree container. It’s a convenient way to access the internal environment—whether you want to check logs, run sqlplus, or troubleshoot your database setup. Think of it as popping the hood on your containerized Oracle instance.

Testing the Database Connection
To verify that everything is running correctly, you can connect to the Oracle database from inside the container using SQL*Plus:

sqlplus sys/'yourSecurePasswordHere'@localhost:1521/FREEPDB1 as sysdba

SQL*Plus: Release 23.0.0.0.0 - Production on Tue Apr 1 08:21:31 2025
Version 23.7.0.25.01
Copyright (c) 1982, 2025, Oracle.  All rights reserved.

Connected to:
Oracle Database 23ai Free Release 23.0.0.0.0 - Develop, Learn, and Run for Free
Version 23.7.0.25.01
Verifying Containers in Podman Desktop
You can visually confirm that your APEX environment is running correctly using Podman Desktop. In the screenshot above, the compose group named apex includes two running containers:

apex_oraclefree_1 – the Oracle Database 23ai Free container, exposing port 1521
apex_ords_1 – the ORDS (Oracle REST Data Services) container, available on port 8181
Both are marked as running under the Podman engine, and their respective images match the ones used in the compose.yaml. This confirms that the APEX stack is live and properly wired together via Compose.

Press enter or click to view image in full size

Press enter or click to view image in full size

More help on this:

Oracle REST Data Services (ORDS) Developer

podman-compose