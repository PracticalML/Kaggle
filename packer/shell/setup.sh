#!/bin/bash

set -e

# update OS
sudo apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt-get install -y gcc g++ gfortran build-essential git wget \
    linux-image-generic libopenblas-dev htop

# install anaconda, most dependencies (except keras)
cd $HOME

ANACONDA_INSTALLER=Anaconda2-2.4.1-Linux-x86_64.sh
wget https://repo.continuum.io/archive/$ANACONDA_INSTALLER
bash $ANACONDA_INSTALLER -b -p $HOME/anaconda -f
rm -f $ANACONDA_INSTALLER
CONDA=$HOME/anaconda/bin/conda
$CONDA install -y ipython ipython-notebook pandas numpy scipy matplotlib \
    scikit-learn supervisor cython nltk

# install bleeding edge of theano
PIP=$HOME/anaconda/bin/pip
$PIP install --upgrade --no-deps git+git://github.com/Theano/Theano.git

# other modules
$PIP install beautifulsoup4 ml_metrics xgboost hyperopt
$CONDA install -y seaborn
PYTHON=$HOME/anaconda/bin/python
$PYTHON -c "import nltk; nltk.download('all')"

cat >> $HOME/.bashrc <<EOF
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
EOF

# set theano to default to using GPU
cat >> $HOME/.theanorc <<EOF
[global]
floatX=float32
device=gpu
mode=FAST_RUN

[nvcc]
fastmath=True

[cuda]
root=/usr/local/cuda
EOF

# install keras
$PIP install keras

# install cuda
# TODO this is installing lots of desktup GUI dependencies, is there a faster
# smaller package to install?
CUDA=cuda-repo-ubuntu1404_7.5-18_amd64.deb
sudo wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/$CUDA
sudo dpkg -i $CUDA
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install cuda

# TODO is this a better way of installing cuda?
# http://robotics.usc.edu/~ampereir/wordpress/?p=1247

# we're done, but you need to reboot to enable cuda
