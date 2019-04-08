FROM ubuntu:14.04

ENV PATH /opt/conda/bin:$PATH
ENV PATH /root/.local/bin:$PATH


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
cmake


RUN apt-add-repository -y ppa:j-4/vienna-rna && \
apt-get update && \
apt-get install -y viennarna


RUN apt-get install -y curl grep sed dpkg && \
TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
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


RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda2-4.5.12-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN conda config --add channels defaults && \
        conda config --add channels bioconda && \
        conda config --add channels conda-forge && \
	conda update -n base -c defaults conda && \
	conda install -y intarna

#RUN conda install -y viennarna

RUN conda install -y numpy scipy statsmodels configparser

#WORKDIR /opt/
#RUN git clone https://bitbucket.org/compbio/mechrna.git
#WORKDIR /opt/mechrna/data/
#RUN wget https://zenodo.org/record/1115534/files/mechrna.data.grch38.tar.gz && \
#tar -xvzf mechrna.data.grch38.tar.gz && \
#rm -rf mechrna.data.grch38.tar.gz


#Triplexator
WORKDIR /opt/
RUN git clone https://github.com/Gurado/triplexator.git triplexator
WORKDIR /opt/triplexator/
RUN mkdir -p /opt/triplexator/build/Release
WORKDIR /opt/triplexator/build/Release
RUN cmake ../.. -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=g++ -G "Unix Makefiles" && make


#lncpro
ADD lncpro_pre.zip/ /opt/
WORKDIR /opt/
RUN git clone https://github.com/xypan1232/IPMiner.git IPMiner && \
unzip lncpro_pre.zip && \ 
rm -rf lncpro_pre.zip && \ 
mv RNAScore_min lncpro
WORKDIR /opt/lncpro/
RUN make

RUN cp /opt/IPMiner/lncPro/predator /opt/lncpro && \ 
cp /usr/bin/RNAsubopt /opt/lncpro && \ 
rm -rf /opt/IPMiner

ENV PATH /opt/lncpro/:$PATH


#miRanda
ADD miRanda-aug2010.tar.gz/ /opt/
WORKDIR /opt/miRanda-3.3a/
RUN ./configure && \
make install


#RGT
#RUN pip install --upgrade pip
#RUN pip install --user cython numpy scipy
#RUN pip install --user RGT
#WORKDIR /root/rgtdata
#RUN python setupGenomicData.py --hg19
#RUN python setupGenomicData.py --hg38


##RIblast
WORKDIR /opt/
RUN git clone https://github.com/fukunagatsu/RIblast.git
WORKDIR /opt/RIblast/
RUN make
ENV PATH /opt/RIblast:$PATH


#MechRNA
WORKDIR /opt/
RUN git clone https://bitbucket.org/compbio/mechrna.git
WORKDIR /opt/mechrna/data/
RUN wget https://zenodo.org/record/1115534/files/mechrna.data.grch38.tar.gz && \
tar -xvzf mechrna.data.grch38.tar.gz && \
rm -rf mechrna.data.grch38.tar.gz


WORKDIR /
CMD [ "/bin/bash" ]
