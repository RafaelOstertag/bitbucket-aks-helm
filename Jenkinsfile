pipeline {
    agent {
        label 'amd64&&docker'
    }

    options {
        ansiColor('xterm')
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '15')
        timestamps()
        disableConcurrentBuilds()
    }

    triggers {
        pollSCM '@hourly'
        cron '@daily'
    }

    environment {
        IMAGE_VERSION=getVersion()
    }

    stages {
        stage('Build Docker Images') {
            steps {
                sh 'docker build -t rafaelostertag/aks-kubectl:${IMAGE_VERSION} aks-kubectl'
                sh 'docker build --build-arg VERSION=${IMAGE_VERSION} -t rafaelostertag/aks-helm:${IMAGE_VERSION} aks-helm'
            }
        }

        stage('Push Docker Images') {
            when {
                branch 'main'
                not {
                    triggeredBy "TimerTrigger"
                }
            }

            steps {
                withCredentials([usernamePassword(credentialsId: '750504ce-6f4f-4252-9b2b-5814bd561430', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    sh 'docker login --username "$USERNAME" --password "$PASSWORD"'
                    sh 'docker push rafaelostertag/aks-kubectl:${IMAGE_VERSION}'
                    sh 'docker push rafaelostertag/aks-helm:${IMAGE_VERSION}'
                }
            }
        }
    }

    post {
        unsuccessful {
            mail to: "rafi@guengel.ch",
                    subject: "${JOB_NAME} (${BRANCH_NAME};${env.BUILD_DISPLAY_NAME}) -- ${currentBuild.currentResult}",
                    body: "Refer to ${currentBuild.absoluteUrl}"
        }
    }
}

def getVersion() {
    def versionObj = readJSON file: 'version.json'
    return versionObj.version
}
