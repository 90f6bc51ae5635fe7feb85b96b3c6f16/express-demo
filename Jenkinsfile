pipeline {
       agent {
        kubernetes {
            yaml """
            apiVersion: v1
            kind: Pod
            spec:
                containers:
                  - name: nodejs
                    image: node:14.17.6
                    alwaysPullImage: false
                    command:
                    - cat
                    tty: true
                  - name: docker-daemon
                    image: docker:stable-dind
                    alwaysPullImage: false
                    securityContext:
                      privileged: true
                    env:
                    - name: DOCKER_TLS_CERTDIR
                      value: ""
                    volumeMounts:
                    - name: docker-volume
                      mountPath: /var/lib/docker
                      subpath: k8s-example
                  - name: docker
                    image: docker
                    alwaysPullImage: false
                    command:
                    - cat
                    tty: true
                    env:
                    - name: DOCKER_HOST
                      value: tcp://localhost:2375
                  - name: kubecli
                    image: roffe/kubectl:v1.13.2
                    command: ['cat']
                    tty: true
                    resources:
                      requests:
                        cpu: "500m"
                        memory: "256Mi"
                      limits:
                        memory: "3Gi"
                        cpu: "2000m"                  
                volumes:
                    - name: docker-volume
                      emptyDir: {}
            """
        }
    }

    stages {
        stage('build && push-registry'){
            steps{
                script{
                container('docker'){
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
        }
        
    
    stage('deploy'){

     steps {
           
            script {
                withCredentials([file(credentialsId: 'kube-lib', variable: 'KUBECONFIG')
                    ]) {
                        container('kubecli'){
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
}

// pipeline {

//   environment {
//     dockerimagename = "maxky2208/express-demo"
//     dockerImage = ""
//   }

//   agent any

//   stages {


//     stage('Deploying React.js container to Kubernetes') {
//       steps {
//         script {
//           kubernetesDeploy(configs: "deployment.yaml")
//         }
//       }
//     }

//   }

// }