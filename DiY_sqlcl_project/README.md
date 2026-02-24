# Do it yourself - Next Step Oracle APEX DevOps with SQLcl Projects (Part 4)

The next article about CI/CD for database or APEX? Oh yes — because let's face it, there are way too many APEX apps still living in the wild west of manual deployments. Time to bring them into the civilized world of pipelines, versioning, and glorious automation!

If you've worked with Oracle Database CI/CD, you're probably familiar with Liquibase or other tools and how they simplify database change management. If you don't and you haven't done CI/CD for database or APEX… do it immediately please! Because it can save you hours of manual work, reduce the chance of "oops moments," and give you beautiful, repeatable deployments — every. single. time. No more guessing, no more zip-and-hope. Just clean, reliable delivery like a pro.

No experience? No problem. This step-by-step guide shows you exactly how to get started and build your own CI/CD setup — one simple step at a time.

Over the years, we've made that process even easier for things like ORDS REST APIs and APEX applications. Now, with SQLcl's new project command, there's an even simpler, more integrated way to structure, version, and deploy your database and APEX changes. But before we dive in, let's briefly cover what SQLcl actually is — and why SQLcl Projects make working with database changes so much smoother.

#### Short reminder why:

CI/CD is a DevOps practice that automates the software delivery process to make code changes faster and more reliable. It includes four main stages: Build (create the executable), Test (automate validation), Deploy (move to staging and production), and Monitor (track performance and errors). The goal is end-to-end automation from development to production. And remember: in the database world, embracing a DevOps mindset isn't easy because databases are inherently stateful. This makes deployments high-stakes — there's no room for error, since rolling back changes can be tricky or even impossible.

What is SQLcl and what do I use it for?

Oracle SQLcl is a modern command-line interface for working with Oracle databases. It is compatible with SQL*Plus scripts and adds powerful features like exporting APEX apps, generating DDL, formatting output as JSON, and automating common tasks. SQLcl is widely used by developers and DBAs to manage database objects, execute SQL and PL/SQL, and streamline workflows. It's especially useful in CI/CD pipelines, where it helps structure, package, and deploy database changes reliably across environments.

And what is SQLcl Projects?

SQLcl Projects is a feature within SQLcl that adds structure to database development and deployment. It introduces a project-based workflow for tracking and managing changes to database objects and APEX applications. You can initialize a project, export relevant objects into a local folder, generate changelogs, and create versioned releases that are easy to package and deploy. It also supports multi-schema environments out of the box, making it ideal for complex setups. SQLcl Projects is fully integrated into SQLcl and is controlled through the project command — perfect for bringing DevOps practices into the Oracle database world.

#### Requirements

To work with SQLcl Projects, you need Oracle SQLcl version 24.4 or newer, as the project command was introduced in that release. Git is also required, as SQLcl Projects rely on Git for change detection and version comparison. You can use your existing Git repository. In addition, you need access to at least one Oracle Database, ideally with two schemas: one for your development work and one for comparison or deployment purposes. This aligns with how SQLcl Projects use diffing between environments to generate accurate change sets.

To use SQLcl effectively in a DevOps workflow, Git is essential. It helps manage your database scripts and changelogs, enabling collaboration, tracking, and reliable deployments across environments. This repository provides example scripts and resources for Do-it-Yourself DevOps workflows using SQLcl and Oracle APEX. It's a public workspace to explore database automation, version control, and CI/CD — all with real-world examples you can clone, tweak, and run.

And of course, you'll need a database. In my case, I'm using a fabulous Always Free tenant in Oracle Cloud Infrastructure — running our amazing Autonomous Database, which handles everything smoothly behind the scenes. And if you connect to your database, remember to use the wallet like this:

sql "<user>/<pw>@apexdev_medium?TNS_ADMIN=<path to your wallet>"

#### Probably good to know:

I'm a big fan of Visual Studio Code — especially when it's supercharged with extensions. In this DIY-style guide, I'll be using the Oracle SQL Developer Extension for VS Code as my go-to tool. Think of it as your trusty sidekick for wrangling SQL. Oracle SQL Developer for VS Code brings powerful database features like querying, schema browsing, PL/SQL and more straight into your editor, so you can stay in flow without jumping between tools.

For our test project, I'll use the Email Management App I showcased in a demo together with my colleague Martin Bach at APEX Connect in Rust. This Oracle APEX application helps manage email recipients and view messages. It also leverages MLE (Multilingual Engine) to run JavaScript directly in the database — most likely to handle email validation more efficiently than with PL/SQL alone. You see in the picture I am connected to my Autonomous Database via the Oracle SQL Developer Extension for VS Code with my APEX Schema WKSP_MLEGENAI.

If you would like to see how I did all this, you are welcome to go to my GitHub repository and download the necessary sources. It's important to ensure that all necessary objects are committed to the GitHub repository at a later stage, so your sources are safely versioned and backed up. In one of the steps, we'll also identify which objects are actually required.

#### A short thought:

