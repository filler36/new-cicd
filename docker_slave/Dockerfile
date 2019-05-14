from ubuntu
USER root
RUN apt-get update && apt-get install -y net-tools git cppcheck g++ default-jre
RUN useradd -m -p $(openssl passwd -1 jenkins) jenkins && mkdir -p /home/jenkins/.m2
RUN apt-get install -y unzip wget && \
  wget -P /tmp/ https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip && \
  unzip /tmp/sonar-scanner-cli-3.3.0.1492-linux.zip -d /opt/ && \
  mv /opt/sonar* /opt/sonar 
RUN echo "export PATH=$PATH:/opt/sonar/bin" >> /home/jenkins/.profile
RUN apt-get install -y --no-install-recommends sudo
RUN apt-get install -y curl
RUN echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
COPY scr.sh /tmp/scr.sh
ENTRYPOINT sudo chmod 777 /etc/hosts && sudo /tmp/scr.sh && /bin/bash
