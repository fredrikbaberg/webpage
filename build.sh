#!/bin/bash
BURL=https://fredrikbaberg.github.io
cd sites/
cd start/
echo "$(pwd)"
hugo --baseURL=$BURL
cd ../bio
echo "$(pwd)"
hugo --baseURL=$BURL/bio
cd ../presentation
echo "$(pwd)"
hugo --baseURL=$BURL/presentation
cd ../scouter
echo "$(pwd)"
hugo --baseURL=$BURL/scouter
cd ../../
echo "Klart att kopiera public/ till server."