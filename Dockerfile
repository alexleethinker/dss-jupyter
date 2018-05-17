FROM ubuntu:16.04

MAINTAINER Alex Lee (alexleethinker@gmail.com) 
# Fullstack Data Science Studio
# docker run -d -p 8888:8888 -v [host-src]:/opt/notebook ~/jupyter-notebook

ENV LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8 LANG=C.UTF-8

RUN apt update \
        && apt -y upgrade \
	&& apt install -y bzip2 apt-utils wget gcc g++ gfortran \
	&& apt install -y liblapack-dev build-essential swig\
        && echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh \
	&& wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
	&& bash ~/miniconda.sh -b -p /opt/conda \
        && export PATH="/opt/conda/bin:$PATH" \
	&& rm -rf ~/miniconda.sh \
        && apt -y autoremove \
        && apt -y clean \
        && pip --no-cache-dir install --upgrade pip \
        # python env
	&& pip --no-cache-dir install --upgrade cython update_checker tqdm stopit \
        # data analysis basics
	&& pip --no-cache-dir install --upgrade jupyter ipywidgets scipy numpy pandas \
        # database connection
	&& pip --no-cache-dir install --upgrade psycopg2 pymongo redis elasticsearch \
        # data visualization
	&& pip --no-cache-dir install --upgrade plotly matplotlib seaborn Bokeh folium \
        # algorithms
	&& pip --no-cache-dir install --upgrade pymc3 algorithms pygorithm networkx deap \
        # NLP
	&& pip --no-cache-dir install --upgrade nltk gensim textblob \
        # machine learning
	&& pip --no-cache-dir install --upgrade scikit-learn turicreate xgboost scikit-mdr skrebate tpot opencv-python pyspark pysparkling[s3,hdfs,http,streaming] \
        # deep learning
	&& pip --no-cache-dir install --upgrade tensorflow cntk mxnet keras \
        && pip --no-cache-dir install http://h2o-release.s3.amazonaws.com/h2o/rel-wolpert/9/Python/h2o-3.18.0.9-py2.py3-none-any.whl \
        && jupyter nbextension enable --py widgetsnbextension \
	&& mkdir /opt/notebook \
	&& rm -r /root/.cache \
        && rm -rf /var/lib/apt/lists/*

EXPOSE 8888
WORKDIR /opt/notebook
ENV PATH /opt/conda/bin:$PATH
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
