FROM python:3.11

RUN mkdir -p /sleep_module

COPY ./src /sleep_module/src
COPY ./README.md /sleep_module/README.md
COPY ./pyproject.toml /sleep_module/pyproject.toml

RUN pip install ./sleep_module

CMD ["python", "/sleep_module/src/sleep_rest_node.py"]
