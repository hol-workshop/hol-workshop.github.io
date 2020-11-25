================= JC CHANGES were here

- [Go back to main](/README.md)
# Lab 1

We will create Compartment and VCN.


A compartment is a collection of cloud assets, like compute instances, load balancers, databases, etc. By default, a root compartment was created for you when you created your tenancy (ie when you registered for the trial account). It is possible to create everything in the root compartment, but Oracle recommends that you create sub-compartments to help manage your resources more efficiently.
<<<<<<< main

## Step 1: Create Compartment 

1. From the menu, select **Identity** then **Compartments**. 

![](./files/vcn/compartment_0.png)

2. Click on the blue **Create Compartment** button to create a sub-compartment under your root compartment. You will have different name than in example.

![](./files/vcn/compartment_1.png)

3. Provide your name and description for your compartment...

![](./files/vcn/compartment_2.PNG)

## Step 2: Create VCN

Steps needed here..

- [Go back to Next step](/gglab/step2.md)
=======
 
 
 
 
## Virtual Cloud Networks

### Introduction: 

Oracle Cloud Infrastructure Compute lets you create multiple Virtual Cloud Networks (VCNs). These VCNs will contain the security lists, compute instances, load balancers and many other types of network assets.

Be sure to review Overview of Networking to gain a full understanding of the network components and their relationships, or take a look at this [video](/https://www.youtube.com/embed/mIYSgeX5FkM) 



### STEP 1: Create Your VCN 

To create a VCN on Oracle Cloud Infrastructure:

 1. On the Oracle Cloud Infrastructure Console Home page, under the Quick Actions header, click on **Set up a network with a wizard**.

![](./files/vcn/setupVCN2.PNG)

 2. Select VCN with Internet Connectivity, and then click **Start VCN Wizard**.

![](./files/vcn/setupVCN3.PNG)

 3. Complete the following fields selecting your Root compartment:


 4. Press the **Next** button at the bottom of the screen.
 
 
 5. Review your settings to be sure they are correct.
 
 
 6. Press the **Create** button to create the VCN. It will take a moment to create the VCN and a progress screen will keep you apprised of the workflow.
 
 
 7. Once you see that the creation is complete (see previous screenshot), click on the **View Virtual Cloud Network** button.
 
 
 ### Summary
This VCN will contain all of the other assets that you will create during this set of labs. In real-world situations, you would create multiple VCNs based on their need for access (which ports to open) and who can access them.
 
>>>>>>> lab-1-JC

