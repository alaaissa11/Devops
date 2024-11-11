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
                 withSonarQubeEnv(credentialsId: 'wael-api') {
                 sh 'mvn clean package sonar:sonar'
                }
               }
            }
        }
        
        stage('Quality Gate status'){
            steps{
                 script{
                waitForQualityGate abortPipeline: false, credentialsId: 'wael-api'
                }
               }
            }
        stage('upload jar file to nexus'){
            steps{
                 script{
             nexusArtifactUploader artifacts: [[artifactId: 'Foyer', classifier: '', file: '', type: 'jar']],
              credentialsId: 'bloc-auth',
               groupId: 'tn.esprit.spring', 
               nexusUrl: '192.168.43.217:8081',
                nexusVersion: 'nexus3', 
                protocol: 'http', 
                repository: 'blocwael-release', 
                version: '0.0.1'
                }
               }
            }
        }
    }


foyerbloc-api
pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/wael-waer/5sleam2-G4-devops.git'
            }
        }
        stage('UNIT Testing') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Integration Testing') {
            steps {
                sh 'mvn verify -DskiUnitTests'
            }
        }
        stage('Maven Build') {
            steps {
                sh 'mvn clean install'
            }
        }
         
        
        stage('SonarQube analysis') {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'foyerbloc-api') {
                        sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }
        
        stage('Quality Gate status'){
            steps{
                script{
                waitForQualityGate abortPipeline: false, credentialsId: 'foyerbloc-api'
                }
            }
        }
       
       

        
    }
}

  stage('upload jar file to nexus'){
            steps{
                 script{
                 nexusArtifactUploader artifacts: [[artifactId: 'Foyer', classifier: '', file: 'target/Foyer-0.0.1.jar', type: 'jar']],
                 credentialsId: 'bloc-auth',
                 groupId: 'tn.esprit.spring', 
                 nexusUrl: '192.168.1.130:8081',
                 nexusVersion: 'nexus3', 
                 protocol: 'http', 
                 repository: 'maven-snapshots', 
                 version: '0.0.1'
                }
            }
        }
        squ_3d5a29655b3eabfe22542cb5ca56de03986ebd77