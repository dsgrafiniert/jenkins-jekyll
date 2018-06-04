# When a DOCKER_GID_ON_HOST is supplied, run jenkins with this
# group id - to access the docker socket shared via volume
dockerGroupName=""
if [ -n "$DOCKER_GID_ON_HOST" ]; then

echo "Create group for gid $DOCKER_GID_ON_HOST"
sudo groupadd -g $DOCKER_GID_ON_HOST docker && sudo grpconv
sudo usermod -a  -G $DOCKER_GID_ON_HOST jenkins
dockerGroupName=$(cat /etc/group | grep :$DOCKER_GID_ON_HOST: | cut -d: -f1)

fi;