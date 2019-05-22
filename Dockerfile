FROM python:3.7 as base

FROM base as builder

RUN mkdir /install
WORKDIR /install

COPY requirements.txt /requirements.txt

RUN pip install --install-option="--prefix=/install" -r /requirements.txt

FROM python:3.7-alpine

COPY --from=builder /install /usr/local
COPY sonos-doorbell.py /app/sonos-doorbell.py
COPY *.mp3 /app/

WORKDIR /app
ENV ROOM Kitchen
ENV PORT 8080
CMD python3 sonos-doorbell.py $ROOM --port $PORT
