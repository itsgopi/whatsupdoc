# whatsupdoc

This is an experimental project to host multiple instance of a webserver in AWS and access its services using ELB.

You can visit http://whatsupdoc-998411791.ap-northeast-1.elb.amazonaws.com/

Technical details
-----------------

1. Three t2.micro EC2 Instance
2. Software Stack : Ubuntu 14.04 OS + NGNIX +  Wordpress (with AWS/S3 plug-ins) 
3. One instance for development and staging. Code base is maintained in git hub.
4. Two instances for running webserver instances
5. Static content are stored in the each instance's storage (EBS)
6. Dynamic content are stored in S3 bucket (user-upload) and in RDS mysql database; 

Note : Architecture Diagram is available in doc folder 

Work Flow
----------
1. Git clone code base to Development server
2. Do the coding development
3. do the testing on development server's public DNS IP
4. push the code to Git hub
5. Generate new AMI image
6. Create new Instances out of this new AMI

Note : Instead of steps #5& #6, 
        we can push the changes to all the running instances through scripts and s3fs-fuse shared folder
		or use OpsWorks
		Both these options I am yet to try.

Installation steps
------------------

I have chosen NGNIX as Webserver and Wordpress as CMS.

1. Create an AWS Account

2. Choose a Region and create a VPC and separate subnet for each available zones

3. Create separate security group for Development Instance, Webserver Instances, RDS , ELB

4. Create a RDS , create database, username, password and assign RDS-SG

5. Create a S3 Bucket to store user uploaded content in webserver and share across instances

6. Create a Development server Instance (t2-micro, Ubuntu)

7. Download the whatsupdoc git repo and run the install.sh script to install the software bundle(nginx,mysql,php wordpress etc)

8. verify if the webserver is accessible from public and complete the wordpress installation

9. Create AMI image out of Development server 

10. start two instances in separate available zones. Assign the respective subnet and security group.

11. Create ELB Load balance and assign the two instances to it

12. update RDS database entries if need to update the hostname as ELB url instead of development server url

13. verify if accessing ELB's public dns url reaches the webpages

14. Run load balance traffic testing (curl-loader) on any linux based machine. 
    Update the URL in the conf file before running.   
	Check the cloudwatch metrics to see if both webserver instances are load shared
	
     ./curl-loader -f bulk.conf


