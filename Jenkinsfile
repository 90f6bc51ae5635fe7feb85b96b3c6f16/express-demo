// pipeline {
//         agent {
//         kubernetes {
//             yaml """
//             apiVersion: v1
//             kind: Pod
//             spec:
//                 containers:
//                   - name: kubecli
//                     image: roffe/kubectl:v1.13.2
//                     command: ['cat']
//                     tty: true
//                     resources:
//                       requests:
//                         cpu: "50m"
//                         memory: "128Mi"               
//             """
//         }
//     }
//     tools {
//         nodejs 'nodejs-14.6.0'
//         dockerTool 'docker-17.09.1-ce'
//     }
//     stages {
//         stage('build && push-registry'){
//             steps{

//                 script{
//                     withCredentials([usernamePassword(credentialsId: 'user-docker-hub', passwordVariable: 'libSecret', usernameVariable: 'libUser')
//                     ]) {
                        
//                             sh """
//                             docker build -f Dockerfile -t maxky2208/express-demo .
//                             docker login  -u ${libUser} -p ${libSecret} 
//                             docker push maxky2208/express-demo
//                             """
//                     }
//                 }
//             }
//         }
        
    
//     stage('deploy'){

//      steps {
           
//             script {
//                 withCredentials([file(credentialsId: 'kube-lib', variable: 'KUBECONFIG')
//                     ]) {

//                         sh """
//                             cp \$KUBECONFIG /.kube/config
//                             kubectl -n iot-revel set image deployment/express-demo express-demo=maxky2208/express-demo --record=true
                        
//                         """
//                         }
                    
//                 }
//             }
//         }
//     }
// }

pipeline {

  environment {
    dockerimagename = "maxky2208/express-demo"
    dockerImage = ""
  }

  agent any

  stages {


    stage('Deploying React.js container to Kubernetes') {
      steps {
        script {
          kubernetesDeploy(configs: "deployment.yaml")
        }
      }
    }

  }

}