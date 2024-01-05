pipeline {
    agent {
        node {
        label 'maven'
        }
    }

    stages {
        stage('Clone-git-repo') {
            steps {
                git branch: 'main', url: 'https://github.com/sureshbabuamie/tweet-trend-new.git'
            }
	stage('build-stage') {
            steps {
	        sh 'mvn clean deploy'
            }

        }
    }
}

