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
        stages {
            stage('Test Docker') {
                steps {
                    sh 'docker ps'
                }
            }
        }
    }
}