# Document server
A deployable document server using `nginx`, `sftp` and `Docker`.

## Guide
* Run the docker image
* Copy your html document under `/usr/app/<project name>/html` in the container using `sftp`
  * Login with user `SSH_USR` and passwd `SSH_PWD`, which can be specified when building the docker image
* Your document will be available on url: `localhost/docs/<project name>

## Build and run the docker image
* `docker build -t <image name> ./dockerfile`
* `docker run -it -p <host http port>:80 -p <host ssh port>:22`


