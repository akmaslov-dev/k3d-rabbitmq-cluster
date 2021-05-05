#!/bin/sh

set -e

# Proceed command to docker container
case "$1" in
    rabbitmq-operator)
        ## RabbitMQ Operator
        echo ""
        echo "********** Installing RabbitMQ Operator **********"
        while [ $(kubectl get pods -n rabbitmq-system | grep -E '^rabbitmq\-cluster\-operator' | grep -E 'Running' | wc -l) -ne 1 ] ; do
          echo 'RabbitMQ Operator not ready...';
          sleep 3;
        done
        echo ""
        echo "********** RabbitMQ Operator Installed **********"
        ;;
    rabbitmq-cluster)
        ## RabbitMQ Cluster
        echo ""
        echo "********** Installing RabbitMQ Cluster **********"
        while [ $(kubectl get pods -n rabbitmq-dev | grep -E '^rabbitmq\-(cluster)' | grep -E '1/1|2/2' | grep -E 'Running' | wc -l) -ne 3 ] ; do
          echo 'RabbitMQ cluster not ready...';
          sleep 3;
        done
        echo ""
        echo "********** RabbitMQ Cluster Installed **********"
        ;;
esac
