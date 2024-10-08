pipeline{
    agent {
        docker {
            image 'node:18'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
            // Mount Docker for Docker builds
        }
    }
    environment {
        APP_DIR = '/var/www/html'
        DOCKER_IMAGE = 'angular-nginx:latest'
    }

    stages {
        stage("Build Docker Image") {
            steps {
                script {
                   // Build the docker image
                   sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage("Run Docker Container") {
            steps {
                script {
                    // Stop any existing container running the app
                    // Run the Docker container with the built Angular app served by Nginx
                    sh '''
                    docker stop angular-app || true
                    docker rm angular-app || true
                    docker run -d --name angular-app -p 8081:80 $DOCKER_IMAGE
                    '''

                }
            }

        } 
    }

    post {
        success {
            echo 'Deployment completed successfully!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }

    
}