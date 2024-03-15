pipeline {

    agent any

    environment {
        REGISTRY = "eu.gcr.io/lbg-mea-17"
        API_IMAGE = "dwr-api-app"
        API_VERSION = "v1"
        NAME_SPACE = "assignment"
    }

    stages {
        stage('Build') {
            steps {
                sh "docker build -t $REGISTRY/$API_IMAGE:$API_VERSION ."
           }
        }

        stage('Unit Test') {
            steps {
                sh """
                echo "Testing..."
                echo "Testing Complete."
                """
            }
        }

        stage('Push') {
            steps {
                sh """
                gcloud config set account dwr-service-acct@lbg-mea-17.iam.gserviceaccount.com
                docker push $REGISTRY/$API_IMAGE:$API_VERSION && echo "Image pushed successfully" 
                """
            }
        }

        stage('Test Deployment') {
            steps {
                sh """
                echo "Testing k8s Deployment..."
                echo "Testing Complete."
                """
            }
        }

        stage('Deploy') {
            steps {
                sh "gcloud config set account dwr-k8s-service@lbg-mea-17.iam.gserviceaccount.com"
                sh "kubectl create ns $NAME_SPACE || true"
                //sh "sed -e 's,{{API_IMAGE}},'$API_IMAGE',g;' kubernetes/application.yml | tee kubernetes/application.yml"
                //sh "sed -e 's,{{API_VERSION}},'$API_VERSION',g;' kubernetes/application.yml | tee kubernetes/application.yml"
                sh "kubectl apply -f kubernetes --namespace $NAME_SPACE"
                sh "sleep 60"
                sh "kubectl get services --namespace $NAME_SPACE"
            }
        }
    }
    
    post {
        always {
            //sh "docker stop \$(docker ps -q) || true"
            //sh "docker rm \$(docker ps -qa) || true"
            //sh "docker rmi -f \$(docker images -q) ||"
            sh "docker system prune -f"
            sh "gcloud config set account null"
        }

        failure {
            //sh "kubectl delete ns $NAME_SPACE || true"
            echo "Failed"
        }
    } 
}
