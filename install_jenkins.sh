#!/bin/bash

rm -r docker-jenkins-test

git clone https://github.com/gauravgoyal703/docker-jenkins-test.git
cd docker-jenkins-test
mkdir config
cp ../config/envdev.txt config/.env.dev
sh ./install_script.sh
