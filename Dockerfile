FROM python:3.11

LABEL org.opencontainers.image.source=https://github.com/AD-SDL/sleep_module
LABEL org.opencontainers.image.description="An example module that implements a basic sleep(t) function"
LABEL org.opencontainers.image.licenses=MIT

RUN mkdir -p /sleep_module

COPY ./src /sleep_module/src
COPY ./README.md /sleep_module/README.md
COPY ./pyproject.toml /sleep_module/pyproject.toml

RUN pip install ./sleep_module

CMD ["python", "/sleep_module/src/sleep_rest_node.py"]
