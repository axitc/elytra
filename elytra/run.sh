#!/bin/bash

# Author : Akshit Chhikara

makeconf () {
	echo -n 'server.document-root = "' > lighttpd.conf
	cd site
	dir=$(pwd)
	cd ..
	echo -n $dir >> lighttpd.conf
	echo '"' >> lighttpd.conf
	cat makeconf/template.conf >> lighttpd.conf
}

echodelta () {
	cat ../../makehtml/delta.html | sed "s/arg1/$1/" | sed "s/arg2/$2/" | sed "s/arg2/$2/"
}

echoip () {
	echo "IP : $1"
}

echoport () {
	echo "Port : $3"
}

makeconf

cd site/file

cat ../../makehtml/alpha.html > ../index.html

for i in $(ls -1); do
	echodelta $(du -h $i) >> ../index.html
done

cat ../../makehtml/omega.html >> ../index.html


cd ../..
sudo ufw disable
echo ""
echoip $(hostname -I)
echoport $(cat lighttpd.conf | grep server.port)
echo ""
sudo lighttpd -D -f lighttpd.conf
echo ""
sudo ufw enable
