- [Go back to main](README.md)
- [Go back to previous step](step2.md)

# Lab 3 - Create your target Autonomous Database
In previous lab, we created our Source DB, now it is time to create our Target DB, which is Autonomous database. If you don't know about Autonomous database, please read following information or [jump directly to Part-1](#part-1-create-your-autonomous-database). This lab consists of two parts.

#### What is an Autonomous Database?
[An autonomous database](https://www.oracle.com/database/what-is-autonomous-database.html) is a cloud database that uses machine learning to automate database tuning, security, backups, updates, and other routine management tasks traditionally performed by DBAs. Unlike a conventional database, an autonomous database performs all these tasks and more without human intervention.  

#### How does it work?
An autonomous database leverages AI and machine learning to provide full, end-to-end automation for provisioning, security, updates, availability, performance, change management, and error prevention.

In this respect, an autonomous database has specific characteristics.

- It is self-driving. All database and infrastructure management, monitoring, and tuning processes are automated. DBAs can now focus on more important tasks, including data aggregation, modeling, processing, governance strategies, and helping developers use in-database features and functions with minimal changes to their application code.
- It is self-securing Built-in capabilities protect against both external attacks and malicious internal users. This helps eliminate concerns about cyberattacks on unpatched or unencrypted databases.
- It is self-repairing. This can prevent downtime, including unplanned maintenance. An autonomous database can require fewer than 2.5 minutes of downtime per month, including patching.
 
#### What deployment options are available for Autonomous Database?

There are 2 options for deploying an autonomous database.
- Serverless deployment. In serverless deployment, multiple users share the same cloud infrastructure resources. Serverless deployment is the simplest option; it requires no minimum commitment and users can take advantage of quick data provisioning and application development. Users also enjoy independent compute and storage scalability. In this deployment model, users are responsible for database provisioning and management while the provider takes care of infrastructure deployment and management responsibilities.
- Dedicated deployment. Dedicated deployment allows the user to provision the autonomous database within a dedicated (unshared) cloud infrastructure. This deployment model has no shared processor, memory, network, or storage resources. Dedicated deployment offers greater control and customization over the entire environment and is ideal for users who want to tailor their autonomous database to meet specific organizational needs. Additionally, dedicated deployment allows for an easy transition from on-premise databases to a fully autonomous and isolated private database cloud.

#### What type of workloads can your run in an Autonomous Database?

[An autonomous database consists of three key elements](https://www.oracle.com/autonomous-database/) that align with workload types.
- Data warehouse performs numerous functions related to business intelligence activities, and uses data that’s been prepared in advance for analysis. The data warehouse environment also manages all database lifecycle operations, can perform query scans on millions of rows, is scalable to business needs, and can be deployed in a matter of seconds.

- Transaction processing enables time-based transactional processes such as real-time analytics, personalization, and fraud detection. Transaction processing typically involves a very small number of records, is based on predefined operations, and allows for simple application development and deployment.

- JSON Database is a cloud document database service that makes it simple to develop JSON-centric applications. It features simple document APIs, serverless scaling, high performance ACID transactions, comprehensive security, and low pay-per-use pricing

#### What benefits do we have?
Autonomous databases offer many benefits. When you're ready to evaluate the offerings available to your organization, look for the following key features.

- Auto-Provisioning: Automatically deploys mission-critical databases that are fault-tolerant and highly available. Enables seamless scale-out, protection in case of a server failure, and allows updates to be applied in a rolling fashion while apps continue to run.
- Auto-Configuration: Automatically configures the database to optimize for specific workloads. Everything from the memory configuration, the data formats, and access structures are optimized to improve performance. Customers can simply load data and go.
- Auto-Indexing: Automatically monitors workload and detects missing indexes that could accelerate applications. It validates each index to ensure its benefit before implementing it and uses machine learning to learn from its own mistakes.
- Auto-Scaling: Automatically scales compute resources when needed by workload. All scaling occurs online while the application continuously runs. Enables true pay per use.
- Automated Data Protection: Automatically protects sensitive and regulated data in the database, all via a unified management console. Assesses the security of your configuration, users, sensitive data, and unusual database activities.
- Automated Security: Automatic encryption for the entire database, backups, and all network connections. No access to OS or admin privileges prevents phishing attacks. Protects the system from both cloud operations and any malicious internal users.
- Auto-Backups: Automatic daily backup of database or on-demand. Restores or recovers a database to any point in time you specify in the last 60 days.
- Auto-Patching: Automatically patches or upgrades with zero downtime. Applications continue to run as patching occurs in a round-robin fashion across cluster nodes or servers.
- Automated Detection and Resolution: Using pattern recognition, hardware failures are automatically predicted without long timeouts. IOs are immediately redirected around unhealthy devices to avoid database hangs. Continuous monitoring for each database automatically generates service requests for any deviation.
- Automatic Failover: Automatic failover with zero-data loss to standby. It’s completely transparent to end-user applications. Provides 99.995% SLA.

## PART 1: Create your Autonomous Database

Let's continue from the previous lab. Go to top left hamburger icon, navigate to **Autonomous Transaction Processing**, then choose your compartment from left pane and click on **Create Autonomous Database** button.

![](./files/atp/autonomous_0.png)

#### Create ATP
Configuration page will open, confirm your compartment once again. Then give a name for deployment **HOL_ATP** and give a database name **HOL**

![](./files/atp/autonomous_1.png)

#### Workload type

We will choose **Transaction Processing** workload type and will use **Shared Infrastructure**.

![](./files/atp/autonomous_2.png)

#### Option 1: Always free
Here, if you'd like to create your ATP as **Always Free**, which is free forever but with limited CPU and storage capacity. Just click on this toggle. **Note: You cannot scale up or down Always Free resource after creation**

![](./files/atp/autonomous_3_1.png)

#### Option 2: Non-Limited
If you want more power and able to be scale up/down your resource at later stage, choose to disable Always free. For this lab, keep auto scaling disabled and you can change this anytime.
Number of **OCPU** count for your ATP, let's specify just 1 and **Storage** 1 TB also, we can change this anytime after instance creation.

![](./files/atp/autonomous_3_2.png)

#### Admin password
Provide your ADMIN account credentials here, for example **GG##lab12345** will suffice password requirement.

![](./files/atp/autonomous_4.png)

#### Network Access and License
We will accept the default option for network access, "Allow secure access from everywhere". For license type, select **License Included**, because we want to subscribe to new database software licenses and the database cloud service.

![](./files/atp/autonomous_5.png)

Review everything and click on **Create Autonomous Database**.

#### Provisioning
Your instance will begin provisioning. In a few minutes, the state will turn from Provisioning to Available. At this point, your Autonomous Data Warehouse database is ready to use! Have a look at your instance's details here including its name, database version, OCPU count, and storage size.

![](./files/atp/autonomous_6.png)

#### Created
It takes only 2-5 minutes to create fully working highly available, self running Autonomous database.

![](./files/atp/autonomous_7.png)

## PART 2: Prepare target database for migration

This part will run create target tables for GG migration and enable GG replication in Autonomous database.

#### SQL developer web 

In **Tools** tab, where you can access to SQL Developer Web and other web tools. Click **Open SQL Developer Web**, you may need to enable pop-up your browser if it doesn't open anything.

![](./files/atp/sql_dev_0.png)

A new sign-in page opens, enter **ADMIN** in Username and enter your password.

![](./files/atp/sql_dev_1.png)

#### Create target tables

When you open the SQL Developer Web for first time, a series of pop-up informational boxes introduce you to the main features. Take a quick look at them. 


Let's create our target tables for migration. Please download target table creation script **[from here](./files/atp/CreateTables.sql)**. Make sure to save these with correct extension .sql not txt!

SQL Developer Web opens a worksheet tab, where you execute queries. Drag your downloaded CreateTables.sql and drop in the worksheet area. Then run create statements.

![](./files/atp/sql_dev_2.png)

#### Enable GGADMIN 

Now let's unlock and change the password for the pre-created Oracle GoldenGate user (ggadmin) in Autonomous Database.
Run `alter user ggadmin identified by "GG##lab12345" account unlock;`

![](./files/atp/sql_dev_3.png)

Let's run `alter system set enable_goldengate_replication = true scope=both;` to enable_goldengate_replicaton, check results.

![](./files/atp/sql_dev_4.png)

We successfully provisioned our Autonomous Database and run necessary pre-requisite steps for later stages.

- [Go to next lab 4](step4.md)
