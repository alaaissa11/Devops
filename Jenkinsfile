pipeline {
    agent any
    stages{
        stage('Git Checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/alaaissa11/Devops.git'
            }
        }
        stage('UNIT Testing'){
            steps{
                sh 'mvn test'
            }
        }
        stage('Integration Testing'){
            steps{
                sh 'mvn verify -DskiUnitTests'
            }
        }
         stage('Maven Build'){
            steps{
                sh 'mvn clean install'
            }
        }
         stage('SonarQube analysis'){
            steps{
               script{
                 withSonarQubeEnv(credentialsId: 'sonar-api') {
                 sh 'mvn clean package sonar:sonar'
                }
               }
            }
        }
        stage('Quality Gate status'){
            steps{
                 script{
                waitForQualityGate abortPipeline: false, credentialsId: 'sonar-api'
                }
               }
            }
             stage('upload war file to nexus'){
            steps{
                 script{
               nexusArtifactUploader artifacts: [[artifactId: 'DevOps_Project', classifier: '', file: 'target/DevOps_Project-1.0.jar', type: 'jar']],
                credentialsId: 'nexus-admin', 
                groupId: 'tn.esprit', 
                nexusUrl: '192.168.50.27:8081', 
                nexusVersion: 'nexus3', 
                protocol: 'http', 
                repository: 'ExamenAlaaissa-release', 
                version: '1.0'
                }
               }
            }
        }
    }
