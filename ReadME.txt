

---------------------------------Hadoop Steps---------------------------------------
   
1. Upload your pem file on AWS instance. Do the following procedure to give access and do ssh.
	eval `ssh-agent -s`
	chmod 600 Hadoop.pem
	ssh-add Hadoop.pem 

2. Mount additional drives (put Mount.sh script here):

	bash Mount.sh	

3.Format the Hadoop namenode.
 	hadoop namenode -format

4.Start all the services from the hadoop/sbin:
	./hadoop/sbin/start-dfs.sh
	./hadoop/sbin/start-yarn.sh

->  In case nodemanger won't start, start it manually:
	./hadoop/sbin/yarn-deamon.sh start nodemanager

->  Check on master and slave both for the active running services:
	jps

->  Check online for total running datanodes on slave and status:
        MASTER_PUBLIC_DNS:50070

5. Write your Java File and make jar file, add class file to jar.
	hadoop com.sun.tools.javac.Main YOUR_FILE_NAME 
	jar cf JAR_NAME.jar YOUR_FILE_NAME*.class

6. Generate data file with gensort.
	./gensort -a LINES file_path/file_name


7. Put generated data on hadoop file system.
	hadoop fs -mkdir /user
	hadoop fs -mkdir /user/ec2-user
	hadoop fs -mkdir /user/ec2-user/input
	Hadoop fs -put file_path/file_name hadoop_input_path


8. Run the Program:
	hadoop jar ts.jar Terasort input_path output_path


9. Store output from hadoop fs to local fs and validate it:
	hadoop fs -get output/* /PATH
	mv generated_outputname output_file_name

	
10. convert output file with following command:
	sudo yum install unix2dos ( to install application in System)
	unix2dos output_file_name	

11. validate it with valsort:
	./valsort output_file_name








----------------------------------------Spark Steps------------------------------------------




1. by default drive is mounted on /media/ephermal0 which I prefered to /mnt/raid , so Did following changes:
	Put Mount.sh File here and run this
	
	bash Mount.sh	


2. Put Python Program in same folder as Pyspark-shell.


3. Slave nodes are come with drive mounted, to run program go to following path:
	cd spark/
------Open Spark Shell:
	./pyspark

3. type "Python program_name.py" ; it will generate output.

4. To checck the output data:
	
	./hadoop fs -ls /user/root/output/

5. To fetch data from output folder, run following commands:

	./hadoop fs -get /user/root/output/File_number /mnt/raid/

-> It will fetch data from hadoop file system and store it into drive we mounted at /mnt/raid








-----------------------------------------------Shared Memory---------------------------------------


Data Set Generation:
	Generate the data with gensort at location /mnt/raid with file name "input"


1. Run program:
	python Shared_memory_Merge_Sort.py

2. Fetch output file from "/mnt/raid/" , filename: output

3. Convert output file with: unix2dos /mnt/raid/output

4. Check with valsort: ./valsort /mnt/raid/output


