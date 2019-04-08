#base image
FROM ubuntu:14.04


#add environment path 
ENV PATH /opt/conda/bin:$PATH
ENV PATH /root/.local/bin:$PATH
ENV PATH /opt/lncpro/:$PATH
ENV PATH /opt/RIblast:$PATH


#install linux libraries
RUN apt-get update && apt-get install -y \
wget \
unzip \
vim \
build-essential \
python-pip \
python3-pip \
g++ \
gcc \
gfortran \
git-core \
python3-dev \
make \
autoconf \
automake \
libboost-all-dev \
pkg-config \
software-properties-common \ 
cmake \ 
curl \ 
grep \ 
sed \ 
dpkg


#Tini
RUN TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
dpkg -i tini.deb && \
rm tini.deb && \
apt-get clean


#LncTar
WORKDIR /opt/
RUN wget http://www.cuilab.cn/lnctarapp/download && \
unzip download && \
rm -rf download && \
export PERL5LIB=/opt/LncTar


#Miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda2-4.5.12-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc


#intarna, viennarna, numpy, scipy, statsmodels and configparser
RUN conda config --add channels defaults && \
        conda config --add channels bioconda && \
        conda config --add channels conda-forge && \
	conda update -n base -c defaults conda && \
	conda install -y intarna
RUN conda install -y viennarna
RUN conda install -y numpy scipy statsmodels configparser


#Triplexator
WORKDIR /opt/
RUN git clone https://github.com/Gurado/triplexator.git triplexator
WORKDIR /opt/triplexator/
RUN mkdir -p /opt/triplexator/build/Release
WORKDIR /opt/triplexator/build/Release
RUN cmake ../.. -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++ -G "Unix Makefiles" && make


#miRanda
ADD miRanda-aug2010.tar.gz/ /opt/
WORKDIR /opt/miRanda-3.3a/
RUN ./configure && \
make install


##RIblast
WORKDIR /opt/
RUN git clone https://github.com/fukunagatsu/RIblast.git
WORKDIR /opt/RIblast/
RUN make


WORKDIR /opt/
CMD [ "/bin/bash" ]