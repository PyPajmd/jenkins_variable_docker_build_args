// git config --global alias.add-commit '!git add -A && git commit'
node {
def JENKINS_ID = """${sh(
            returnStdout: true,
            script: 'printf "$(id -u jenkins)"'
        )}"""
}
        
pipeline {
    environment {
        // Using returnStdout
        JENKINS_UID = """${sh(
                returnStdout: true,
                script: 'printf "$(id -u jenkins)"'
            )}""" 
        JENKINS_GID = """${sh(
                returnStdout: true,
                script: 'printf "$(id -g jenkins)"'
            )}""" 
        DOCKER_GID = """${sh(
                returnStdout: true,
                script: 'printf "$(getent group docker | cut -d: -f3)"'
            )}""" 
    }
//    agent any

    // def STUFF = "stuffy"
    // agent {
    //     dockerfile {
    //         filename 'Dockerfile'
    //         additionalBuildArgs "--build-arg uid=$env.JENKINS_UID --build-arg gid=${env.JENKINS_GID} --build-arg docker_gid=${env.DOCKER_GID}" 
    //         args ' -u jenkins \
    //         -e "HOME=/var/lib/jenkins/workspace" \
    //         -v /var/run/docker.sock:/var/run/docker.sock \
    //         -v /var/lib/jenkins/workspace:/var/lib/jenkins/workspace \
    //         -p 3000:3000 -p 5000:5000' 
    //     }    
    // }

    stages {

    def STUFF = "stuffy"
    agent {
        dockerfile {
            filename 'Dockerfile'
            additionalBuildArgs "--build-arg uid=$env.JENKINS_UID --build-arg gid=${env.JENKINS_GID} --build-arg docker_gid=${env.DOCKER_GID}" 
            args ' -u jenkins \
            -e "HOME=/var/lib/jenkins/workspace" \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -v /var/lib/jenkins/workspace:/var/lib/jenkins/workspace \
            -p 3000:3000 -p 5000:5000' 
        }    
    }
        stage (test) {
            steps {
                script {
                    // some_var = sh(returnStdout: true, script: 'printf "XXXX$(id jenkins)YYYY"')
                    zip_file = sh(returnStdout: true, script: 'printf "nhs-ui-$param_tag.zip"')
                }
                // sh 'echo "Does not work some var =  ${some_var}"'
                // echo "OK some var=${some_var}"
                
                sh 'echo OK Jenkins ID  = $JENKINS_UID'
                sh 'echo OK JENKINS_GID = $JENKINS_GID'
                sh 'echo OK DOCKER_GID  = $DOCKER_GID'
                
                sh 'echo "NOT OK Zipping dist: ${zip_file}"'
                sh "echo OK Zipping dist: ${zip_file}"
                echo "OK Zip File Name: ${zip_file}"
            }
        }
    }
}

