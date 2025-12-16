pipeline {
    agent any

    stages {
        stage('Pull Docker Image') {
            steps {
                echo 'Waiting for service to initialize...' 
                sleep time: 120, unit: 'SECONDS'
                script {
                    sh '''docker pull pxttxrxwxn/my-image-09122025:main'''
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    sh '''
        
                    if [ "$(docker ps -aq -f name=^/67026427$)" ]; then
                        echo "Found container 'se67'. Restarting..."
                        docker restart 67026427
                    else
                        echo "Container '67026427' not found."
                        docker run --rm -p 6427:3000 --name 67026427 -d  pxttxrxwxn/my-image-09122025:main
                    fi
                    '''
                }
            }
        }
    }
}