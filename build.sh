#!/bin/bash
# BURL=https://fredrikbaberg.github.io
BURL=https://baberg.nu
cd sites/
cd start/
hugo --baseURL=$BURL
cd ../bio
hugo --baseURL=$BURL/bio
cd ../presentation
hugo --baseURL=$BURL/presentation
cd ../scouter
hugo --baseURL=$BURL/scouter
cd ../../
echo "Klart att kopiera public/ till server."