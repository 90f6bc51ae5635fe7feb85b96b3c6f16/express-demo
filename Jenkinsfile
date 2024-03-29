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
                  - name: docker
                    image: docker:latest
                    command:
                    - cat
                    tty: true
                    volumeMounts:
                    - mountPath: /var/run/docker.sock
                      name: docker-sock
                  - name: kubecli
                    image: roffe/kubectl:v1.13.2
                    command: ['cat']
                    tty: true
                    resources:
                      requests:
                        cpu: "100m"
                        memory: "100Mi"
                      limits:
                        memory: "256Mi"
                        cpu: "200m"
                volumes:
                  - name: docker-sock
                    hostPath:
                      path: /var/run/docker.sock
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
                    script {withCredentials([file(credentialsId: 'kube-lib', variable: 'KUBECONFIG')]) 
                    {
                        container('kubecli'){
                        sh """
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
    
//        agent {
           
//         kubernetes {
//              yaml """
//             apiVersion: v1
//             kind: Pod
//             spec:
//                 containers:
//                   - name: nodejs
//                     image: node:14.17.6
//                     alwaysPullImage: false
//                     command:
//                     - cat
//                     tty: true
//                   - name: kubecli
//                     image: roffe/kubectl:v1.13.2
//                     command: ['cat']
//                     tty: true
//                     resources:
//                       requests:
//                         cpu: "100m"
//                         memory: "100Mi"
//                       limits:
//                         memory: "256Mi"
//                         cpu: "200m"
//             """
//         }
//     }
//     tools {
//         dockerTool 'docker-17.09.1-ce'
//     }
//     stages {
//         stage('build && push-registry'){
//             steps{
//                 script{
//                 container('nodejs'){
//                    sh 'node -v'
//                     }
//                 }
//             }
//         }
//         stage('Test Docker') {
//             steps {
//                 sh 'docker --version'
//             }
//         }

//           stage('deploy'){

//      steps {
//             script {withCredentials([file(credentialsId: 'kube-lib', variable: 'KUBECONFIG')]) 
//             {
//                         container('kubecli'){
//                            sh 'kubectl get nodes'
//                 }
//             }
//         }
//     }
// }
//     }
// }