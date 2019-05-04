## Project description
To start infrastructure just clone this repo and do **docker-compose up** command. You can see our infrastructure by command **docker ps -a**. You will see three containers: Jenkins, Sonar and Nexus and their ports exposed. To get into web-interface of these servers just copy the links below to your web browser:

**Jenkins** 		http://localhost	(user: admin, password: admin)

**Nexus**		htpp://localhost:8081	(user: admin, password: admin123)

**Sonar** 		http://localhost:9000	(user: admin, password: admin)

## Jenkins Server
After you get into web-interface of the Jenkins you will see the one **seed** job. To proceed just execute this seed job. When job will finished you will see one new **pipeline** job.

Pipeline job description. Our pipeline consist from 5 stages:

**1. Git clone project.** Cloning the repository into our work directory.  
**2. Analyzing project.** Analyzing our code with cppcheck utility and saving results to report.xml file.  
**3. Sending report to Sonar**. Sending our report.xml file to Sonar server.  
**4. Compilation build.** Compiling our code into app.  
**5. Publishing artifact to repository".** Publishing our artifact into Nexus repository.  



