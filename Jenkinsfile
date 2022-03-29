pipeline {

    agent any

    stages {



        stage('Checkout code') {

            steps {

            checkout scm

            }

    }



        stage('Build') {

            steps {

                script{

                    sh '''

                        whoami

                       docker --version

                       docker build -t magicardsdockerizadoubuntu .

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