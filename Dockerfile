FROM metaboigniter/container-rbase:v4.0.2-xenial0_cv0.2

LABEL software.version=4.0.1
LABEL version=4.0.1
LABEL software=CSIFingerID

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL Description="Metabolite identification"



RUN R -e 'install.packages(c("R.utils","tools"),repos = "http://cran.us.r-project.org")'
# Update & upgrade sources
RUN apt-get -y update

# Install development files needed
RUN apt-get -y install wget default-jre-headless unzip

# Clean up
RUN apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*


ADD sirius-linux64-headless-4.0.1 /usr/local/bin/CSI

ADD scripts/*.r /usr/local/bin/
RUN chmod +x /usr/local/bin/*.r
RUN chmod +x /usr/local/bin/CSI/bin/sirius

# Add testing to container
ADD runTest1.sh /usr/local/bin/runTest1.sh
RUN chmod +x /usr/local/bin/runTest1.sh

# Define Entry point script

