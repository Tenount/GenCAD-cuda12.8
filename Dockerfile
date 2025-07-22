FROM ghcr.io/prefix-dev/pixi:noble-cuda-12.8.1
# https://pixi.sh/dev/deployment/container/

WORKDIR /app

# Install system dependencies (including xvfb and OpenGL libs)
RUN apt-get update && apt-get install -y \
    xvfb \
    libgl1 \
    libxrender1 \
    libsm6 \
    libxext6 \
    mesa-utils \
    fonts-dejavu-core \
    x11-utils \
    && rm -rf /var/lib/apt/lists/*

ENV PIXI_ENV=gpu

COPY pixi.toml pixi.lock ./

# install dependencies to `/app/.pixi/envs/prod`
# use `--locked` to ensure the lockfile is up to date with pixi.toml
RUN pixi install --locked -e "$PIXI_ENV"

# create the shell-hook bash script to activate the environment
RUN <<EOT
    pixi shell-hook -e "$PIXI_ENV" -s bash > /shell-hook
    echo "#!/bin/bash" > /app/entrypoint.sh
    cat /shell-hook >> /app/entrypoint.sh

    # extend the shell-hook script to run the command passed to the container
    echo 'exec "$@"' >> /app/entrypoint.sh
    chmod +x /app/entrypoint.sh
EOT

COPY <<EOF /entrypoint.sh

EOF

ENTRYPOINT ["/app/entrypoint.sh"]
