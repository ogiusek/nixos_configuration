{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
    fzf
    (pkgs.writeShellScriptBin "docker-container" ''
    #!/bin/bash

    if ! command -v fzf &> /dev/null; then
        echo "fzf is not installed. Please install it to use this script."
        exit 1
    fi

    # List running containers and allow selection
    CONTAINER=$(docker ps --format "{{.Names}}" | fzf)

    # Check if a container was selected
    if [ -n "$CONTAINER" ]; then
        # Execute bash in the selected container
        docker exec -it "$CONTAINER" /bin/bash
    else
        echo "No container selected."
    fi
    '')
  ];
}