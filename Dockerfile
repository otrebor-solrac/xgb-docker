FROM ubuntu:16.04

RUN apt-get -y update 
RUN apt-get install -y --no-install-recommends \
         wget \
         python3.5\
	 libgcc-5-dev \
	 nginx \
         ca-certificates \
         && rm -rf /var/lib/apt/lists/*

RUN wget https://bootstrap.pypa.io/3.3/get-pip.py && python3.5 get-pip.py 
RUN pip3 install numpy
RUN pip3 install flask gevent gunicorn
RUN pip3 install pandas
RUN pip3 install scipy 
#RUN pip3 install --upgrade pip
RUN pip3 install xgboost==0.72.1 
RUN pip3 install -U scikit-learn

RUN (cd /usr/local/lib/python3.5/dist-packages/scipy/.libs; rm *; ln ../../numpy/.libs/* .)
RUN rm -rf /root/.cache

#ENV PYTHONUNBUFFERED=TRUE
#ENV PYTHONDONTWRITEBYTECODE=TRUE
#ENV PATH="/opt/program:${PATH}"

# Set up the program in the image
COPY xgboost /opt/program
WORKDIR /opt/program

ENTRYPOINT ["python3.5"]
