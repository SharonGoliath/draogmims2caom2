FROM python:3.6-alpine

RUN apk --no-cache add musl-dev gcc make g++ libxml2-dev libxslt-dev

RUN pip install astropy && pip install numpy && \
        pip install spherical-geometry

RUN pip install cadcdata && pip install caom2repo && \
        pip install PyYAML && pip install vos && \
        pip install caom2

RUN pip install pytest && pip install mock && pip install flake8 && \
        pip install funcsigs && pip install xml-compare && \
        pip install pytest-cov && pip install aenum && pip install future

WORKDIR /usr/src/app
RUN git clone https://github.com/opencadc-metadata-curation/caom2tools.git && \
  cd caom2tools && git pull origin master && \
  pip install ./caom2utils && pip install ./caom2pipe && cd ..
  
RUN git clone https://github.com/opencadc-metadata-curation/draogmims2caom2.git && \
  pip install ./draogmims2caom2

RUN apk --no-cache add bash
COPY ./docker-entrypoint.sh ./

ENTRYPOINT ["./docker-entrypoint.sh"]

