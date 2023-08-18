FROM python:2-alpine

# Copy the requirements.txt file from the host into the container
COPY ./requirements.txt /app/requirements.txt

# Set the working directory within the container
WORKDIR /app

RUN apk --update add python py-pip openssl ca-certificates py-openssl wget bash linux-headers
RUN apk --update add --virtual build-dependencies libffi-dev openssl-dev python-dev py-pip build-base \
  && pip install --upgrade pip \
  && pip install --upgrade pipenv\
  && pip install --upgrade -r /app/requirements.txt\
  && apk del build-dependencies

COPY . /app

ENTRYPOINT [ "python" ]

CMD [ "hello.py" ]