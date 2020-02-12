#!/bin/bash
BURL=https://fredrikbaberg.github.io
cd sites/
cd start/
echo "$(pwd)"
$HOME/bin/hugo --baseURL=$BURL
cd ../bio
echo "$(pwd)"
$HOME/hugo --baseURL=$BURL/bio
cd ../presentation
echo "$(pwd)"
$HOME/hugo --baseURL=$BURL/presentation
cd ../scouter
echo "$(pwd)"
$HOME/hugo --baseURL=$BURL/scouter
cd ../../
echo "Klart att kopiera public/ till server."