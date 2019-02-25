Here is a copy of the docker compose file you can use.  You'll need to provide the Database name you want to use and the superuser username and password.


version: '3.7'
services:
  postgres-db:
    image: postgres:11.2
    container_name: postgresdb
    ports:
    - 5432:5432
    volumes:
      - "/Users/bhudson/dockervolumes/ocmdb:/var/lib/postgresql/data"
    environment:
      - POSTGRES_PASSWORD=
      - POSTGRES_USER=
      - POSTGRES_DB=
    shm_size: '256MB'
