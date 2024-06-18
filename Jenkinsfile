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
         stage('Static code analysis'){
            steps{
               scripts{
                 withSonarQubeEnv(credentialsId: 'sonar-api') {
                 sh 'mvn clean package sonar:sonar'
                }
               }
            }
        }
    }
}