def deploy() {
  echo "This is your username for DockerHub account : ${params.dockerhub_user}"
  sh "docker run -d -p 5002:80 --name flask_from_jenkins ${params.dockerhub_user}/jenkins:3.1"
}

return this