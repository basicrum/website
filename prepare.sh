#! /bin/sh

# Delete most of the files but preserve some
find . -path ./.git -prune -o \( \! -path ./prepare.sh \! -path ./.gitignore \! -path ./README.md \! -path ./.idea \) -exec rm -rf {} \; 2> /dev/null

# COPY all files from just-the-docs
cp -R ./../just-the-docs/_site/* .

rm core-web-vitals/cls.md
rm acknowledgements.md-disabled
rm CODE_OF_CONDUCT.md
rm docker-compose.yml
rm Dockerfile
rm -rf ./assets/css/*.map

# Fix paths
find -name '*.html' -exec sed -i 's/http:\/\/0\.0\.0\.0:4000/https:\/\/www\.basicrum\.com/g' {} +;
find -name '*.js' -exec sed -i 's/http:\/\/0\.0\.0\.0:4000/https:\/\/www\.basicrum\.com/g' {} +;
find -name '*.css' -exec sed -i 's/http:\/\/0\.0\.0\.0:4000/https:\/\/www\.basicrum\.com/g' {} +;
find -name '*.json' -exec sed -i 's/http:\/\/0\.0\.0\.0:4000/https:\/\/www\.basicrum\.com/g' {} +;