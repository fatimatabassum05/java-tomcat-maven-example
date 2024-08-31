pipeline{
    agent none
    environment{
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    stages{
       stage('Git Checkout Stage'){
            agent {label 'docker'}
            steps{
                git branch: 'main', url: 'https://github.com/fatimatabassum05/java-example.git'
            }
         }        
        stage('Build docker Image'){
          agent {label 'docker'}
          steps{
            sh 'docker build -t fatimatabassum/fatima12:IMAGE_TAG .'
          }
        }
        stage('Push To Dockerhub'){
          agent {label 'docker'}
          steps{
            sh 'docker push fatimatabassum/fatima12:IMAGE_TAG'
          }
        }
        stage('Deploy Stage') {
          agent {label 'k8s_node'}
          steps{
            sh 'helm install helm1 helm1 -n prod'
          } 
        }
    }
}
