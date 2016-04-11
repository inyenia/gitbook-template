#!/bin/bash
# UTILS
# -----
update_snippets() {
    for n in $(awk -F "[()]" '{ for (i=2; i<NF; i+=2) print $i  }' doc/LANGS.md)
    do
        out="./doc/$n/snippets"
        rm -rf "$out/*"
        search_files $snippets_input_path $out
    done
}

search_files() {
 for i in "$1"/*;do
    if [ -d "$i" ];then
        search_files $i $2
    elif [ -f "$i" ]; then
        if [[ $i == *".java" ]];then
            create_snippets $i $2
        fi
    fi
 done
}

create_snippets() {
  mkdir -p $snippets_output_path
  sed -n -e '/\/\/ BEGIN-SNIPPET:/,/\/\/ END-SNIPPET/p' $1 > tmp.md
  
  while read A ; do
    if [[ $A == "// BEGIN-SNIPPET:"* ]]
    then
        A=$(echo $A | sed 's/\/\/ BEGIN-SNIPPET://g')
        filename=$(echo $A | sed 's/\">//g')
        filename="$2/$filename.md"
        echo "\`\`\`$2" > $filename
    elif [[ $A == "// END-SNIPPET" ]]
    then
        echo "\`\`\`" >> $filename
        echo " - Creating snippet: $filename"
    else
        echo $A >> $filename
    fi

  done < tmp.md
  rm tmp.md
}

replace_gitbook_variables() {
    for file in `find 'doc/book.json'`; do
      grep "$1" $file &> /dev/null
      if [ $? -ne 0 ]; then
        echo " - Variable $1 not found in $file!"
      else
        sed -i "" "s/$1/$2/g" $file
      fi
    done
}

# VARS
# ----
VERSION="1.0"
snippets_input_path="./src"
snippets_output_path="./doc/es/snippets"
search_version='__version__'
search_date='__date__'
replace_date=$(date +"%d\/%m\/%Y")

# CHECK DEPENCENCIES
# ------------------
hash mvn 2>/dev/null || { echo >&2 "Maven is required"; exit 1; }
hash gitbook 2>/dev/null || { echo >&2 "GitBook is required"; exit 1; }

# SET VERSION
# -----------
if [ -n "$1" ]; then
    VERSION=$1
else
    VERSION=$(mvn -q \
      -Dexec.executable="echo" \
      -Dexec.args='${project.version}' \
      --non-recursive \
      org.codehaus.mojo:exec-maven-plugin:1.3.1:exec)
fi

echo "----------------------------------------------"
echo "Building documentation for $VERSION version"
echo "----------------------------------------------"

# REMOVE OLD DOC
# --------------
echo "Removing old generated documentation…"
rm -rf "doc/generated/$VERSION"

# UPDATE GITBOOK VARIABLES
# ------------------------
echo "Updating gitbook variables…"
replace_gitbook_variables $search_version $VERSION
replace_gitbook_variables $search_date $replace_date

# UPDATE SNIPPETS
# ---------------
echo "Updating snippets…"
update_snippets

# GITBOOK GENERATION
# ------------------
echo "Installing gitbook plugins…"
gitbook install ./doc --log disabled

echo "Generating HTML documentation…"
gitbook build ./doc --log disabled

echo "Generating PDF documentation…"
gitbook pdf ./doc --log disabled

# MOVE GENERATED DOCS
# -------------------
echo "Moving generated documentation…"
[ -d "doc/generated/$VERSION" ] || mkdir -p "doc/generated/$VERSION"
[ -d doc/_book ] && mv -f doc/_book/ "doc/generated/$VERSION/html"

[ -d "doc/generated/$VERSION/pdf" ] || mkdir -p "doc/generated/$VERSION/pdf"

for n in $(awk -F "[()]" '{ for (i=2; i<NF; i+=2) print $i  }' doc/LANGS.md)
do
    [ -f "doc/book_$n.pdf" ] && mv "doc/book_$n.pdf" "doc/generated/$VERSION/pdf/documentation-$n-$VERSION.pdf"
done

# CLEANUP
# -------
rm -rf "doc/generated/$VERSION/html/build.sh"
rm -rf "doc/generated/$VERSION/html/cover.psd"
rm -f doc/npm-debug.log
rm -rf doc/node_modules

replace_gitbook_variables $VERSION $search_version
replace_gitbook_variables $replace_date $search_date

# SUCCESS
# -------
echo ""
echo "Your documentation for $VERSION version is in: ./doc/generated/$VERSION/"