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
                        aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 435053451664.dkr.ecr.us-east-2.amazonaws.com
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

                       docker build -t magicardsdockerizadoubuntu .
                       docker tag magicardsdockerizadoubuntu:latest 435053451664.dkr.ecr.us-east-2.amazonaws.com/pablorepo:latest

                   '''

                }

            }

        }

        // stage('Test') {

        //     steps {

        //         //

        //     }

        // }

        // stage('Deploy') {

        //     steps {

        //         //

        //     }

        // }

    }

}