pipeline {
    agent any
    tools {
        nodejs 'nodejs-14.6.0',
        nodejs 'docker',
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
         stage('iot build && push-registry'){

            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: 'gameon-lib', passwordVariable: 'libSecret', usernameVariable: 'libUser')]) {
                        sh """
                        echo $TAG_NAME
                        docker build -f "Docker/Dockerfile" --build-arg NODE_ENV="iot" -t registry.matador.ais.co.th/${namespace}/iot/be/${Appname}:$TAG_NAME .
                        docker login  -u ${libUser} -p '${libSecret}' registry.matador.ais.co.th
                        docker push registry.matador.ais.co.th/${namespace}/iot/be/${Appname}:$TAG_NAME
                        """
                    }
                }
            }
        }
        
    }
}