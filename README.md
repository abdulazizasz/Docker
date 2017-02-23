# Docker
Docker Files
First you need to built the image:
docker build -t hadoop1 .
Once the image is built (named:hadoop1) you need to run it:
docker run -h hadoopSingleCluster -ti hadoop1
The running initiates ubuntu and hadoop. At the end the pi example of hadoop is run, the final line should look somethig like this:
Estimated value of Pi is 3.60000000000000000000
