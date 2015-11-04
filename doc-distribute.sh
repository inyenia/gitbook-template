#!/bin/bash
path=`pwd`

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

echo "Distribute version: "$VERSION
echo "Updated in https://inyenia.github.io/gitbook-template"

rm -rf /tmp/gitbook-template
cd /tmp
git clone git@github.com:inyenia/gitbook-template.git
cd gitbook-template
git checkout -b gh-pages origin/gh-pages

cd $path
cp -Rf doc/html/es/* /tmp/gitbook-template/

#History
mkdir -p /tmp/gitbook-template/$VERSION
cp -Rf doc/html/es/* /tmp/gitbook-template/$VERSION/

cd /tmp/gitbook-template
git add .
git commit -m "update version $VERSION"
git push origin gh-pages
