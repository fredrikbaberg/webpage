RD public /s /q
cd sites/
cd start/
hugo --baseURL="http://localhost" --quiet
cd ../bio
hugo --baseURL="http://localhost/bio" --quiet
cd ../presentation
hugo --baseURL="http://localhost/presentation" --quiet
cd ../scouter
hugo --baseURL="http://localhost/scouter" --quiet
cd ../personal
hugo --baseURL="http://localhost/personal" --quiet
cd ../../
cd public/
python -m http.server 80