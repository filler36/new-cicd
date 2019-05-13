pipeline {
    agent { label 'slave1' }
    triggers {
    	cron('H/20 * * * *')
    }
    stages {

        stage("1. GIT CLONE PROJECT") {
            steps {
                sh 'git clone https://github.com/filler36/interview'
            }
        }

	stage("2. ANALYZING PROJECT") {
	    steps {
		sh 'cppcheck --xml-version=2 --enable=all interview/main.cpp 2> report.xml'
	    }
	}

	stage("3. SENDING REPORT TO SONAR") {
	    steps {
		sh '''route -n | awk '/UG[ \t]/{print $2}' >> /etc/hosts'''
		sh '''sed '${s/$/ dockerhost/}' /etc/hosts'''
              	sh '''/opt/sonar/bin/sonar-scanner -X -Dsonar.projectKey=ci-mvp -Dsonar.sources=./interview -Dsonar.host.url=http://$dockerhost:9000 -Dsonar.login=admin -Dsonar.password=admin -Dsonar.language=c++ -Dsonar.cxx.cppcheck.reportPath=report.xml'''
	    }
	}

	stage("4. COMPILATION BUILD") {
	    steps {
	        sh 'g++ interview/main.cpp -o app'
		sh 'ls -lah'
	    }
	}

	stage("5. PUBLISHING ARTIFACT TO REPOSITORY") {
	    steps {
	        sh 'curl -uadmin:password -T app "http://$dockerhost:8081/artifactory/example-repo-local/app${BUILD_NUMBER}"'
    	    }
	}
    }
}
