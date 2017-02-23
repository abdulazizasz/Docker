# Docker<br />
Docker Files<br />
First you need to built the image:<br />
docker build -t hadoop1 .<br />
Once the image is built (named:hadoop1) you need to run it:<br />
docker run -h hadoopSingleCluster -ti hadoop1<br />
The running initiates ubuntu and hadoop. At the end the pi example of hadoop is run, the final line should look somethig like this: <br />
Estimated value of Pi is 3.60000000000000000000 
