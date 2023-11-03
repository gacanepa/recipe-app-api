FROM python:3.9.18-alpine3.18
LABEL maintainer="Gabriel Cánepa"
LABEL version="1.0"
LABEL description="Dockerfile for the recipe app API"

# Disable output buffering to display logs in real time
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

# Install dependencies and create a user to run the app.
# Adding all the commands in a single RUN statement allows Docker to cache the
# image and avoid re-installing the dependencies every time the code changes.
RUN python -m venv /py && \
  /py/bin/pip install --upgrade pip && \
  /py/bin/pip install -r /tmp/requirements.txt && \
  rm -rf /tmp && \
  adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"

USER django-user