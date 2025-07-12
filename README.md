# DiY_articles
public environment for the Do it Yourself articles with free download of sources

Do it yourself - next step Oracle APEX DevOps with SQLcl Projects (part 4)
If you've worked with Oracle Database CI/CD, you're probably familiar with Liquibase and how it simplifies database change management. Over the years, we've made that process even easier for things like ORDS REST APIs and APEX applications. Now, with SQLcl's new project command, there's an even simpler, more integrated way to structure, version, and deploy your database and APEX changes. But before we dive in, let's briefly cover what SQLcl actually is - and why SQLcl Projects make working with database changes so much smoother.


Short reminder:
CI/CD is a DevOps practice that automates the software delivery process to make code changes faster and more reliable. It includes four main stages: Build (create the executable), Test (automate validation), Deploy (move to staging and production), and Monitor (track performance and errors). The goal is end-to-end automation from development to production.

What is SQLcl and for what do i use it? 
Oracle SQLcl is a modern command-line tool for working with Oracle databases. It allows developers and administrators to quickly execute SQL and PL/SQL commands, manage database objects, and export APEX applications. Compared to SQL*Plus, SQLcl offers additional features such as JSON export, DDL generation, and built-in support for automated processes. SQLcl is particularly used in CI/CD workflows to structure database changes, package them as releases, and deploy them to target systems. It is operated directly via the command line.
