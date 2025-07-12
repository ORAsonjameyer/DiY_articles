# DiY_articles
public environment for the Do it Yourself articles with free download of sources

Do it yourself - next step Oracle APEX DevOps with SQLcl Projects (part 4)
If you've worked with Oracle Database CI/CD, you're probably familiar with Liquibase and how it simplifies database change management. Over the years, we've made that process even easier for things like ORDS REST APIs and APEX applications. Now, with SQLcl's new project command, there's an even simpler, more integrated way to structure, version, and deploy your database and APEX changes. But before we dive in, let's briefly cover what SQLcl actually is - and why SQLcl Projects make working with database changes so much smoother.


Short reminder:
CI/CD is a DevOps practice that automates the software delivery process to make code changes faster and more reliable. It includes four main stages: Build (create the executable), Test (automate validation), Deploy (move to staging and production), and Monitor (track performance and errors). The goal is end-to-end automation from development to production. And remember in the database world, embracing a DevOps mindset isn't easy because databases are inherently stateful. This makes deployments high-stakes - there's no room for error, since rolling back changes can be tricky or even impossible.


What is SQLcl and for what do i use it? 
Oracle SQLcl is a modern command-line tool for working with Oracle databases. It allows developers and administrators to quickly execute SQL and PL/SQL commands, manage database objects, and export APEX applications. Compared to SQL*Plus, SQLcl offers additional features such as JSON export, DDL generation, and built-in support for automated processes. SQLcl is particularly used in CI/CD workflows to structure database changes, package them as releases, and deploy them to target systems. It is operated directly via the command line.


Lets get started:
# Getting Started with SQLcl Projects  
### First Steps Toward DevOps for Your Oracle Database

To kick off your DevOps journey with Oracle APEX and SQLcl, we’ve completed the essential first steps—connecting to the database, initializing a project, and exporting the current state of your schema into a Git-based structure. Here’s what that looks like in action:

---´

# Getting Started with SQLcl Projects and CI/CD

In this walkthrough, we set up a CI/CD-compatible SQLcl Project using Oracle SQLcl to manage database changes.

## Step 1: Connect with SQLcl

First, we connected to the Oracle Autonomous Database with SQLcl using:

```bash
sql "WKSP_MLEGENAI/<your_password>@apexdev_medium?TNS_ADMIN=<path_to_wallet>"
```

## Step 2: Initialize Your Project

We initialized a new SQLcl project in our local Git repository directory:

```sql
project init -name diy_articles -schemas WKSP_MLEGENAI -directory /Users/SOMEYER/GitHub/DiY_articles
```

Optionally, to create a subfolder inside your repo:

```sql
project init -name diy_articles -schemas WKSP_MLEGENAI -directory /Users/SOMEYER/GitHub/DiY_articles -makeroot
```

This creates a `.sqlcl` project folder structure within your repo for managing exported objects and tracking changes.

## Step 3: Export Database Objects

With your project initialized and the connection still active, you can export all database objects:

```sql
project export
```

This will use the current connection to export the following types of objects:

```text
The current connection apexdev_medium WKSP_MLEGENAI will be used for all operations
*** INDEXES ***
*** PACKAGES ***
*** PACKAGE BODIES ***
*** TABLES ***
*** TRIGGERS ***
*** REF_CONSTRAINTS ***
*** GRANTS ***
*** APEX_APPLICATION ***
Exporting Workspace MLE_GENAI - application 122:Email Management App
-------------------------------
TABLE                         2
PACKAGE_BODY                  1
GRANT                         1
APEX_APPLICATION              1
REF_CONSTRAINT                1
PACKAGE_SPEC                  2
TRIGGER                       2
INDEX                         1
-------------------------------
Exported 11 objects
```

## Optional: Export Only Specific Objects

You can also specify which database objects to export, for example:

```sql
project export -objects "WKSP_MLEGENAI.DIY_ARTICLES,WKSP_MLEGENAI.EMAIL_VALIDATE"
```

Or preview what would be exported:

```sql
project export -list
```

This concludes the basic setup and first export. You're now ready to move on to versioning with `project release` and beyond!



## Step 4: Commit Your Project to Git

Now that your database export is complete, it's time to version it using Git. This step ensures that your schema state, packages, and APEX applications are safely tracked and shareable with your team.

You can do this via your terminal or directly in Visual Studio Code.

### 💻 Option 1: Using VS Code

1. Open the `DiY_articles` project folder in VS Code.
2. Click on the **Source Control** icon on the left panel.
3. Stage your changes (all new and modified files).
4. Enter a commit message like:

   ```
   Initial database export using SQLcl
   ```

5. Click the checkmark ✓ to commit.

### 🖥️ Option 2: Using Terminal

If you prefer working in the shell, navigate to your project directory and run:

```bash
# Navigate into your local SQLcl project folder inside the Git repository
cd /Users/SOMEYER/GitHub/DiY_articles/diy_articles

# Stage all new and changed files for the next commit
git add .

# Create a new Git commit with a clear message describing what was done
git commit -m "Initial database export using SQLcl"

# Push your local commit to the remote GitHub repository
git push
```

This will commit all project files into your local Git repository, preserving the exported state for future collaboration or automation.


