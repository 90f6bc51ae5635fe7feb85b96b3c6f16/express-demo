pipeline {
    agent any
    tools {
        docker 'docker-17.09.1-ce'
    }
    stages {

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