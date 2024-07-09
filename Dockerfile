FROM python:3.9.18-alpine3.18
LABEL maintainer="Gabriel Cánepa"
LABEL version="1.0"
LABEL description="Dockerfile for the recipe app API"

# Disable output buffering to display logs in real time
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 9000
RUN mkdir -p locale

# Install dependencies and create a user to run the app.
# Adding all the commands in a single RUN statement allows Docker to cache the
# image and avoid re-installing the dependencies every time the code changes.
ARG DEV=false
RUN python -m venv /py && \
  /py/bin/pip install --upgrade pip && \
  apk add --update --no-cache postgresql-client gettext && \
  apk add --update --no-cache --virtual .tmp-build-deps \
    build-base postgresql-dev musl-dev && \
  /py/bin/pip install -r /tmp/requirements.txt && \
  if [ "$DEV" = "true" ]; \
    then /py/bin/pip install -r /tmp/requirements.dev.txt; \
    fi && \
  rm -rf /tmp && \
  apk del .tmp-build-deps && \
  adduser \
    --disabled-password \
    --no-create-home \
    django-user

ENV PATH="/py/bin:$PATH"

USER django-user