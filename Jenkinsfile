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
    }
    stages {
        stage('Test Docker') {
            steps {
                sh 'docker ps'
            }
        }
    }
}