pipeline{
    agent {label 'docker'}
    environment{
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    stages{
       stage('Git Checkout Stage'){
            steps{
                git branch: 'master', url: 'https://github.com/fatimatabassum05/java-tomcat-maven-example.git'
            }
         }        
        stage('Build docker Image'){
          steps{
            sh 'docker build -t fatimatabassum/fatima12:IMAGE_TAG .'
          }
        }
        stage('Push To Dockerhub'){
          steps{
            sh 'docker push fatimatabassum/fatima12:IMAGE_TAG'
          }
        }
        stage('Deploy Stage') {
          steps{
                withCredentials([aws(credentialsId: "awsCred", region: "ap-south-1")]) {
                    sh 'aws eks --region ap-south-1 update-kubeconfig --name eks-cluster'
                    sh 'helm upgrade --install tomcat-deploy-project ./helm -n dev'
              }
          } 
        }
    }
}
