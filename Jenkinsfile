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
                          npm install
                          """
                  }
            }
        }
  }
}