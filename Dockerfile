FROM dockerfile/java
MAINTAINER Michael Petychakis <mpetyx@gmail.com>

# Setting up the python environment
RUN apt-get install -y python-pip
RUN apt-get install -y git
RUN apt-get install -y libpq-dev python-dev
RUN git clone https://github.com/LinDA-tools/vocabularyrepo.git
#RUN pip install virtualenv
#RUN virtualenv --no-site-packages venv
#RUN /bin/bash/source venv/bin/activate
RUN pip install -r vocabularyrepo/requirements.txt

# Install ElasticSearch.
# Instructions are copied from https://github.com/dockerfile/elasticsearch/blob/# master/Dockerfile
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.tar.gz && \
  tar xvzf elasticsearch-1.1.1.tar.gz && \
  rm -f elasticsearch-1.1.1.tar.gz && \
  mv /tmp/elasticsearch-1.1.1 /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

EXPOSE 8000
# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
