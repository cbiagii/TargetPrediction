# Target Prediction
This repository contains a docker image with some tools that can be used to predict lncRNAs and miRNAs targets.


## Softwares available
In this image we have some predictors installed:
- [LncTar](http://www.cuilab.cn/lnctar): lncRNA - RNA;
- [miRanda](http://cbio.mskcc.org/microrna_data/manual.html): miRNA - RNA;
- [RIblast](https://github.com/fukunagatsu/RIblast): lncRNA - RNA;
- [Triplexator](http://bioinformatics.org.au/tools/triplexator/manual.html): lncRNA - DNA.


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

An alternative way to run some software in the image in a single command:
```
docker run --rm --name [ANY_NAME] -v /server/path/:/docker/path/ biagii/target-prediction RIblast db -i /path/to/file.fasta -o /path/to/db_name

docker run --rm --name [ANY_NAME] -v /server/path/:/docker/path/ biagii/target-prediction /bin/bash -c 'cd /opt/LncTar/; perl LncTar.pl -p 1 -l/path/to/lncrna.fasta -m /path/to/targets.fasta -s F -o /path/to/output.txt'"
```


## Help
Any questions contact the developer by email: biagi@usp.br
