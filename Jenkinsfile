pipeline {
	agent { label 'slave1' }
	triggers {
    	cron('*/20 * * * *')
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
              	sh '/opt/sonar/bin/sonar-scanner -X -Dsonar.projectKey=ci-mvp -Dsonar.sources=./interview -Dsonar.host.url=http://192.168.56.100:9000 -Dsonar.login=admin -Dsonar.password=admin -Dsonar.language=c++ -Dsonar.cxx.cppcheck.reportPath=report.xml'
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
				sh 'curl -uadmin:AP5wyNtML2ZQvrvGptFZtXtohf8 -T app "http://192.168.56.100:8081/artifactory/generic-local/app"'
    		}
		}
	}
}
