# pqsfinder

The main functionality of pqsfinder is to detect DNA and RNA sequence patterns that are likely to fold into G-quadruplexes (G4)
[1][2][3]. pqsfinder is written in R programming language. The Biocoinductor package is available at https://www.bioconductor.org/packages/release/bioc/html/pqsfinder.html.

Running pqsfinder requires installation of a specific version of R, and specific versions of several R packages as depenecies. These
steps take some time and are different for different operating systems. In this project, we Dockerize pqsfinder to avoid repeating
these configuration steps everytime a user wants to run pqsfinder. A text file called a Dockerfile is used to specify all the
configuration steps. A Docker engine creates a Docker image from the Dockerfile. Docker engine runs containers created off of the
docker image. Container technologies such as Docker also offer other benefits such as portability, performance, agility, isolation,
and scalability [4].

In order to run the Dockerized version of pqsfinder, you need to have the Docker engine installed on your box. Please refer to
instructions at https://docs.docker.com/engine/install/. You also need the pqsfinder Docker image. You can either get the pqsfinder
Docker image from Docker Hub, or you can build the image locally. If you are getting the image from the Docker Hub (preferred),
you can skip the instructions for building/pushing the image, and go to the instructions for running pqsfinder Docker container.

# Getting the pqsfinder Docker Image

To pull the pqsfinder Docker image from the Docker Hub repository:
> docker pull kxk302/pqsfinder:1.0.0

To view the pulled image:
> docker images -f "reference=kxk302/pqsfinder:1.0.0"

# Building/Pushing the pqsfinder Docker Image

All the commands are run in the same directory, say, /Users/kxk302/workspace/

Clone PqsFinder_Docker repository (This creates a folder called PqsFinder_Docker):
> git clone https://github.com/kxk302/PqsFinder_Docker.git

Change your directory to PqsFinder_Docker folder:
> cd ./PqsFinder_Docker

To create a Docker image:
> docker build --progress=plain -t kxk302/pqsfinder:1.0.0 .

To view the created image:
> docker images -f "reference=kxk302/pqsfinder:1.0.0"

To push the created image to your Docker Hub repository (You need to be regsitered at https://hub.docker.com/):
> docker login\
> docker push kxk302/pqsfinder:1.0.0

# Running the pqsfinder Docker Container

Suppose the fasta file for pqsfinder is at '/Users/kxk302/workspace/PqFinder_Docker/genomes/Homo_sapiens/chr22.fa'. The fasta file
name is 'chr22.fa', the fasta file folder is '/Users/kxk302/workspace/PqFinder_Docker/genomes/Homo_sapiens/', and the absolute path
to fasta file name is '/Users/kxk302/workspace/PqFinder_Docker/genomes/Homo_sapiens/chr22.fa'.

Suppose the output file for pqsfinder is at '/Users/kxk302/workspace/PqsFinder_Docker/output/Homo_sapiens/pqsf_out_chr22.fasta'.
The output file name is 'pqsf_out.fasta', the output file folder is '/Users/kxk302/workspace/PqsFinder_Docker/output/Homo_sapiens/',
and absolute path to output file name is '/Users/kxk302/workspace/PqsFinder_Docker/output/Homo_sapiens/pqsf_out_chr22.fasta'.

Besides the fasta and output files, pqsfinder accepts minimum score and a True/False flag indicating whether overalpping G4s should be reported or not.

On Unix/Mac OS, to run the containerized version of pqsfinder, run the following command:
> ./scripts/run_pqsfinder.sh FastaFileAbsolutPath OutputFileAbsolutePath MinScore Overlapping

For example:

> ./scripts/run_pqsfinder.sh /Users/kxk302/workspace/PqFinder_Docker/genomes/Homo_sapiens/chr22.fa /Users/kxk302/workspace/PqsFinder_Docker/output/Homo_sapiens/pqsf_out_chr22.fasta 30 TRUE

On Windows, to run the containerized version of pqsfinder, run the following command:

> docker run -v $FastaFile:/$FastaFileName -v $OutputDir:/output kxk302/pqsfinder:1.0.0 /$FastaFileName /output/$OutFileName $MinScore $Overlapping

Below is an actual invocation of Dockerzed pqsfinder:

> docker run -v /Users/kxk302/workspace/PqFinder_Docker/genomes/Homo_sapiens/chr22.fa:/chr22.fa -v /Users/kxk302/workspace/PqsFinder_Docker/output/Homo_sapiens:/output kxk302/pqsfinder:1.0.0 /chr22.fa /output/pqsf_out_chr22.fasta 30 TRUE

The -v flag simply mounts a folder on your host machine to the container, to make your local files accessible to the container.

# References

1. pqsfinder: an exhaustive and imperfection-tolerant search tool for potential quadruplex-forming sequences in R.
   Jiří Hon, Tomáš Martínek, Jaroslav Zendulka, Matej Lexa. Bioinformatics, Volume 33, Issue 21,
   November 01, 2017, Pages 3373–3379, https://doi.org/10.1093/bioinformatics/btx413

2. https://www.bioconductor.org/packages/release/bioc/html/pqsfinder.html

3. https://pqsfinder.fi.muni.cz

4. https://www.microfocus.com/documentation/visual-cobol/vc60/EclUNIX/GUID-F5BDACC7-6F0E-4EBB-9F62-E0046D8CCF1B.html
