pipeline {

    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
                
                '''
           }
        }

        stage('Test') {
            steps {
                sh '''
                echo "Testing..."
                sleep 3
                echo "Testing Complete."
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                chmod +x ./setup.sh
                ./setup.sh
                '''
            }
        }
    }
    
    post {
        always {
            sh "docker system prune -f"
        }
    } 
}
