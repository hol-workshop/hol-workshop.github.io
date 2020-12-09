
- [Go back to main](./README.md)
- [Go back to previous step](step3.md)

# Lab 4 - Explore Oracle Marketplace and create your Goldengate instances

Now let's continue to create your Oracle Goldengate Instances using Marketplace. This lab consists of 2 parts. 

As you can see in architecture diagram, we will have to create 2 Goldengate instances, one for non-oracle and second is for Oracle databases. We have already created SOURCE in [Lab 2](/gglab/step2.md) and TARGET in [Lab 3](/gglab/step3.md).

![](/gglab/files/Architecture.png)

## What is Oracle Marketplace? 

Oracle Cloud Marketplace is an online store—a one-stop shop—selling hundreds of business apps and professional services that complement your existing Oracle Cloud implementation. 

All apps and services on the marketplace are offered by approved, registered, and expert partners and developers. Plus, Oracle has vetted, reviewed, and approved each product.
Oracle Cloud Marketplace offers a vast collection of trusted and innovative apps in many business categories, including migration solutions like Goldengate. 
[Source](/https://docs.oracle.com/en/cloud/marketplace/marketplace-cloud/appst/whats-oracle-cloud-marketplace.html#GUID-BC48BE32-949F-4B3B-8EDE-FE59F423FCDF)

#### Let's explore Oracle Marketplace in OCI

You can browse the apps and services on Oracle Cloud Marketplace, evaluate whether the offering fits your needs, and then get the app or service. There are many free softwares and paid softwares in Marketplace.

Go to left top hamburger icon and navigate to **_Marketplace_** then choose **_Applications_**

![](/gglab/files/ogg/pg_mp_0.png)

## Part 1: Oracle Goldengate for non-oracle database

As I mentioned, we will install Goldengate in VM instance, it is similar to Lab 2.

#### Find correct product from Marketplace

Search for "Goldengate" in search pane and choose **Oracle GoldenGate for Non-Oracle** option.

![](/gglab/files/ogg/pg_mp_1.png)

Find **PostgreSQL - Classic - Promotional** offer from version's drop down list then choose correct compartment to create in it. 

Notice that Software price per OCPU is **BYOL**, meaning this is free until promotional period expires. *Please review and accept terms and conditions* then click on **Launch Stack**.

![](/gglab/files/ogg/pg_mp_2.png)

#### Provide a meaningful name for your Stack.

Name it to HOL_PostgreSQL and click **Next**
![](/gglab/files/ogg/pg_mp_3.png)

#### Name your VM instance.

Change default Display name to **HOL_OGG_PG** and HOST DNS NAME to **ogg19cpgsql**

![](/gglab/files/ogg/pg_mp_4.png)

#### Select VCN and subnet

Under Networking Settings, you make sure you choose same compartment as previous lab and correct VCN, Public Subnet is selected 

![](/gglab/files/ogg/pg_mp_5.png)

#### Instance Settings

Choose your availability domain, I will choose different AD than what I chosen Lab 2 for my postgresql database. For compute shape please choose **VM.Standard2.1**

Most importantly, please tick **ASSIGN PUBLIC IP**, don't forget this step.

![](/gglab/files/ogg/pg_mp_6.png)

#### Shell Access

This means SSH public key is needed here. You can use previously created public ssh key using CloudShell. Open CloudShell and execute command `cat .ssh/id_rsa.pub`. Copy and paste id_rsa.pub file content.

![](/gglab/files/ogg/pg_mp_7.png)

#### Review

Review your choices if needed and click **Create** to continue.

![](/gglab/files/ogg/pg_mp_9.png)


#### Resource Manager Job created

Creating instances using Marketplace uses Terraform orchestration. Here you are seeing execution of terraform.

![](/gglab/files/ogg/pg_mp_10.png)


#### Resource Manager Job succeeded

Once your resource is successfully created, you will see status change and turns to nice green color. You can check log output and notice _ogg_public_ip_.

![](/gglab/files/ogg/pg_mp_11.png)

#### Test your instance

After you launch an instance, you can access it securely. Let's open **Cloud Shell** and test your connection to your new Goldengate instance you just created.

`ssh ubuntu@ip_address -i ~/.ssh/id_rsa`

Enter 'yes' when prompted for security message, and enter your passphrase.

![](/gglab/files/ogg/pg_login.png)

Nice thing of using terrraform is you can modify variables of your Resource Stack, and click **Plan** and then **Apply**. 
![](/gglab/files/ogg/pg_mp_9.png)

## Part 2: Oracle Goldengate for oracle database Microservices Edition

This is almost same as Part 1, but we will install Goldengate Microservices this time. Again navigate to **Marketplace** choose **Applications**

#### Find correct product from Marketplace

Search for "Goldengate" in search pane and choose **Oracle GoldenGate for Oracle** option.

![](/gglab/files/ogg/micro_mp_1.png)

Find **Micrservices Edition - Promotional** offer from version's drop down list then choose correct compartment. 

Notice that Software price per OCPU is **BYOL**, meaning this is free until promotional period expires. *Please review and accept terms and conditions* then click on **Launch Stack**.

![](/gglab/files/ogg/micro_mp_2.png)

#### Provide a meaningful name for your Stack.

Name it to **HOL_Microservices** and click **Next**

![](/gglab/files/ogg/micro_mp_3.png)

#### Name your VM instance.

Change default Display name to **HOL_OGG_Microservice** and HOST DNS NAME to **ogg19micro**

![](/gglab/files/ogg/micro_mp_4.png)

#### Select VCN and subnet

Under Networking Settings, you make sure you choose same compartment as previous lab and correct VCN, Public Subnet is selected 

![](/gglab/files/ogg/micro_mp_5.png)

#### Instance Settings

Choose your availability domain, I will choose different AD than what I chosen Part 1 of this lab, for example **AD-3** in this case. For compute shape please choose **VM.Standard2.1**

Most importantly, please tick **ASSIGN PUBLIC IP**, don't forget this step.

![](/gglab/files/ogg/micro_mp_6.png)

#### Create OGG Deployments

Goldengate Microservices usually needs 2 deployments, source and target. We will choose **Oracle 11g** in deployment 1 and **Oracle 19c** in deployment 2. We are choosing these, becaue they are mandatory. But we will not use deployment 1.

Then you need to tick **DEPLOYMENT 2 - AUTONOMOUS DATABASE**. 

This will ask you to choose correct compartment and name of **Autonomous Database Instance**, which you created in Lab 3. 

We select this option, because the Autonomous Database wallets and credential files get imported automatically, which makes easier to connect to the Autonomous Database.

![](/gglab/files/ogg/micro_mp_7_2.png)

#### Shell Access

This means SSH public key is needed here. You can use previously created public ssh key using CloudShell. Open CloudShell and execute command `cat .ssh/id_rsa.pub`. Copy and paste id_rsa.pub file content.

![](/gglab/files/ogg/micro_mp_8.png)

#### Review

Review your choices if needed and click **Create** to continue.

![](/gglab/files/ogg/micro_mp_9.png)


#### Resource Manager Job created

Creating instances using Marketplace uses Terraform orchestration. Here you are seeing execution of terraform.

![](/gglab/files/ogg/micro_mp_10.png)


#### Resource Manager Job succeeded

Once your resource is successfully created, you will see status change and turns to nice green color. You can check log output and notice _ogg_public_ip_.

![](/gglab/files/ogg/micro_mp_11.png)

#### Test your instance

After you launch an instance, you can access it securely. Let's open **Cloud Shell** and test your connection to your new Goldengate instance you just created.

`ssh ubuntu@ip_address -i ~/.ssh/id_rsa`

Enter 'yes' when prompted for security message, and enter your passphrase.

Then enter following command `sudo systemctl stop firewalld` to avoid any hassle

![](/gglab/files/ogg/micro_login_2.png)

OR we can open correct firewall ports using following commands:
```
sudo firewall-cmd --zone=public --permanent --add-port=9011-9014/tcp
sudo firewall-cmd --zone=public --permanent --add-port=9021-9024/tcp
sudo firewall-cmd --zone=public --permanent --add-port=443/tcp
sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
sudo firewall-cmd --zone=public --permanent --add-port=7809-7810/tcp
sudo firewall-cmd --reload
```

#### Get OGGADMIN user's password

Issue `cat ogg-credentials.json` command and copy credential output in **Cloud Shell** terminal. Now let's login to microservices.

Open your browser and issue `https://ip_address` hit enter, it will prompt SSL certificate, we know it's okay so accept and continue.

![](/gglab/files/ogg/micro_login_1.png)

You will be prompted to enter username provide **OGGADMIN**. Password is output what we copied.

![](/gglab/files/ogg/micro_login.gif)

Before we going forward, let's just confirm everything we have:
 1. HOL_OGG_Microservie instance
 2. HOL_OGG_PG instance
 3. HOL_PostgreSQL instance
 4. HOL_ATP autonomous database
 
Now we are ready to proceed to fun part.
 
- [Go to last lab 5](step5.md)
