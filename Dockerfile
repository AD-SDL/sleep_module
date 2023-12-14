FROM ghcr.io/ad-sdl/wei

LABEL org.opencontainers.image.source=https://github.com/AD-SDL/sleep_module
LABEL org.opencontainers.image.description="An example module that implements a basic sleep(t) function"
LABEL org.opencontainers.image.licenses=MIT

USER wei
WORKDIR /home/wei

RUN mkdir -p sleep_module

COPY --chown=wei:wei ./src sleep_module/src
COPY --chown=wei:wei ./README.md sleep_module/README.md
COPY --chown=wei:wei ./pyproject.toml sleep_module/pyproject.toml

RUN pip install ./sleep_module

CMD ["python", "sleep_module/src/sleep_rest_node.py"]
