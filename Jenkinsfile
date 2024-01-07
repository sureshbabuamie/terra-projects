pipeline {
    agent {
        node {
        label 'maven'
        }
    }
    environment {
        PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/opt/apache-maven-3.9.6/bin'
    }
    stages {
        stage('Clone-git-repo') {
            steps {
                git branch: 'main', url: 'https://github.com/sureshbabuamie/tweet-trend-new.git'
            }
        }    
	    stage('build-stage') {
            steps {
	        sh 'mvn clean deploy'
            }

        }
    }
}

