import groovy.json.JsonSlurperClassic



def jsonParse(def json) {

    new groovy.json.JsonSlurperClassic().parseText(json)

}
pipeline {

    agent any

    stages {



        stage('Checkout code') {

            steps {

            checkout scm

            }

    }

        stage('Connection to aws') {

            steps {

                script{

                    sh '''
                        aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/d9z3m8e7
                   '''

                }

            }

        }


        stage('Build') {

            steps {

                script{

                    sh '''

                        whoami

                       docker --version
                       docker rmi magicardsdockerizadoubuntu
                       docker build -t magicardsdockerizadoubuntu .
                       docker tag magicardsdockerizadoubuntu:latest public.ecr.aws/d9z3m8e7/pablorepo:latest
                       docker push public.ecr.aws/d9z3m8e7/pablorepo:latest

                   '''

                }

            }

        }

        stage("Crear cluster en ECS"){ 

         steps {

          script {

            sh '''

            aws ecs create-cluster --cluster-name fargate-cluster

            aws ecs register-task-definition --cli-input-json file://fargate-task.json

            aws ecs list-task-definitions

            aws ecs create-service --cluster fargate-cluster --service-name fargate-service --task-definition fargate-app:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[ subnet-02788912cab17b0ab],securityGroups=[sg-0b04d4c180e08a75f],assignPublicIp=ENABLED}"

            aws ecs list-services --cluster fargate-cluster

            '''

          }
         
         }

        }

    }

}