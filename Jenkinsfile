 pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/alaaissa11/Devops.git'
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
        stage('Nexus Deploy') {
            steps {
                script {
                      nexusArtifactUploader artifacts:
                        [
                        [artifactId: 'DevOps_Project',
                        classifier: '', 
                        file: 'target/DevOps_Project-0.0.1-SNAPSHOT.jar',
                         type: 'jar']
                        ],
                        credentialsId: 'bloc-auth',
                        groupId: 'tn.esprit',
                        nexusUrl: '192.168.1.130:8081', 
                        nexusVersion: 'nexus3',
                        protocol: 'http', 
                        repository: 'maven-snapshots', 
                        version: '0.0.1-SNAPSHOT'

                }
            }
        }
        stage('Docker Image Build') {
            steps {
                script {
                    // Convertir le nom de JOB_NAME en minuscules pour respecter les règles Docker
                    def imageName = "$JOB_NAME".toLowerCase()

                    // Construire l'image Docker avec un nom conforme à Docker
                    sh "docker image build -t ${imageName}:v1.${BUILD_ID} ."
                    sh "docker image tag ${imageName}:v1.${BUILD_ID} alaaissa469/${imageName}:v1.${BUILD_ID}"
                    sh "docker image tag ${imageName}:v1.${BUILD_ID} alaaissa469/${imageName}:latest"
                }
            }
        }
        stage('Push image dockerhub') {
           steps {
                script {
                  withCredentials([string(credentialsId: 'git_creds', variable: 'docker_hub_cred')]) {
                    // Convertir le nom de JOB_NAME en minuscules
                    def imageName = JOB_NAME.toLowerCase()
                    
                    // Connexion à Docker Hub
                    sh 'echo "${docker_hub_cred}" | docker login -u alaaissa469 --password-stdin'
                    
                    // Pousser les images vers Docker Hub
                    sh "docker image push alaaissa469/${imageName}:v1.${BUILD_ID}"
                    sh "docker image push alaaissa469/${imageName}:latest"
                     }
                }
            }
        }





    }
}

