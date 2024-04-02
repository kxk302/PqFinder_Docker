FROM debian:10

# Install R per instructions below
# https://linuxize.com/post/how-to-install-r-on-debian-10/

# Install the packages necessary to add a new repository over HTTPS
RUN apt -y update && \
    apt -y install dirmngr --install-recommends && \
    apt -y install apt-transport-https &&  \
    apt -y install ca-certificates && \
    apt -y install software-properties-common && \
    apt -y install gnupg2

# Run the following commands to enable the CRAN repository and add the CRAN GPG key to your system
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B8F25A8A73EACF41 && \
    add-apt-repository "deb https://cloud.r-project.org/bin/linux/debian buster-cran40/"

# Update the packages list and install the R package
RUN apt -y update && \
    apt -y upgrade && \
    apt -y install r-base

# Install Git, then clone G4Hunter repo
RUN apt -y update && \
    apt -y install git && \
    git clone https://github.com/kxk302/PqFinder_Docker.git

# Install curl development headers and libxml-2 on your machine
RUN apt -y install libcurl4-openssl-dev && \
    apt -y install libxml2-dev

# Copy scripts folder
ADD scripts /scripts

# Install BiocManager and the needed R packages
RUN Rscript -e "install.packages('BiocManager');"
RUN Rscript -e "install.packages('seqinr');"
RUN Rscript -e "BiocManager::install('pqsfinder');"
RUN Rscript -e "BiocManager::install('rtracklayer');"

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

