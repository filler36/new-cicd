FROM jenkins/jenkins:latest
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
USER jenkins
COPY plugins.txt seed_job.xml seed_job.sh /tmp/
COPY *.groovy /var/jenkins_home/init.groovy.d/
RUN /usr/local/bin/install-plugins.sh < /tmp/plugins.txt
USER root
RUN apt-get update && apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
	curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
	apt-get update && apt-get -y install docker-ce-cli containerd.io
USER jenkins
