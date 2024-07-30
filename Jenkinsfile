pipeline{
    agent {label 'docker_node_new'}
    environment{
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    stages{
       stage('Git Checkout Stage'){
            steps{
                git branch: 'main', url: 'https://github.com/fatimatabassum05/java-example.git'
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
            withAwsCredentials('awsCred') {
                sh 'aws configure set aws_access_key_id ${awsAccessKey}'
                sh 'aws configure set aws_secret_access_key ${awsSecretKey}'
            withCredentials('kubeconfig'){ 
                sh 'aws eks --region ap-south-1 update-kubeconfig --name eks-cluster'
                sh 'helm install helm helm -n dev'
                }
            }
          } 
        }
    }
}
