# Application
[PlexPy](https://github.com/drzoidberg33/plexpy)

# Description
A python based web application for monitoring, analytics and notifications for Plex Media Server

# Access application
`http://<host ip>:8181`

# Owner / Group
You can override the PUID and PGID by defining PLEXPY_UID and PLEXPY_GID within vars
```
cat vars
PLEXPY_UID=123
PLEXPY_GID=123
```

# Volumes
Volumes can be adjusted within `docker-compose`

* `/data/plexpy` is where configuration is stored
* `/logs` is path to your Plex Media Server logs

# Run the application
## Usage
```
docker-compose build
docker-compose up -d
```

To get a shell:
```
docker-compose run -p 8181:8181 --entrypoint /bin/bash plexpy
```

# Notes
User ID (PUID) and Group ID (PGID) can be found by issuing the following command for the user you want to run the container as:
```
id <username>
```
