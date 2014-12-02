# installing mongodb
if ! dpkg -s mongodb-org-server &> /dev/null ; then
	echo Installing MongoDB

	# add the mongodb repo as a trusted package source
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
	echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list
	apt-get update &> /dev/null

	# install the package, mongo should start automatically after this
	apt-get install -y mongodb-org-server

	# make sure we can connect to it from the host
	sed -in '/^bind_ip/d' /etc/mongod.conf
	# ... and restart because of config changes
    service mongod restart
fi
