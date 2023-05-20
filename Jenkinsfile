def qualityGateValidation(qg) {
  if (qg.status != 'SUCCESS') {
    return true
  }
  return false
}

pipeline {
  agent any

  tools {
      nodejs 'nodejs'
  }

  environment {
      SONAR_URL='http://20.228.242.97:9000/'
      PROJECT_ROOT = '/scrips'
      PROJECT_NAME = 'IcesiHealth-Front'
      registry = 'alejova2023/icesi-health-front'
      registryCredential = 'd2817c01-6695-4a68-8be2-0497d8517568'
      resourceGroup = 'icesihealth-resource-group'
  }

  stages {
       stage('Buid'){
            steps {
                checkout scmGit(
                branches: [[name: 'main']],
                userRemoteConfigs: [[url: 'https://github.com/ValeArias07/icesiHealthApp-frontend']])
            }
        }

      stage('Install dependencies') {
        steps {
          sh 'npm --version'
          sh "npm install"
        }
      }
      

      stage('Generate coverage report') {
        steps {
          sh " npm run coverage"
        }
      }

      stage('scan') {
          environment {
            // Previously defined in the Jenkins "Global Tool Configuration"
            scannerHome = tool 'sonarqube-scanner'
          }
          steps {
            // "sonarqube" is the server configured in "Configure System"
            withSonarQubeEnv('sonarqube') {
              // Execute the SonarQube scanner with desired flags
              sh "${scannerHome}/bin/sonar-scanner \
                          -Dsonar.projectKey=${PROJECT_NAME}:Test \
                          -Dsonar.projectName=IcesiHealth-Front \
                          -Dsonar.projectVersion=0.0.${BUILD_NUMBER} \
                          -Dsonar.host.url=${SONAR_URL} \
                            -Dsonar.sources=./app.js,./public,./backendApi.js \
                          -Dsonar.login=admin \
                          -Dsonar.password=admin \
                          -Dsonar.tests=./test \
                          -Dsonar.javascript.lcov.reportPaths=./coverage/lcov.info"
            }
            
            abortPipeline: qualityGateValidation(waitForQualityGate())
          }
      }

      stage('Build docker-image') {
          steps {
              script{
              dockerImage = docker.build registry + ":0.0.$BUILD_NUMBER"
              }
            }
        }
        
        stage('Deploy docker-image') {
              steps {
                script{
                 docker.withRegistry('', registryCredential ) {
                 dockerImage.push()
                }
              }
            }
        }
        
        stage('Update Azure Container') {
          steps {
            sh "az containerapp update --resource-group $resourceGroup --name icesihealth-front-app  --image $registry:0.0.$BUILD_NUMBER"
            }
        }
    }
}