At this stage, it's absolutely fine to work directly on the main branch. You're still in the setup phase: initializing your SQLcl project, exporting the initial state of your database, and committing the baseline to Git. These foundational steps belong in main, as they represent the clean starting point for your versioned DevOps workflow.

Once you start making actual changes — like modifying PL/SQL packages, adjusting APEX applications, or adding new features — it's best to create feature branches. This allows you to work safely without affecting the main line of deployment. You can export updates with project export, track your changes in Git, and only merge into main once the release has been built, tested, and is ready for deployment.

In short, main is your stable, production-ready line. Branch out when you're building or experimenting — then merge back in when it's ready to go live. This structure keeps your development clean, reliable, and aligned with modern CI/CD practices.

How to start…

#### First Steps Toward DevOps for Your Oracle Database

Ready to kick off your DevOps journey with Oracle APEX and SQLcl? Let's walk through the essential first steps — connecting to the database, initializing a project, and exporting your schema into a Git-based structure.

Quick note: I've set up a GitHub repo called DiY_articles in advance — that's where we'll keep all our project files as we go through the steps. Just make sure to decide whether you want your repository to be public or private, depending on who should have access to your project. Here's how it works:

1. Connect to the Database

We start by connecting to an Oracle Autonomous Database using SQLcl and a Cloud Wallet:

sql "WKSP_MLEGENAI/<password>@apexdev_medium?TNS_ADMIN=<path-to-wallet>"

This securely connects your SQLcl session to the database schema where your APEX app and other objects live.

2. Initialize the SQLcl Project

Once connected, we initialize a new SQLcl Project directly from the command line:

project init -name diy_articles -schemas WKSP_MLEGENAI -directory <path>

This sets up a structured local project that mirrors the database schema you're working with. The -directory parameter points to your GitHub repository, so all exported files are version-controlled from the start.

This is the typical folder structure of a SQLcl Project:

.dbtools/ contains project configuration files, including schema details and filters.src/ holds the exported source code — your database objects, APEX apps, REST services, etc.dist/ is where staged changes and released versions live, organized by version numbers..gitignore defines what files Git should ignore (usually auto-generated artifacts).README.md is your project's documentation entry point.

In this setup, the DiY_articles repository on GitHub serves as the root for your CI/CD demo. Inside it, the DiY_sqlcl_project subfolder contains the actual SQLcl Project. This is the directory you need to navigate into when running any project commands from the SQLcl command line — because that's where the .dbtools configuration lives.

Step 3: Export Database Objects

With your project initialized and the connection still active, you can export all database objects:

project export

This will use the current connection to export the following types of objects:

The current connection apexdev_medium WKSP_MLEGENAI will be used for all operations*** INDEXES ****** PACKAGES ****** PACKAGE BODIES ****** TABLES ****** TRIGGERS ****** REF_CONSTRAINTS ****** GRANTS ****** APEX_APPLICATION ***Exporting Workspace MLE_GENAI - application 122: Email Management App

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

Step 4: Commit Your Project to Git

Now that your database export is complete, it's time to version it using Git. This step ensures that your schema state, packages, and APEX applications are safely tracked and shareable with your team.

You can do this via your terminal or directly in Visual Studio Code.

💻 Option 1: Using VS Code

Open the DiY_articles project folder in VS Code.
Click on the Source Control icon on the left panel.
Stage your changes (all new and modified files).
Enter a commit message like: Initial database export using SQLcl
Click the checkmark ✓ to commit.
Click "Sync Changes" to push and pull.

🖥️ Option 2: Using Terminal
cd /Users/SOMEYER/GitHub/DiY_articles/DiY_sqlcl_project
git add .
git commit -m "Initial database export using SQLcl"
git push
If you miss git pull, it's usually harmless in a solo or linear setup — but in team-based or parallel APEX development, it can cause merge conflicts or prevent you from pushing altogether.

With this, you've committed and pushed your entire SQLcl project to GitHub — capturing the exported state for future collaboration, automation, and version control. And just like that, your first APEX environment is now live in GitHub! 🚀

#### Some more facts:

This command displays the full configuration details of your SQLcl project:

project config -list -verbose

It reads from the .dbtools/project.json file and shows information such as the project name, defined schemas, source and release directories, export settings, and any additional options. The -verbose flag ensures that all available settings are included in the output, making it a useful way to verify that your project is set up correctly before exporting or deploying changes.

To ensure full traceability and consistent deployments, the APEX application is now included in the export process. By exporting it alongside database objects, the entire application stack becomes version-controlled and auditable. This not only enables streamlined collaboration and rollbacks but also supports automated CI/CD pipelines where both schema changes and APEX definitions can be tested and promoted together.

In this article, we focused on versioning both database objects and the APEX application using SQLcl Projects. In the next article, I'll dive deeper into how APEX deployment works within this setup — covering how to export, track, and automate the installation of APEX apps as part of a streamlined development and release process.

#### More help on this:

Oracle SQLcl Release 25.26.2 About the Project Command
6.2 About the Project Command# DiY_articles
public environment for the Do it Yourself articles with free download of sources

Project list:
    1. DiY_sqlcl_projects - SQLcl Project 