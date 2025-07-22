start:
    docker compose up -d --build

stop:
    # cz tail -f
    docker compose kill

attach:
    docker exec -it gencad-gencad-1 pixi shell -e gpu
