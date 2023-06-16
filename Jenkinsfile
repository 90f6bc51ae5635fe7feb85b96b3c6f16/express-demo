pipeline {
    agent any
    tools {
        nodejs 'nodejs-14.6.0'
        dockerTool 'docker-17.09.1-ce'
    }
    stages {
        stage('build && push-registry'){
            steps{

                script{
                    withCredentials([usernamePassword(credentialsId: 'user-docker', passwordVariable: 'libSecret', usernameVariable: 'libUser')]) {
                        
                            sh """
                            docker build -f Dockerfile -t 141.98.19.42:5000/service/express-demo .
                            docker login  -u ${libUser} -p ${libSecret}  http://141.98.19.42:5000
                            docker push 141.98.19.42:5000/service/express-demo
                            """
                        
                    }
                }
            }
        }
        
    }
}