FROM metaboigniter/container-rbase:v4.0.2-xenial0_cv0.2


LABEL software.version=4.4.29
LABEL version=4.4.29
LABEL software=CSIFingerID

MAINTAINER Payam Emami ( payam.emami@scilifelab.se )

LABEL Description="Metabolite identification"



RUN R -e 'install.packages(c("R.utils","tools"),repos = "http://cran.us.r-project.org")'
# Update & upgrade sources
RUN apt-get -y update && apt-get -y install software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get -y update

# Install development files needed
RUN apt-get -y install wget openjdk-11-jdk unzip parallel

# Clean up
RUN apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*


ADD sirius-4.5.1 /usr/local/bin/CSI

ADD scripts/*.r /usr/local/bin/
RUN chmod +x /usr/local/bin/*.r
RUN chmod +x /usr/local/bin/CSI/bin/sirius

# Add testing to container
ADD runTest1.sh /usr/local/bin/runTest1.sh
RUN chmod +x /usr/local/bin/runTest1.sh

# Define Entry point script

RUN /usr/bin/printf '\xfe\xed\xfe\xed\x00\x00\x00\x02\x00\x00\x00\x00\xe2\x68\x6e\x45\xfb\x43\xdf\xa4\xd9\x92\xdd\x41\xce\xb6\xb2\x1c\x63\x30\xd7\x92' > /etc/ssl/certs/java/cacerts
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure
