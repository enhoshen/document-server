# Document server
A deployable document server using `nginx`, `sftp` and `Docker`.

## Build and run the docker image
* `docker build -t <image name> ./dockerfile`
* `docker run -it -p <host http port>:80 -p <host ssh port>:22`
