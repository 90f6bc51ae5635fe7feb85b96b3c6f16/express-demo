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
                            docker build -f Dockerfile -t service/express-demo2 .
                            docker login  -u ${libUser} -p ${libSecret}  http://141.98.19.42:5000
                            docker push service/express-demo2
                            """
                        
                    }
                }
            }
        }
        
    }
}