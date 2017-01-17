#####
# tagify.sh -- create individual pages for tags in jekyll
#
#  author:     Pat Gaffney <pat@hypepat.com>
#  created:    2017-01-16
#  modified:   2017-01-16
#  project:    hypepat.com
#
#########################################################################

#!/usr/bin/env bash

## USER CONFIGURATION ##
POSTSDIR="$PWD/_posts"
TAGSPREFIX="tags:"
TAGSDIR="$PWD/_topics"
TAGDIVISOR="-"

## Colors ##
GREEN=$'\e[32m'
BOLD=$'\e[1m'
RED=$'\e[31m'
RESET=$'\e[0m'

## TOTALS ##
TAGFILES=0

function check_version {
    local bashversion=${BASH_VERSION:0:1}
    
    if [[ $bashversion != "4" ]]; then
        echo -e "$BOLD$RED ERROR:$RESET this script requires bash >= 4.0"
        exit 1
    else
        echo -e "$BOLD --> searching for tags...$RESET"
        read_tags
    fi
}

function read_tags {
    declare -a tags
    local tagline=''
    local OLDIFS="$IFS"
    
    # Loop through every file in $POSTSDIR
    for post in "$POSTSDIR"/*
    do
        if [ -f "$post" ]; then
            echo -e "$BOLD --> checking ${post##$POSTSDIR/}$RESET"
            while read line
            do
                if [[ $line =~ ^[:space:]*$TAGSPREFIX[:space:]* ]]; then 
                    
                    # Remove the "$TAGPREFIX [" prefix from the line.
                    tagline=${line##*$TAGSPREFIX[[:space:]]*\[}
                    
                    # Remove the "]" suffix from the line.
                    tagline=${tagline%%\]*}
                    
                    # Remove the whitespace after each comma.
                    tagline=${tagline//,[[:space:]]/,}
                    
                    IFS=','
                    tags+=($tagline)
                    IFS="$OLDIFS"
                    echo "$BOLD -->$GREEN found tags:$RESET $tagline"
                    break
                fi
            done < $post
        else
            echo -e "$BOLD --> skipping ${post##$POSTSDIR}$RESET"
        fi
    done
    
    echo -e "$BOLD --> removing duplicates...$RESET"
    remove_duplicates tags[@]
}

function remove_duplicates {
    declare -a oldarray=("${!1}")
    declare -A seen
    declare -a tags
    
    for tag in "${oldarray[@]}"
    do
            if [ ! "${seen[$tag]}" ]
            then
                    tags+=("$tag")
                    seen["$tag"]=1
            fi
    done
    echo -e "$BOLD -->$GREEN tags collected:$RESET"
    printf '\t%s\n' "${tags[@]}"
    
    create_tag_files ${tags[@]}
}

function create_tag_files {
    declare -a newtags=("${@}")
    local tagline=''
    
    for tag in "${tags[@]}"
    do
        tagline=${tag//[[:space:]]/"$TAGDIVISOR"}
        if [ -f "$TAGSDIR/$tagline.html" ]; then
            printf "$BOLD --> skipping $tag: html file already exists$RESET\n"
        else
            printf "$BOLD -->$GREEN creating $tagline.html file $RESET\n"
            write_tag_file $tag
            let TAGFILES++
        fi
    done
    printf "$BOLD --> created $TAGFILES new tag files!$RESET\n"
}

function write_tag_file {
# -----------------------------------------------------------
# 'Here document containing the body of the generated script.
(
cat <<EOF
---
title: $1
layout: paged
---

{% assign site_tags = site.tags | sort | compact %}
{% for tag in site_tags %}
    {% if tag[0] == page.title %}
        {% for article in tag[1] %}
          <dl>
            <dt>{{ article.date | date: "%b %-d, %Y" }}</dt>
            <dd><a href="{{ article.url | relative_url }}">{{ article.title | escape }}</a></dd>
            <dd>{{ article.summary }}</dd>
            {% if article.tags %}
            <dd>
            {% for tag in article.tags %}
              <a class="tag" href="/topics/{{ tag | replace: " ", "-" }}.html">{{ tag }}</a>
            {% endfor %}
            </dd>
            {% endif %}
        {% endfor %}
    {% endif %}
{% endfor %}

EOF
) > "$TAGSDIR/$1.html"
# -----------------------------------------------------------
}

check_version