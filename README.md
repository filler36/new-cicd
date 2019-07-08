## Prerequisites
Our project requires to Enable Docker Remote API. You can check it with command netstat -tulnp. If There
is dockerd listening port 4243. If it's not, you have to Enable Docker Remote API. You can find instructions here: https://scriptcrunch.com/enable-docker-remote-api/.

## Project description
To launch our infrastructure just clone this repo and run **docker-compose up** command. You can see our infrastructure by command **docker ps -a**. You will see three containers: Jenkins, Sonar, Artifactory and their ports exposed. To get into web-interfaces of these servers just copy the links below to your web browser:

**Jenkins** 		http://localhost	(user: admin, password: admin)  
**Artifactory**		http://localhost:8081	(user: admin, password: password)  
**Sonar** 		http://localhost:9000	(user: admin, password: admin)

After you get into web-interface of the Jenkins you will not see any jobs. To create seed job in our Jenkins via REST API just execute the command below in command shell:
**docker exec -dit new-cicd_jenkins_1 sh -c "cd /tmp/ && ./seed_job.sh"**  
After that you can run seed job manually from Jenkins Web-interface. When job will finished you will see one new **pipeline** job. This Job will starts automatically for the first time. Pipeline job will run on the docker agent. After job is will finished the docker agent will be automatically stopped and removed.
Our pipeline job consists from 5 stages:

**1. Git clone project.** Cloning the repository into our work directory.  
**2. Analyzing project.** Analyzing our code with cppcheck utility and saving results to report.xml file.  
**3. Sending report to Sonar**. Sending our report.xml file to Sonar server.  
**4. Compilation build.** Compiling our code into app.  
**5. Publishing artifact to repository".** Publishing our artifact into Artifactory.  
  
[docker-compose.yml](docker-compose.yml) This is a docker-compose file that describes our CI infrastructure  
[jenkins/csrfProtection.groovy](jenkins/csrfProtection.groovy) This script enables CSRF Protection and sets Default Crumb Issuer in Jenkins Configuration before starting Jenkins service (Jenkins > Configure Global Security > CSRF Protection). It is necessary in order to run seed_job.sh.  
[jenkins/disableScriptApproval.groovy](jenkins/disableScriptApproval.groovy) This script disables required approvals for Job DSL scripts (Jenkins > Configure Global Security > CSRF Protection). It is necessary in order to run our Pipeline job without manual approving.  
[jenkins/securityConfiguration.groovy](jenkins/securityConfiguration.groovy) This script enables security with Jenkins own user database. It is necessary in order to logging in.  
[jenkins/Dockerfile](jenkins/Dockerfile) This Dockerfile describes our Jenkins image.  
[jenkins/plugins.txt](jenkins/plugins.txt) This txt file contains list of required plugins with dependencies for Jenkins. The content of this file is transfered to default script in Jenkins container (/usr/local/bin/install-plugins.sh) in order to pre-install plugins with dependencies before starting Jenkins service. Here is an example to get the list of plugins from an existing server:

```
JENKINS_HOST=username:password@myhost.com:port
curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/'
```
