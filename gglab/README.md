# Migrate your PostgreSQL to Autonomous Database using Goldengate

Welcome to migration to ATP using Oracle Goldengate lab material. In this lab we will migrate some postgresql database to autonomous database in Oracle Cloud Infrastructure. We will use Oracle Goldengate for migration, and all of our services will be hosted in OCI for this lab purpose.

![](files/ggconf/general.gif)

Following items will be created in our lab steps.
- Source Postgreqsql database: we will create Postgresql database using Virtual Machine, acts as our source on-premise database
- Goldengate for non-Oracle deployment: we will create Goldengate environment for Postgresql which extracts data from source and ships trails to cloud.
- Goldengate Microservices deploymen: we will create Microservices environment for Autonomous database which applies trails from source to target autonomous database.
- Target Autonomous database: we will provision Oracle Autonomous database acts as our target database. 

We will also configure following Goldengate processes.

- Extract exttab process at Goldengate for non-Oracle database, it is known as change data capture for continuous replication.
- Extract extdmp process at Goldengate for non-Oracle database, it will ship our captured trail files to Microservices for continuous replication.
- Extract initload process at Goldengate for non-Oracle database, it is our first data loader process and inserts to ATP.
- Replicate process at Microservices, it will apply trail files captured by initload process.


## Pre-Requisites: Oracle Cloud Account

- First of all, you need an Oracle Cloud account. 
#### Option 1: 
Sign up [here](https://oracle.com/free) to create a free-tier account. After you successfully created your cloud account, you can use your Always Free resources as long as you want with no time constraints—subject only to the capacity limits noted. You will also receive $300 of free credits good for up to 30 days of Oracle Cloud usage.
Once you are successfully created your cloud account, you will receive a confirmation email from Oracle.
*Note down your OCI account credentials (User, Password, and Tenant) in safe place.*
- To sign in to the Console, you need the following:
  - Tenant, User name and Password
  - URL for the Console: [https://oracle.com](https://oracle.com)
  - Oracle Cloud Infrastructure supports the latest versions of Google Chrome, Firefox and Microsoft Edge.


#### Option 2: 
If you already have access to an Oracle Cloud account activated and some credits, sign in your tenancy then directly jump to LAB1.

### Lab steps

- **LAB 1:** [Create your Compartment and VCN](step1.md)
- **LAB 2:** [Create your PostgreSQL database](step2.md)
- **LAB 3:** [Provision your first ATP in OCI](step3.md)
- **LAB 4:** [Create your Goldengate instances](step4.md)
- **LAB 5:** [Configure your migration](step5.md)




*Disclaimer: Views, ideas expressed are my own and do not necessarily reflect those of Oracle*
