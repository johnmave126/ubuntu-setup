FROM python:latest

RUN RUN apt-get update && apt-get install -y --no-install-recommends libgeoip-dev
RUN pip install --no-cache-dir stig setproctitle geoip maxminddb

CMD ["python"]