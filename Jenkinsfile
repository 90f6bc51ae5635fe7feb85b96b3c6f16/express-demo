pipeline {
    agent any
    tools {
        nodejs 'nodejs-14.6.0'
    }
    stages {
        stage('Test node') {
            steps {
                sh 'node --version'
            }
        }
        stage('install'){
            steps{
                sh 'npm install --verbose'
            }
        }
        
        stage('Test Docker') {
            steps {
                sh 'docker ps'
            }
        }
        stage('build && push-registry'){
            steps{
                sh 'docker build -f "Dockerfile" -t http://141.98.19.42:5000/service/express-demo .'
                sh 'docker login  -u root -p Qwerty1@#$ http://141.98.19.42:5000'
                sh 'docker push http://141.98.19.42:5000/service/express-demo'
            }

        }
        
    }
}