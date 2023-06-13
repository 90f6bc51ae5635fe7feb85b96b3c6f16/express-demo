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
   stage('set-env') {
      steps {
          setenv()
      }
    }
   stage('install'){
       steps{
            container('nodejs'){
                sh """
                    npm config set sass_binary_site https://lib.matador.ais.co.th/repository/node-sass/
                    npm config set registry https://lib.matador.ais.co.th/repository/npm/
                    npm install --verbose
                    """
            }
       }
   }
    stage('iot build && push-registry'){
        when { tag "iot-*" }
        steps{
            script{
                container('docker'){
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
    stage('iot2 build && push-registry'){
        when { tag "iot2-*" }
        steps{
            script{
                container('docker'){
                  withCredentials([usernamePassword(credentialsId: 'gameon-lib', passwordVariable: 'libSecret', usernameVariable: 'libUser')]) {
                    sh """
                      echo $TAG_NAME
                      docker build -f "Docker/Dockerfile" --build-arg NODE_ENV="iot2" -t registry.matador.ais.co.th/${namespace}/iot2/be/${Appname}:$TAG_NAME .
                      docker login  -u ${libUser} -p '${libSecret}' registry.matador.ais.co.th
                      docker push registry.matador.ais.co.th/${namespace}/iot2/be/${Appname}:$TAG_NAME
                    """
                  }
               }
            }
       }
    }
    stage('staging build && push-registry '){
        when { tag "staging-*" }
        steps{
            script{
                container('docker'){
                  withCredentials([usernamePassword(credentialsId: 'gameon-lib', passwordVariable: 'libSecret', usernameVariable: 'libUser')]) {
                    sh """
                      echo $TAG_NAME
                      docker build -f "Docker/Dockerfile" --build-arg NODE_ENV="staging" -t registry.matador.ais.co.th/${namespace}/staging/be/${Appname}:$TAG_NAME .
                      docker login  -u ${libUser} -p '${libSecret}' registry.matador.ais.co.th
                      docker push registry.matador.ais.co.th/${namespace}/staging/be/${Appname}:$TAG_NAME
                    """
                  }
               }
            }
       }
    }
    stage('prod build && push-registry '){
        when { tag "prod-*" }
        steps {
          container('docker') {
            withCredentials([usernamePassword(credentialsId: 'repo1-admin', passwordVariable: 'passdocker', usernameVariable: 'userdocker')]) {
              sh """
                docker build -f "Docker/Dockerfile" --build-arg NODE_ENV="production" -t dockerhub1.matador.ais.co.th/${namespace}/production/be/${Appname}:$TAG_NAME .
                docker login  -u ${userdocker} -p '${passdocker}' dockerhub1.matador.ais.co.th
                docker push dockerhub1.matador.ais.co.th/${namespace}/production/be/${Appname}:$TAG_NAME
              """
            }
          }
        }
    }
    stage('iot config'){
     when {tag "iot-*"}
     steps {
            script {
                withCredentials([file(credentialsId: 'kube-user', variable: 'KUBECONFIG')]) {
                    container('kubecli'){
                        sh """
                              export KUBECONFIG=${KUBECONFIG}
                              kubectl -n iot-gameon replace -f gameon-webapplication-cm.yaml
                              kubectl -n iot-gameon scale deployments ${Deployname} --replicas=0
                              kubectl -n iot-gameon scale deployments ${Deployname} --replicas=1
                              kubectl get cm -n iot-gameon 
                        """
                    }
                }                         
            }
        }
    }
    stage('iot2 config'){
     when {tag "iot2-*"}
     steps {
            script {
                withCredentials([file(credentialsId: 'kube-user', variable: 'KUBECONFIG')]) {
                    container('kubecli'){
                        sh """
                              export KUBECONFIG=${KUBECONFIG}
                              kubectl -n iot2-gameon replace -f gameon-webapplication-cm-iot2.yaml
                              kubectl -n iot2-gameon scale deployments ${Deployname} --replicas=0
                              kubectl -n iot2-gameon scale deployments ${Deployname} --replicas=1
                              kubectl get cm -n iot2-gameon 
                        """
                    }
                }                         
            }
        }
    }
    stage('staging config'){
     when {tag "staging-*"}
     steps {
            script {
                withCredentials([file(credentialsId: 'kube-user', variable: 'KUBECONFIG')]) {
                    container('kubecli'){
                        sh """
                              export KUBECONFIG=${KUBECONFIG}
                              kubectl -n staging-gameon replace -f gameon-webapplication-cm-staging.yaml
                              kubectl -n staging-gameon scale deployments ${Deployname} --replicas=0
                              kubectl -n staging-gameon scale deployments ${Deployname} --replicas=1
                              kubectl get cm -n staging-gameon 
                        """
                    }
                }                         
            }
        }
    }
    stage('iot deploy'){
     when {tag "iot-*"}
     steps {
           
            script {
                withCredentials([file(credentialsId: 'kube-user', variable: 'KUBECONFIG')]) {
                    container('kubecli'){
                        sh """
                              export KUBECONFIG=${KUBECONFIG}
                              kubectl -n iot-gameon set image deployment/${Deployname} ${Deployname}=registry.matador.ais.co.th/gameon/iot/be/${Appname}:$TAG_NAME --record=true;\
                              kubectl -n iot-gameon get pods |grep ${Deployname}
                              kubectl get deployment -n iot-gameon
                        """
                    }
                }                         
            }
        }
    }
    stage('iot2 deploy'){
     when {tag "iot2-*"}
     steps {
           
            script {
                withCredentials([file(credentialsId: 'kube-user', variable: 'KUBECONFIG')]) {
                    container('kubecli'){
                        sh """
                              export KUBECONFIG=${KUBECONFIG}
                              kubectl -n iot2-gameon set image deployment/${Deployname} ${Deployname}=registry.matador.ais.co.th/gameon/iot2/be/${Appname}:$TAG_NAME --record=true;\
                              kubectl -n iot2-gameon get pods |grep ${Deployname}
                              kubectl get deployment -n iot2-gameon
                        """
                    }
                }                         
            }
        }
    }
    stage('staging deploy'){
     when {tag "staging-*"}
     steps {
           
            script {
                withCredentials([file(credentialsId: 'kube-user', variable: 'KUBECONFIG')]) {
                    container('kubecli'){
                        sh """
                              export KUBECONFIG=${KUBECONFIG}
                              kubectl -n staging-gameon set image deployment/${Deployname} ${Deployname}=registry.matador.ais.co.th/gameon/staging/be/${Appname}:$TAG_NAME --record=true;\
                              kubectl -n staging-gameon get pods |grep ${Deployname}
                              kubectl get deployment -n staging-gameon
                        """
                    }
                }                         
            }
        }
    }
     stage('Send-Email') {  
        when {
          tag 'prod-*'
        }
        steps {
            script {
              setenv()
              CREATE_MAIL_TEMPLATE ('email-temp.html')
              sh 'ls -l'
            }
        }
    }
  }
}

def setenv(){
                      def envapp = readYaml file: "env-app.yaml"
                      def properties = readYaml file: "properties.yaml"
                      namespace = "gameon"
                      Namespace = envapp.App.Namespace
                      NamespaceKube = envapp.App.NamespaceIot
                      Zone = envapp.App.Zone
                      Deployname = envapp.App.Deployname
                      Group   = properties.App.Group
                      Appname = properties.App.AppName
                      Mail_Subject = properties.Email.Subject
                      Mail_Purpose = properties.Email.Description.Purpose
                      Mail_Detial  = properties.Email.Description.Detial          
}

def CREATE_MAIL_TEMPLATE (def filePath){
    if( !fileExists("${filePath}") ){
        println "FILE=${filePath} IS NOT FOUND"
        return
    }
    def e = [ "MAIL_SUBJECT=${Mail_Subject}",
              "MAIL_PURPOSE=${Mail_Purpose}",
              "MAIL_DETIAL=${Mail_Detial}",
              "MAIL_APP_GROUP=${Group}",
              "MAIL_APP_NAME=${Appname}",
              "MAIL_APP_VERSION=$TAG_NAME",
            ]
    println (e);
    withEnv(e) {
        sh "bash ${filePath} > ${Appname}.html"
    }
}
