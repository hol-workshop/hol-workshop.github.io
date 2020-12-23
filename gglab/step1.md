- [Go back to main](README.md)
# Lab 1
Either you successfully just created your cloud account or you already had some fun with OCI, we will proceed to from here. 


OCI has vast cloud services that enable you to build and run a wide range of applications and services in a highly available hosted environment. OCI offers high-performance compute capabilities (as physical hardware instances) and storage capacity in a flexible overlay virtual network that is securely accessible from your on-premises network.


This HOL aims to achieve migration from PostgreSQL to ATP with minimal configuration. There are many security consideration if you'd like to ensure as secure as possible. 


However we will ignore many of it's requirements and jumps directly to Virtual Cloud Network creation process.

### What is virtual Cloud Networks?
Oracle Cloud Infrastructure Compute lets you create multiple Virtual Cloud Networks (VCNs), a virtual, private or public network that you set up in Oracle data centers. It closely resembles a traditional network, with firewall rules and specific types of communication gateways that you can choose to use. 

## Part 1. Create your VCN

Go to hamburger icon in top left corner of OCI Console Home page, navigate to  **Networking** and choose **Virtual Cloud Networks**.

![](files/vcn/vcn_0.png)

Select your Root compartment in left pane of OCI console.

![](files/vcn/vcn_1.png)

Click on **Start VCN Wizard**

![](files/vcn/vcn_2.png)

Then choose the first option, **VCN with Internet Connectivity**. It will take you to the wizard. Click on **Start VCN Wizard**

![](files/vcn/vcn_3.png)

Provide name of VCN as **HOLVCN**. CIDR is a range of ip address for your VCN. It's okay to proceed with default or modify as you want. Be sure you ticked **DNS hostnames**

Press the **Next** button at the bottom of the screen.
 
![](files/vcn/vcn_4.png)

There is not much to do at this stage, review and click on **CREATE**

![](files/vcn/vcn_5.png)

Wizard should be creating your VCN as you clicked on create button. It will take a moment to create the VCN and you can see status of overall process.

![](files/vcn/vcn_6.png)

Once you see that the creation is complete (see previous screenshot), click on the **View Virtual Cloud Network** button.

## Part 2. Adding security rules

The Networking service offers two virtual firewall features that both use security rules to control traffic at the packet level. We will only configure security lists.

- Security lists: allows you define a set of security access rules that applies to all the VNICs in an entire Public or Private subnets. 

We will have to enable some ports access, which is called ingress rules to our Public subnet, since this HOL is for minimal complexity. 

#### Find your Public Subnet

Go to your HOLVCN and open **Subnets** and choose **Public Subnet-HOLVCN**

![](./files/vcn/ingress_0.png)

Click on **Default Security List for HOLVCN**, where you will enable ports.

![](./files/vcn/ingress_1.png)

Click on **Add Ingress Rules**, meaning that we will grant incoming requests from internet to our Public Subnet.

![](./files/vcn/ingress_2.png)

Enter  `0.0.0.0/0` to **SOURCE CIDR**, which allows traffic from any address, then enter following ports `80, 443, 7809-7811, 9011-9014, 9021-9024, 5432` in **Destination Port Range**. These ports are required for Postgresql, Oracle Database, HTTP/HTTPS and Goldengate Microservices to accomplish our lab.

![](./files/vcn/ingress_3.png)

What did we do? We added number of ports to our default security list which is assigned to Public subnet. Anyone from internet can now make request to following ports to your services running on public subnet.


![](./files/vcn/ingress_4.png)


#### Summary
This VCN will contain all of the other assets that you will create during this set of labs. In real-world situations, like highly secure environment, we would have configured it differently. You maybe should configure IPSEC VPN to your on-premise network, also there is a term stateless rule for consideration if you have a high-volume internet-facing website, additionally there is also Network security groups. Please visit official OCI documentation website for additional security concerns.

Now proceed to next lab. 

- [Go to next lab 2](step2.md)
