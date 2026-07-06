pipeline {
    agent any

    stages {
        stage('Deploy to Kubernetes') {
            steps {
                withKubeCredentials(kubectlCredentials: [[
                    caCertificate: '', 
                    clusterName: 'cluster', 
                    contextName: '', 
                    credentialsId: 'token', 
                    namespace: 'webapps', 
                    serverUrl: 'https://1B5413203D42D9CB4ECBC61DA79AECF1.gr7.ap-south-1.eks.amazonaws.com'
                ]]) {
                    sh "kubectl apply -f deployment-service.yml"
                }
            }
        }
    
        stage('Verify Deployment') {
            steps {
                withKubeCredentials(kubectlCredentials: [[
                    caCertificate: '', 
                    clusterName: 'cluster', 
                    contextName: '', 
                    credentialsId: 'token', 
                    namespace: 'webapps', 
                    serverUrl: 'https://1B5413203D42D9CB4ECBC61DA79AECF1.gr7.ap-south-1.eks.amazonaws.com'
                ]]) {
                    sh "kubectl get svc -n webapps"
                }
            }
        }
    }
}
