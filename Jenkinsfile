pipeline {
    agent {
        docker {
            image 'node:lts-bullseye-slim' 
            args '-p 3000:3000' 
        }
    }
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
            }
        }
        stage('install') { 
            steps {
                sh 'npm install' 
            }
        }
  }
}