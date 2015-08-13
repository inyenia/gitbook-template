#!/bin/bash
VERSION="1.0"

if [ -n "$1" ]; then
    VERSION=$1
else
    VERSION=$(mvn -q \
      -Dexec.executable="echo" \
      -Dexec.args='${project.version}' \
      --non-recursive \
      org.codehaus.mojo:exec-maven-plugin:1.3.1:exec)
fi

echo "Build version: "$VERSION

rm -rf doc/html

echo "Build doc $VERSION version in " `pwd`

echo "Add update date and version"
search='#*#version_info#*#'
now=$(date +"%d\/%m\/%Y")
replace="Versión\ $VERSION\ actualizada\ el\ $now"
echo "Replace $search with $replace"
for file in `find 'doc/es/README.md'`; do
  grep "$search" $file &> /dev/null
  if [ $? -ne 0 ]; then
    echo "Search string not found in $file!"
  else
    sed -i "" "s/$search/$replace/g" $file
  fi
done

echo "Generate PDF"
gitbook build ./doc
gitbook pdf ./doc

echo "Prepare HTML"
cp -rf doc/_book/ doc/html/
rm -rf doc/_book/
rm -f npm-debug.log
rm -rf node_modules

echo "Restore changes in .md"
git checkout -- doc/es/README.md
