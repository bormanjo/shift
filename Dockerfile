# Set the base image using anaconda3
FROM continuumio/anaconda3:5.2.0

# shift-python maintainer
MAINTAINER Han Zheng (zhenghanecho@gmail.com)

# Update all conda packages
RUN conda update --all -y

# Install extra packages for the algorithmic trading competition
# RUN conda install joblib && \
#     conda install tensorflow==1.9.0

# Install shift-python
RUN conda install libpq
RUN wget -qO- https://github.com/hanlonlab/shift-python/releases/download/1.0.1/shift-python_1.0.1_conda_linux64.zip | bsdtar -xvf- && \
    cd shift* && \
    conda install *.tar.bz2

# Clean conda packages cache
RUN conda clean --all -y

RUN apt-get install pandoc -y
RUN apt-get install texlive-xetex -y

# Set working directory 
WORKDIR /home/notebooks

# Run shell command for notebook on start 
CMD jupyter notebook --port=8888 --no-browser --ip=0.0.0.0 --allow-root
