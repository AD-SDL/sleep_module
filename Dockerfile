FROM ghcr.io/ad-sdl/wei

LABEL org.opencontainers.image.source=https://github.com/AD-SDL/sleep_module
LABEL org.opencontainers.image.description="An example module that implements a basic sleep(t) function"
LABEL org.opencontainers.image.licenses=MIT

#########################################
# Module specific logic goes below here #
#########################################

RUN mkdir -p sleep_module

COPY ./src sleep_module/src
COPY ./README.md sleep_module/README.md
COPY ./pyproject.toml sleep_module/pyproject.toml
COPY ./tests sleep_module/tests

RUN --mount=type=cache,target=/root/.cache \
    pip install -e ./sleep_module

CMD ["python", "sleep_module/src/sleep_rest_node.py"]

#########################################
