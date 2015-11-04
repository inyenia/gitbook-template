#!/bin/bash
# Find snippets engine for java
path="doc/es/snippets"

search_snippets() {
 for i in "$1"/*;do
    if [ -d "$i" ];then
        echo "dir: $i"
        recurse "$i"
    elif [ -f "$i" ]; then
      if [[ $i == *".java" ]];then
          echo "file: $i"
          create_snippets $i
      fi
    fi
 done
}

create_snippets() {
  mkdir -p $path
  sed -n -e '/\/\/\<snippet/,/\/\/\<\/snippet\>/p' $1 > tmp.md
  while read A ; do
    if [[ $A == "//<snippet name="* ]]
    then
        A=$(echo $A | sed 's/\/\/\<snippet name=\"//g')
        filename=$(echo $A | sed 's/\">//g')
        filename="$path/$filename.md"
        echo "\`\`\`java" > $filename
    elif [[ $A == "//</snippet>" ]]
    then
        echo "\`\`\`" >> $filename
        echo "create $filename"
    else
        echo $A >> $filename
    fi

  done < tmp.md
  rm tmp.md
}

search_snippets "src/main/java"
search_snippets "src/test/java"
