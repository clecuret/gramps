#!/bin/bash
set -e

if [ "$1" = 'gramps' ]; then
	uid=${UID:-1000}
	gid=${GID:-1000}
  lang=${LANG:-fr-FR}
	# create user group
	if ! getent group developer >/dev/null; then
		groupadd -f -g ${gid} developer
	fi
  chown -R ${uid}:${gid} /home/developer
	# create user with uid and gid matching that of the host user
	if ! getent passwd developer >/dev/null; then
		adduser --uid ${uid} --gid ${gid} --disabled-login --gecos 'Developer' developer
	fi
	if [ "$2" = 'backup' ]; then
		exec su developer -c "gramps -O 'clecuret' -e /data/backup.gpkg"
	else
	  exec su developer -c "gramps"
  fi
fi

exec "$@"
