pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                echo 'Hello World'
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
  }
}