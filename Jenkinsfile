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
                    withCredentials([usernamePassword(credentialsId: 'user-docker-hub', passwordVariable: 'libSecret', usernameVariable: 'libUser')
                    ]) {
                        
                            sh """
                            docker build -f Dockerfile -t maxky2208/express-demo .
                            docker login  -u ${libUser} -p ${libSecret} 
                            docker push maxky2208/express-demo
                            """
                    }
                }
            }
        }
        
    
    stage('deploy'){

     steps {
           
            script {
                withCredentials([file(credentialsId: 'kube-lib', variable: 'KUBECONFIG')
                    ]) {

                        sh """
                            export KUBECONFIG=${KUBECONFIG}
                            kubectl -n iot-revel set image deployment/express-demo express-demo=maxky2208/express-demo --record=true
                        
                        """
                        }
                    
                }
            }
        }
    }
}