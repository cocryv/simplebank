#!/bin/sh

set -e

echo "run db migration"
# ici on utilise source car on veut montrer ou son les variable d'environnement dans notre réseau de conteneur

source /app/app.env
/app/migrate -path /app/migration -database "$DB_SOURCE" -verbose up

echo "start the app" 


exec "$@"