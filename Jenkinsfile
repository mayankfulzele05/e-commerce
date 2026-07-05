pipeline {
    agent any

    stages {
        stage('Deploy to kubernetes') {
            steps {
                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: 'cluster', contextName: '', credentialsId: 'token', namespace: 'webapps', serverUrl: 'https://531ABF21953F44BE56885DC74DA1E09D.gr7.ap-south-1.eks.amazonaws.com']]) {
                    sh "kubectl apply -f deployment-service.yml"
                    sleep 60
                }
            }
        }
        
        stage('Verify deployment') {
            steps {
                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: 'cluster', contextName: '', credentialsId: 'token', namespace: 'webapps', serverUrl: 'https://531ABF21953F44BE56885DC74DA1E09D.gr7.ap-south-1.eks.amazonaws.com']]) {
                    sh "kubectl get all -n webapps"
                }
            }
        }
    }
}
