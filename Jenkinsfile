pipeline {
	agent any
     //create dockerhub credential in github with your dockerhub Username and Password/Token
    environment {
      DOCKERHUB_CREDENTIALS=credentials('dockerhub')
    }
	stages {
			stage('Checkout') {
				steps {
					git url: 'https://github.com/adeoyedewale/ClassReview.git'
				}
			}
			stage('Build Backend') {
				steps {
					sh 'cd backend && npm install'
				}
			}
			stage('Build Frontend') {
				steps {
					sh 'cd frontend && npm install && npm run build'
				}
			}
			stage('Dockerize') {
				steps {
					sh "docker build -t eruobodo/classreview-app:${BUILD_NUMBER} ."
				}
			}
		stage('Publish') {
				steps {
					//sh "docker login -u eruobodo -p Fifehanmi@2021"
						sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login --username eruobodo --password-stdin'
					//sh "docker tag eruobodo/classreview-app:$BUILD_NUMBER eruobodo/classreview-app:$BUILD_NUMBER"
					sh "docker push eruobodo/classreview-app:$BUILD_NUMBER"
				}
		}
	}
	post {
		always {
			cleanWs()
			sh 'docker logout'
		}
	}
}
