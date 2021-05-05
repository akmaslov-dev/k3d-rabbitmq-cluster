# k3d RabbitMQ Cluster proto

#WIP


## Install section

1) Install `docker`(if needed).


2) Install `curl` or `wget`(if needed):
    ```bash
    # curl
    sudo apt-get update && sudo apt-get install -y curl
    ```

    ```bash
    # wget
    sudo apt-get update && sudo apt-get install -y curl
    ```


3) Install `k3d` via `curl` or `wget`:

    ```bash
    # curl
    curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
    ```

    ```bash
    # wget
    wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
    ```


4) Install `make`:

    ```bash
    sudo apt-get update && sudo apt-get install -y make
    ```