version=`grep -oP '(?<=version = ")[^"]+' pyproject.toml | head -n 1`
name=`grep -oP '(?<=name = ")[^"]+' pyproject.toml | head -n 1`

docker push ghcr.io/ad-sdl/${name}:${version}

