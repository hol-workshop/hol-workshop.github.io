- [Go back to main](/README.md)
- [Go back to previous step](/gglab/step2.md)

# Lab 3 - Create your target Autonomous Database

### What deployment options are available for Autonomous Database?

There are two options for deploying an autonomous database.
- Serverless deployment. In serverless deployment, multiple users share the same cloud infrastructure resources. Serverless deployment is the simplest option; it requires no minimum commitment and users can take advantage of quick data provisioning and application development. Users also enjoy independent compute and storage scalability. In this deployment model, users are responsible for database provisioning and management while the provider takes care of infrastructure deployment and management responsibilities.
- Dedicated deployment. Dedicated deployment allows the user to provision the autonomous database within a dedicated (unshared) cloud infrastructure. This deployment model has no shared processor, memory, network, or storage resources. Dedicated deployment offers greater control and customization over the entire environment and is ideal for users who want to tailor their autonomous database to meet specific organizational needs. Additionally, dedicated deployment allows for an easy transition from on-premise databases to a fully autonomous and isolated private database cloud.
### What type of workloads can your run in an Autonomous Database?

An autonomous database consists of two key elements that align with workload types.
- Data warehouse performs numerous functions related to business intelligence activities, and uses data that’s been prepared in advance for analysis. The data warehouse environment also manages all database lifecycle operations, can perform query scans on millions of rows, is scalable to business needs, and can be deployed in a matter of seconds.
- Transaction processing enables time-based transactional processes such as real-time analytics, personalization, and fraud detection. Transaction processing typically involves a very small number of records, is based on predefined operations, and allows for simple application development and deployment.

Login to the Oracle Cloud, as shown in the previous lab.

Once you are logged in, you are taken to the cloud services dashboard where you can see all the services available to you. Click the navigation menu in the upper left to show top level navigation choices.

Note: You can also directly access your Autonomous Data Warehouse or Autonomous Transaction Processing service in the Quick Actions section of the dashboard.


Click Create Autonomous Database to start the instance creation process.

Click Create Autonomous Database.

This brings up the Create Autonomous Database screen where you will specify the configuration of the instance.

Provide basic information for the autonomous database:

    Choose a compartment - Select a compartment for the database from the drop-down list.
    Display Name - Enter a memorable name for the database for display purposes. For this lab, use ADW Finance Mart.
    Database Name - Use letters and numbers only, starting with a letter. Maximum length is 14 characters. (Underscores not initially supported.) For this lab, use ADWFINANCE.

Enter the required details.

Choose a workload type. Select the workload type for your database from the choices:

    Data Warehouse - For this lab, choose Data Warehouse as the workload type.
    Transaction Processing - Alternatively, you could have chosen Transaction Processing as the workload type.

Choose a workload type.

Choose a deployment type. Select the deployment type for your database from the choices:

    Shared Infrastructure - For this lab, choose Shared Infrastructure as the deployment type.
    Dedicated Infrastructure - Alternatively, you could have chosen Dedicated Infrastructure as the deployment type.

Choose a deployment type.

Configure the database:

    Always Free - If your Cloud Account is an Always Free account, you can select this option to create an always free autonomous database. An always free database comes with 1 CPU and 20 GB of storage. For this lab, we recommend you leave Always Free unchecked.
    Choose database version - Select a database version from the available versions.
    OCPU count - Number of CPUs for your service. For this lab, specify 2 CPUs. Or, if you choose an Always Free database, it comes with 1 CPU.
    Storage (TB) - Select your storage capacity in terabytes. For this lab, specify 1 TB of storage. Or, if you choose an Always Free database, it comes with 20 GB of storage.
    Auto Scaling - For this lab, keep auto scaling enabled, to allow the system to automatically use up to three times more CPU and IO resources to meet workload demand.
    New Database Preview - If a checkbox is available to preview a new database version, do NOT select it.

Note: You cannot scale up/down an Always Free autonomous database.

Choose the remaining parameters.

Create administrator credentials:

    Password and Confirm Password - Specify the password for ADMIN user of the service instance. The password must meet the following requirements:
    The password must be between 12 and 30 characters long and must include at least one uppercase letter, one lowercase letter, and one numeric character.
    The password cannot contain the username.
    The password cannot contain the double quote (") character.
    The password must be different from the last 4 passwords used.
    The password must not be the same password that is set less than 24 hours ago.
    Re-enter the password to confirm it. Make a note of this password.

Enter password and confirm password.

Choose network access:

    For this lab, accept the default, "Allow secure access from everywhere".
    If you want a private endpoint, to allow traffic only from the VCN you specify - where access to the database from all public IPs or VCNs is blocked, then select "Virtual cloud network" in the Choose network access area.
    You can control and restrict access to your Autonomous Database by setting network access control lists (ACLs). You can select from 4 IP notation types: IP Address, CIDR Block, Virtual Cloud Network, Virtual Cloud Network OCID).

Choose the network access.

Choose a license type. For this lab, choose License Included. The two license types are:

    Bring Your Own License (BYOL) - Select this type when your organization has existing database licenses.
    License Included - Select this type when you want to subscribe to new database software licenses and the database cloud service.

Click Create Autonomous Database.

Click Create Autonomous Database.

Your instance will begin provisioning. In a few minutes, the state will turn from Provisioning to Available. At this point, your Autonomous Data Warehouse database is ready to use! Have a look at your instance's details here including its name, database version, OCPU count, and storage size.
