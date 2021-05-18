#!/bin/bash

rm -r docker-jenkins-test

git clone https://github.com/gauravgoyal703/docker-jenkins-test.git
cd docker-jenkins-test
mkdir config
cp ../config/.env.dev config/.env.dev
sh ./install_script.sh
