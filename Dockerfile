FROM ghcr.io/ad-sdl/wei

LABEL org.opencontainers.image.source=https://github.com/AD-SDL/sleep_module
LABEL org.opencontainers.image.description="An example module that implements a basic sleep(t) function"
LABEL org.opencontainers.image.licenses=MIT

ARG USER_ID=1000
ARG GROUP_ID=1000
ARG CONTAINER_USER=app
ARG CONTAINER_GROUP=app
USER ${CONTAINER_USER}
WORKDIR /home/${CONTAINER_USER}

# Add python packages to path
ENV PATH="$PATH:/home/${CONTAINER_USER}/.local/bin"

#########################################
# Module specific logic goes below here #
#########################################

RUN mkdir -p sleep_module

COPY --chown=${CONTAINER_USER}:${CONTAINER_GROUP} ./src sleep_module/src
COPY --chown=${CONTAINER_USER}:${CONTAINER_GROUP} ./README.md sleep_module/README.md
COPY --chown=${CONTAINER_USER}:${CONTAINER_GROUP} ./pyproject.toml sleep_module/pyproject.toml
COPY --chown=${CONTAINER_USER}:${CONTAINER_GROUP} ./tests sleep_module/tests

RUN --mount=type=cache,target=/home/${CONTAINER_USER}/.cache,uid=${USER_ID},gid=${GROUP_ID} \
    pip install -e ./sleep_module

CMD ["python", "sleep_module/src/sleep_rest_node.py"]

#########################################
USER root
