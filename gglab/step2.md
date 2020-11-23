- [Go back to main](/README.md)
- [Go back to previous step](/gglab/step1.md)

# Step 2
description

Go to the OCI console. From OCI services menu, under Compute, click Instances.

## 1.Create your PostgreSQLDB instance
- Click Create Instance. Fill out the dialog box:
    **Name your instance**: Enter a name
    **Create in Compartment**: Choose the same compartment you used to create the VCN
    
![](/files/pgsql/pg_1.png)

## 2.Choose AD 
- Choose your AD, some may see only one AD depending on your region and click on "Change Image", we will choose Ubuntu...

![](/files/pgsql/pg_2_1.png)

## 3.Change image 
- Any Ubuntu version should work, but stick to 18.04

![](/files/pgsql/pg_2_2.png)

## 4.step name
- Choose from available shapes for your tenancy. maybe more image needed here... will confirm

![](/files/pgsql/pg_3.png)

## 5.Select VCN
- Under Configure Networking:

**Virtual cloud network compartment**: Select your compartment

**Virtual cloud network**: Choose the VCN you created in Step 1

**Subnet Compartment**: Choose your compartment.

**Subnet**: Choose the Public Subnet under Public Subnets

**Use network security groups to control traffic** : Leave un-checked

**Assign a public IP address**: Check this option

![](/files/pgsql/pg_4.png)

## 6.Save SSH Keys
- Save private and public keys.

![](/files/pgsql/pg_5_1.png)

## 7.Add SSH Keys 
- Click "choose public key files", then drag and drop previously saved public key.

![](/files/pgsql/pg_5_2.png)

## OR this step 
- Click "choose public key files" then click on "Browse". find your file and upload.

![](/files/pgsql/pg_5_3.png)

## 8.step 
- show advanced options

![](/files/pgsql/pg_6_1.png)

## 9.step 
- Choose cloud init script file and upload required file to install postgresql database. You can download it [here](/files/pgsql/ubuntu_cloud_init.sh). Download and save it as ubuntu_cloud_init.sh 

![](/files/pgsql/pg_6_2.png)

## 10.step 
- Review everything and click on "Create" button.

![](/files/pgsql/pg_7.png)

## 11.Wait for Instance to be in Running state. In Cloud Shell Terminal, enter:
- It will take 1-2 minutes..

![](/files/pgsql/pg_8.png)

## 12.step 
- Open git bash and check your connection to public IP address. Issue:
```
   ssh ubuntu@ip_address -i your_private_key
```
Enter 'yes' when prompted for security message, and enter your passphrase.
![](/files/pgsql/pg_9.png)

Ready.
