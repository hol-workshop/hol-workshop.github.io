- [Go back to main](/README.md)
- [Go back to previous step](/gglab/step4.md)

!!!GIF file here!!!

## PART 1: Preparing the database for Oracle Goldengate

With Oracle GoldenGate for PosgreSQL, you can perform initial loads and capture transactional data from supported PostgreSQL versions and replicate the data to a PostgreSQL database or other supported Oracle GoldenGate targets, such as an Oracle Database. We have created and pre-loaded some test data into our test Postgresql database in Lab 2. 

Now in this part we will configure our connection to Postgresql database using ODBC driver then we will capture transactional data also it known as extract process. 

We will need 3 extract processes:
  - An extract for changed data capture
  - An extract for sending those capture to GG Microservices
  - An Initial-Load extract ... explanation here

This part describes the tasks for configuring and running Oracle GoldenGate for PostgreSQL and [I used official oracle documentation for this lab](https://docs.oracle.com/en/middleware/goldengate/core/19.1/gghdb/preparing-system-oracle-goldengate3.html)

I'd say there are many requirements for replicating data from PostgreSQL database, review official document if you want extra options such as more security with different privileges et cetera.

Let's begin.

#### Connection to PostgreSQL server from Goldengate 

Oracle GoldenGate for PostgreSQL requires certain PostgreSQL client libraries to replicate the data and therefore, you must Install minimum PostgreSQL client library.

Open up your cloud shell and login to your instance `ssh opc@postgresqldb_ip_address -i using .ssh/id_rsa`, then execute these commands below:
```
sudo rpm -Uvh https://yum.postgresql.org/12/redhat/rhel-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
sudo yum install postgresql11-contrib -y 
sudo yum install postgresql12-contrib -y 
sudo yum install libpq -y
sudo yum install postgresql-odbc.x86_64 -y
```

![](/gglab/files/ggconf/gg_pg_config_0.gif)

#### Configure ODBC connection to PostgreSQL
Oracle GoldenGate Extract connects to a source PostgreSQL database through an ODBC (Open Database Connectivity) connection. Extract uses ODBC Data Direct driver provided by Progress software. The driver libraries are part of Oracle GoldenGate installation. To create this connection, you set up a data source name (DSN) inside the ODBC.ini file.

Extract also connects to the source PostgreSQL database using the libpq native library. This library is shipped with PostgreSQL database and should be accessible by the extract executable.

Create odbc.ini file in ogg installation location, issue:
`vi /home/opc/postgresql/odbc.ini` to create odbc.ini file, because it doesn't exist before. 

_**NOTE:** Editing uses **vi** editor, if you never used it before here is little instruction. When you issue **vi some_file_name** it will either open if that some_file_name exists or create a new file called some_file_name. You have to press **i** for editing the file, then if you are done press **:wq** for save & quit._

Add  following example to odbc.ini file, but make sure you add ** Hostname parameter with your Postgresql database IP Address:
```
[ODBC Data Sources]
PostgreSQL=DataDirect 7.1 PostgreSQL Wire Protocol
[ODBC]
IANAAppCodePage=4
InstallDir=/home/opc/postgresql
[PostgreSQL]
Driver=/home/opc/postgresql/lib/GGpsql25.so
Description=DataDirect 7.1 PostgreSQL Wire Protocol
Database=parkingdata
HostName=
PortNumber=5432
LogonID=postgres
Password=postgres
```

![](/gglab/files/ggconf/gg_pg_config_1.gif)


#### Run GGSCI for the first time

Oracle GoldenGate Classic for Non-Oracle (PostgreSQL) allows you to quickly access the GoldenGate Service Command Interface (GGCSI) and is preconfigured with a running Manager process. After logging in to the compute node

To start GGSCI, execute the following command:

```
export ODBCINI=/home/opc/postgresql/odbc.ini
cd /usr/local/bin/
./ggsci
```

![](/gglab/files/ggconf/gg_pg_config_2.gif)



#### CREATE SUBDIRS

Use `CREATE SUBDIRS` when installing Oracle GoldenGate. This command creates the default directories within the Oracle GoldenGate home directory. Use CREATE SUBDIRS before any other configuration tasks.

#### Goldengate Manager

Once you are in GGSCI, we need to set Goldengate Manager port, issue `EDIT PARAMS MGR` and enter `PORT 7809`. After that start goldengate manager process by issueing `START MGR`
You can check if manager status by issueing `INFO MGR`.

![](/gglab/files/ggconf/gg_pg_config_3.gif)


#### Login to SourceDB 

Run the following command to log into the database:

```DBLOGIN sourcedb PostgreSQL USERID postgres PASSWORD postgres```
You should be able to see belov information saying *Successfully Logged into database*

![](/gglab/files/ggconf/gg_pg_dblogin.png)

You should be able to see above information.

## PART 2: Adding replications

Now you are logged into database in GGSCI console, which means you are ready to proceed. We will create three extract processes and we have five tables in source database.

#### Enabling Supplemental Logging for a Source PostgreSQL Database

After logging to the source database, you must enable supplemental logging on the source schema for change data capture. The following steps are used to enable supplemental logging at table level.

```
add trandata public."Countries"
add trandata public."Cities"
add trandata public."Parkings"
add trandata public."ParkingData"
add trandata public."PaymentData"
```

![](/gglab/files/ggconf/gg_pg_trandata.png)

#### Registering a Replication Slot

Oracle GoldenGate needs to register the extract with the database replication slot, before adding extract process in Goldengate. 
_Ensure to have the DBLOGIN connected to the source database._

We will register each of these three extracts in next 3 steps.

#### Exttar
Let's begin to create the first extract process, which is continuous replication in usual migration and replication project scenario.

First register your extract `register extract exttar`. Then edit extract configuration with `edit params exttar`. 

Insert below as your exttar parameter:
```
EXTRACT exttar
SOURCEDB PostgreSQL USERID postgres PASSWORD postgres
EXTTRAIL ./dirdat/pd
TABLE public."Countries";
TABLE public."Cities";
TABLE public."Parkings";
TABLE public."PaymentData";
TABLE public."ParkingData";
```
and save!

_**NOTE**:Editing uses **vi** editor, so you should enter **i** for insert then **:wq** for save & quit._

After that add your extract using below commands:

```
add extract exttar, tranlog, begin now
add exttrail ./dirdat/pd, extract exttar
```

Confirm everything is correct then start this extract by issueing `start exttar` command.

![](/gglab/files/ggconf/gg_pg_exttar.png)

After completing this step, you should be able to see status of extract with `info all` and result should show you **RUNNING** state.

This process is capturing change data from your source database. As I said earlier this is necessary step for usual migration and replication project. Because changes are being captured in live and some point during this process, you need do initial load to your target database.

#### Extdmp

Now changes are being captured from source database and we need to send that to GG microservices, in order to apply at target database. Therefore we need another process, which acts as extract but sends existing trail files to GG microservices.

First register your extract `register extract extdmp`. Then edit extract configuration with `edit params extdmp`, same as previous step.

Insert below as your extdmp parameter, but **make sure** you change ip_address with your GG Microservice's IP Address!

```
EXTRACT extdmp
RMTHOST ip_address, PORT 9023
RMTTRAIL pd
PASSTHRU
TABLE public."Countries";
TABLE public."Cities";
TABLE public."Parkings";
TABLE public."PaymentData";
TABLE public."ParkingData";
```
and save! 


After that add your extract using below commands

```
add extract extdmp, exttrailsource ./dirdat/pd
add rmttrail pd, extract extdmp, megabytes 50
```

Confirm everything is correct then start this extract by issueing `start extdmp` command.

![](/gglab/files/ggconf/gg_pg_extdmp.png)

After successful creating Extdmp process to your GG Microservices server, open your browser and point to `https://your_microservices_ip_address`. Provide **oggadmin** credentials, then log in.

![](/gglab/files/ggconf/gg_oggadmin.png)

Then click on Target Receiver server port 9023, it will redirect you to new tab, provide your credentials again for username **oggadmin**.

![](/gglab/files/ggconf/gg_oggadmin_0.png)

You should be seeing something like this, what it means that your extdmp is pumping some trail files to your Microservices.

![](/gglab/files/ggconf/gg_oggadmin_1.png)

#### Initload

Now database changes are being transferred to GG Microservices, it is time to do our initial load... explanation

Steps are similar, register your extract `register extract init`. Then edit extract configuration with `edit params init`. 

Insert below as your initial load parameter, but **make sure** you change ip_address with your GG Microservice's IP Address!

```
EXTRACT init
SOURCEDB PostgreSQL USERID postgres PASSWORD postgres
RMTHOST ip_address, PORT 9023
RMTFILE il
TABLE public."Countries";
TABLE public."Cities";
TABLE public."Parkings";
TABLE public."PaymentData";
TABLE public."ParkingData";
```
After that add your initial load process:
```
add extract init, sourceistable
```

Confirm everything is correct then start this extract by issueing `start init` command. You can see status of this special type of extract process with `info init`. 

![](/gglab/files/ggconf/gg_pg_initload.png)

You can see more information about extract process with `view report init`, it is good wayt to investigate your goldengate process result. I can see some good statistics at the end of this report

![](/gglab/files/ggconf/gg_pg_initload_report.png)

## PART 3: Applying changes at Target database using Microservices

This is last part of this HOL. I am glad that we are here. Now we have few configuration steps to do in GG Microservices server, open your browser and point to `https://your_microservices_ip_address`. Provide **oggadmin** credentials, then log in.

![](/gglab/files/ggconf/gg_oggadmin.png)

Then click on Target Receiver server port 9021, it will redirect you to new tab, provide your credentials again for username **oggadmin**.

![](/gglab/files/ggconf/micro_oggadmin_0.png)

#### Add Credentials

You should be seeing empty Extracts and Replicats dashboard. Let's add some Autonomous Database credentials at first. Open hamburger menu on left top corner, choose **Configuration**

![](/gglab/files/ggconf/micro_ggadmin_0.png)

It will open Oggadmin Security and you will see we already have a connection to ATP database, because chosen during our installation in Lab 4. However, you still need to add password here. Click on a pencil icon to alter credentials.

![](/gglab/files/ggconf/micro_ggadmin_1.png)

Provide password ` GG##lab12345 ` and verify it. This is your ggadmin password, which we provided in lab 3. **NOTE: if you used different password, please use that password**

![](/gglab/files/ggconf/micro_ggadmin_2.png)

After that click on **Log in** database icon.

![](/gglab/files/ggconf/micro_ggadmin_3.png)

Scroll to **Checkpoint** part and click on **+** icon, then provide `ggadmin.chkpt` and **SUBMIT**. Checkpoint tables contain the data necessary for tracking the progress of the Replicat as it applies transactions to the target system. Regardless of the Replicat that is being used, it is a best practice to enable the checkpoint table for the target system.

![](/gglab/files/ggconf/micro_ggadmin_4.png)

Now let's go back to **Overview** page from here.

#### Add Replicat

The apply process for replication, also known as Replicat, is very easy and simple to configure. There are five types of Replicats supported by the Oracle GoldenGate Microservices. In overview page, go to Replicat part and click on **+** to create our replicat process.

![](/gglab/files/ggconf/micro_initload_0.png)

We will choose **Nonintegrated Replicat** for initial load, click **Next**. In non-integrated mode, the Replicat process uses standard SQL to apply data directly to the target tables. In our case, number of records in source database is small and we don't need to run in parallel apply, therefore it will suffice.

![](/gglab/files/ggconf/micro_initload_1.png)

Provide your name for replicat process then click on **Credentials Domain** drop-down list. There is only one at the moment, choose available option for you then **Credential Alias** would be your **hol_tp**, which is our pre-created connection group to ATP. After that go below to find **Trail Name** and edit to **il**. We defined this in our initload parameter, so it cannot be just random name. Also provide **Trail Subdirectory** as **/u02/trails** and choose **Checkpoint Table** from drop-down list.

Review everything then click **Next**

![](/gglab/files/ggconf/micro_initload_2.png)

Microservices has created some draft parameter file for your convenience, let's edit to our need.

![](/gglab/files/ggconf/micro_initload_3_1.png)

Erase exisiting and paste below configuration 

```
replicat initload
useridalias hol_tp domain OracleGoldenGate
MAP public."Countries", TARGET admin.Countries;
MAP public."Cities", TARGET admin.Cities;
MAP public."Parkings", TARGET admin.Parkings;
MAP public."ParkingData", TARGET admin.ParkingData;
MAP public."PaymentData", TARGET admin.PaymentData;
```

![](/gglab/files/ggconf/micro_initload_3_2.png)

I hope everything is correct until this stage. Click **Create and Run** to start our replicat.

![](/gglab/files/ggconf/micro_initload_4.png)

You can see details of running replicat process. In statistics tab, you'd see some changes right away.

![](/gglab/files/ggconf/micro_initload_5.png)

!!! GIF FILES !!!
