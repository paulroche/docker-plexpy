#!/bin/bash

# Display settings on standard out.

USER="plexpy"

echo "PlexPy settings"
echo "=================="
echo
echo "  User:       ${USER}"
echo "  UID:        ${PLEXPY_UID:=99}"
echo "  GID:        ${PLEXPY_GID:=99}"
echo
echo "  Config:     ${CONFIG:=/data/plexpy/config.ini}"
echo "  App Dir:    ${APPDIR:=/plexpy}"
echo "  Log Dir:    ${LOGDIR:=${APPDIR}/logs/supervisor}"
echo

# Change UID / GID of user.
printf "Updating ${USER} user... "
CUID=$(id -u ${USER} 2> /dev/null)
if [ $? -eq 0 ]; then
  if [ ${CUID} != ${PLEXPY_UID} ]; then
    groupmod -u ${PLEXPY_GID} ${USER}
    usermod -d ${PLEXPY_UID} ${USER}
  fi
else
  groupadd -r -g ${PLEXPY_GID} ${USER}
  useradd -r -u ${PLEXPY_UID} -g ${PLEXPY_GID} -d ${APPDIR} ${USER}
fi
echo "[DONE]"

if [ ! -f ${CONFIG} ]; then
  echo "[ERROR] Unable to find ${CONFIG}"
fi

# Update PlexPy 
# git runs as root,  fix permissions after
git -C ${APPDIR} pull

# Set directory permissions.
printf "Set permissions... "
chmod 2755 ${APPDIR}
chown -R ${USER}: ${APPDIR} 
chown ${USER}: $(dirname ${CONFIG})
echo "[DONE]"

# ensure supervisor logfile is present
if [ ! -f ${LOGDIR}/plexpy.log ]; then
  printf "[INFO] Setting up ${LOGDIR}..."
  mkdir -p ${LOGDIR}
  touch ${LOGDIR}/plexpy.log
  echo "done"
fi

# Finally, start supervisord.
echo "Starting PlexPy..."
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
