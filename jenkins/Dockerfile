from filler36/jenkins:4
USER root
RUN apt-get update && apt-get install -y net-tools && apt-get install -y supervisor
COPY seed_job.xml seed_job.sh dockerhostip.sh /tmp/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ENTRYPOINT ["/usr/bin/supervisord"]
