import groovy.json.JsonSlurperClassic

def jsonParse(def json) {
    new groovy.json.JsonSlurperClassic().parseText(json)
}
pipeline {
  agent any
  environment {
    appName = "variable" 
  }
  stages {

 stage("Iniciar con el pipeline y ver en que directorio estamos"){
     
      steps {
          script {			
           sh '''
           echo 'Vamos a iniciar con esto!!'
           pwd
           '''
          }
      }
    }
 stage("Borrar el codigo anterior, clonar el nuevo y construir una nueva imagen"){
      steps {
          dir('magiccardfolder'){
            deleteDir()
          }
          script {
            sh '''
            mkdir magiccardfolder
            cd magiccardfolder
            git clone https://github.com/pfuentes1613/MagicCardsDockerizado.git
            cd MagicCardsDockerizado
            pwd
            ls
            docker rmi magiccardsimage
            docker build -t magiccardsimage .
            docker images
            '''
          }
     }
  }
 stage("Guardar la imagen creada en el repositorio de ECR"){
      steps {
          script {
            sh '''
            aws ecr-public get-login-password --region us-east-2 | docker login --username AWS --password-stdin public.ecr.aws/d9z3m8e7
            docker tag magiccardsimage:latest public.ecr.aws/d9z3m8e7/pablorepos:latest
            docker push public.ecr.aws/d9z3m8e7/pablorepos:latest
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
            aws ecs create-service --cluster fargate-cluster --service-name fargate-service --task-definition ecs-pab:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[	subnet-0c348442d54ff3aba],securityGroups=[sg-01f1ce4c72852bbd3],assignPublicIp=ENABLED}"
            aws ecs list-services --cluster fargate-cluster
            '''
          }
     }
  }
}
 post {
     always {          
          sh "echo 'Esto siempre se reproduce'"
      }
     success {
            sh "echo 'Todo salio con exito'"
        }

     failure {
            sh "echo 'El pipeline fallo'"
      }
      
    }
}  