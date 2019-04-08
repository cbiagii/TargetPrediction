# Target Prediction
This repository contains a docker image with some tools that can be used to predict lncRNAs and miRNAs targets.


## Docker installation
To install docker follow the instructions in the links below depending on your operating system:
- CentOS: https://docs.docker.com/install/linux/docker-ce/centos/
- Debian: https://docs.docker.com/install/linux/docker-ce/debian/
- Fedora: https://docs.docker.com/install/linux/docker-ce/fedora/
- Ubuntu: https://docs.docker.com/install/linux/docker-ce/ubuntu/
- MacOS: https://docs.docker.com/docker-for-mac/install/
- Windows: https://docs.docker.com/docker-for-windows/install/


## Docker pull
Once docker is installed, the next step is pull the [target-prediction](https://hub.docker.com/r/biagii/target-prediction) image from dockerhub using the following command:
```
docker pull biagii/target-prediction
```


## Running image
There are several differents parameters to run the downloaded image. The most commom way is executing the following command:

```
docker run --rm --name [ANY_NAME] -v /server/path/:/docker/path/ biagii/target-prediction bash
```
