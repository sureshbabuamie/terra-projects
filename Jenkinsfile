pipeline {
    agent {
        node {
        label 'maven'
        }
    }
    environment {
        PATH = '/opt/apache-maven-3.9.6/bin:$PATH'
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

