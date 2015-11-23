#!/bin/bash

# Find snippets in source code and export to markdown
#
# Usage:
# $ snippets param1 param2 param3
# * param1: <description>
# * param2: <description>
# * param3: <description>

program_name=$0
language=$1
input_path=$2
output_path=$3

show_usage() {
    echo "usage: $program_name param1 param2 param3"
    echo "param1:	programming language [java|js]"
    echo "param2:	input path"
    echo "param3:	output path"
    exit 1
}

search_files() {
 for i in "$1"/*;do
    if [ -d "$i" ];then
        search_files $i
    elif [ -f "$i" ]; then
      if [[ $language == "java" ]];then
        if [[ $i == *".java" ]];then
            echo "search in: $i"
            create_snippets $i "java"
        fi
      elif [[ $language == "js" ]];then
        if [[ $i == *".js" ]];then
            echo "search in: $i"
            create_snippets $i "javascript"
        fi
      fi
    fi
 done
}

create_snippets() {
  mkdir -p $output_path
  sed -n -e '/\/\/BEGIN-SNIPPET:/,/\/\/END-SNIPPET/p' $1 > tmp.md
  #sed -n -e '/\/\/\<snippet/,/\/\/\<\/snippet\>/p' $1 > tmp.md
  while read A ; do
    if [[ $A == "//BEGIN-SNIPPET:"* ]]
    then
        A=$(echo $A | sed 's/\/\/BEGIN-SNIPPET://g')
        filename=$(echo $A | sed 's/\">//g')
        filename="$output_path/$filename.md"
        echo "\`\`\`$2" > $filename
    elif [[ $A == "//END-SNIPPET" ]]
    then
        echo "\`\`\`" >> $filename
        echo "create $filename"
    else
        echo $A >> $filename
    fi

  done < tmp.md
  rm tmp.md
}

if [ ${#@} != 3 ]; then
    show_usage
fi

search_files $input_path
