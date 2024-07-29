pipeline {
    agent { label 'master' }
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
        AWS_REGION = 'ap-south-1'  
        ECR_REPO_NAME = 'service-a'  
        ECR_REGISTRY = '654654623396.dkr.ecr.ap-south-1.amazonaws.com' 
        AWS_CREDENTIALS_ID = 'eks-ecr'  
    }
    stages {
        stage('Git Checkout Stage') {
            steps {
                git branch: 'master', url: 'https://github.com/sindhukampli/java-tomcat-maven-example.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${ECR_REGISTRY}/${ECR_REPO_NAME}:${IMAGE_TAG} ."
                }
            }
        }
        stage('Push to ECR') {
            steps {
                script {
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                                         credentialsId: "${AWS_CREDENTIALS_ID}", 
                                         secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        
                        // Log in to Amazon ECR
                        sh """
                            aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}
                        """
                        
                        // Push the Docker image to ECR
                        sh "docker push ${ECR_REGISTRY}/${ECR_REPO_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
        stage('Deploy Stage') {
            steps {
                script {
                    sh 'helm install helm ./helm -n dev'
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
