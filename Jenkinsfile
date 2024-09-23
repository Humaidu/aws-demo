pipeline{
    agent any

    environment {
        APP_DIR = '/var/www/html'
    }

    stages {
        stage("Setup Permissions") {
            steps {
                sh '''
                sudo chown -R jenkins:jenkins $APP_DIR
                sudo chmod -R 755 $APP_DIR
                '''
            }
        }

        stage("Install Dependencies") {
            steps {
                // Install necessary dependencies like Node.js and npm on the EC2 instance if not already installed
                sh 'npm install'
            }
        }

        stage("Build Angular App") {
            steps {
                // Build the Angular App using npm
                sh 'npm run build'
            }

        }

        stage("Deploy Angular App to Nginx") {
            steps {
                // Cleaning existing build and moving new files to the Nginx web directory
                sh '''
                    rm -rf $APP_DIR/*
                    cp -r dist/aws_demo_angular/* $APP_DIR/
                '''
            }
        }

        stage("Restart Nginx Server") {
            steps {
                // Restarting nginx server
                sh 'sudo systemctl restart nginx'
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