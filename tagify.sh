#####
# tagify.sh -- create individual pages for tags in jekyll
#
#  author:     Pat Gaffney <pat@hypepat.com>
#  created:    2017-01-16
#  modified:   2017-01-16
#  project:    hypepat.com
#  license:    MIT
#
# This script searches a Jekyll repository for all of your posts, parses
# the tags/topics/categories/whatever (henceforth referred to as tags) out 
# of their YAML front matter, and creates an HTML file for each unique tag
# in a directory of your choosing.
#
# This script is fairly configurable -- see the USER CONFIGURATION section
# below, but it does assume that you use YAML's bracketed sequence to 
# denote your tags:
#
#       ---
#       ...
#       tag: [git, bash, zsh]
#       ...
#       ---
#
# It would be trivial to change this to support other YAML sequence 
# types: list-syntax, scalars-to-scalars, etc.
#
# In order for this script to work properly, you need to create a 
# Jekyll collection in your _config.yml file as such:
#
#       collections:
#           topics:
#               output: true
#               permalink: /topics/:path.html
#
# This tells Jekyll to search in the _topics/ directory for HTML pages
# that will need rendering at build-time. This can be added to your
# build script to ensure that everytime you write a new post with a new
# tag, that file is automatically created. This output directory is
# configurable via a global constant in the USER CONFIGURATION section.
#
# The actual text that is written to the created HTML file is at the 
# bottom of this file in a bash HERE document. You can change it to be
# whatever you would like.
#
#########################################################################

#!/usr/bin/env bash

#########################################################################
# USER CONFIGURATION 
#
# These global constants control where the input comes from, how the
# parsing is done, and where the output is written. They can be changed
# on a project-basis to better reflect your needs.
#
# - POSTDIRS: the directory to search for posts, relative to $CWD
# - TAGSPREFIX: the YAML scalar variable that you want to parse
# - TAGSDIR: the directory you want the generated HTML files written to
# - TAGSDIVISOR: a replacement for whitespace in multi-word tags
#
#########################################################################
POSTSDIR="$PWD/_posts"
TAGSPREFIX="tags:"
TAGSDIR="$PWD/_topics"
TAGDIVISOR="-"

#########################################################################
# ANSI COLOR SUPPORT
#
# If your terminal does not support ANSI colors, assign each of these
# constants an empty string, or enable colors.
#
#########################################################################
GREEN=$'\e[32m'
BOLD=$'\e[1m'
RED=$'\e[31m'
RESET=$'\e[0m'

TAGFILES=0

#########################################################################
# CHECK THE VERSION OF BASH
#
# This script makes extensive use of bash arrays, which we're introduced
# in bash 4.0. You will need to upgrade if your still using bash 3.x.
#
#########################################################################
function check_version {
    local bashversion=${BASH_VERSION:0:1}
    
    if [[ $bashversion != "4" ]]; then
        echo -e "$BOLD$RED ERROR:$RESET$BOLD this script requires bash >= 4.0$RESET"
        exit 1
    else
        echo -e "$BOLD --> searching for tags...$RESET"
        read_tags
    fi
}


#########################################################################
# PARSE THE POSTS FILES FOR TAGS
#
# Each of the files in $POSTSDIR is parsed looking for tags. As the tags
# are found, they are printed to stdout and saved to an indexed array.
#
#########################################################################
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


#########################################################################
# REMOVE ANY DUPLICATE TAGS FROM THE ARRAY
#
# Because the tags are added to the array as they are parsed, there are
# probably duplicates in the array. The array is looped through once, 
# and all duplicates are pruned as they are found.
#
#########################################################################
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


#########################################################################
# DETERMINE WHICH TAGS NEED FILES
#
# Everytime this script is run, it may or may not create any new files.
# If all of the tags found when parsing already have files, then no new
# files need to be created.
#
#########################################################################
function create_tag_files {
    declare -a newtags=("${@}")
    local tagline=''
    
    for tag in "${tags[@]}"
    do
        # Replace spaces in tag name with $TAGDIVISOR.
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


#########################################################################
# CREATE AND WRITE TO A NEW TAG FILE
#
# This function is called once for each tag that needs a file. The tag
# name itself (with spaces) is available as the first parameter: $1. The
# entire HERE document is written to the file, so it can be changed to 
# suit your needs.
#
#########################################################################
function write_tag_file {
(
cat <<EOF
---
title: $1
layout: page
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
}


#########################################################################
# BEGIN EXECUTION
#########################################################################
check_version
