FROM python:3.11.3-slim

RUN echo "**** install runtime dependencies ****"
RUN apt update
RUN apt install -y \
    ipmitool \
    sshpass

ADD requirements.txt .
RUN python -m pip install -r requirements.txt

WORKDIR /app
ADD . /app
RUN mkdir -p /app/logs

RUN chmod 777 /app/resources/docker-entrypoint.sh

EXPOSE 8080
ENV PYTHONUNBUFFERED True

ENTRYPOINT ["/app/resources/docker-entrypoint.sh"]