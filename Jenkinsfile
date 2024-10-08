pipeline{
    agent any
    
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
        
        stage("Check and Push Docker Image to Docker Hub") {
            steps {
                script {
                    // Use Jenkins credentials for Docker Hub login
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        // Log in to Docker Hub
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                        
                        // Check if the image already exists on Docker Hub
                        def exists = sh(script: 'curl -s -o /dev/null -w "%{http_code}" https://hub.docker.com/v2/repositories/$DOCKER_USERNAME/angular-nginx/tags/latest', returnStdout: true).trim()

                        if (exists == '200') {
                            echo "Image exists on Docker Hub. Skipping push."
                        } else {
                            echo "Image does not exist. Proceeding to push."
                            
                            // Tag the Docker image
                            sh 'docker tag angular-nginx:latest $DOCKER_USERNAME/angular-nginx:latest'

                            // Push the Docker image to Docker Hub
                            sh 'docker push $DOCKER_USERNAME/angular-nginx:latest'
                        }
                    }
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
                    docker ps
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