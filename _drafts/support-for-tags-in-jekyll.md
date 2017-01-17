---
title: Better Tag Support in Jekyll
layout: post
date: 2017-01-16 15:00
tags: [jekyll, bash, pelican, meta]
published: true
summary: A simple script to extend the support for tags or categories on posts in Jekyll.
---

- spent the weekend switching from pelican to jekyll
- pelican has great tags/categories support
- the jekyll community relies on plugins for this functionality
    - <http://www.journel.stuffwithstuff.com>
- i made the switch because i was was flirting with github pages
    - turns out i don't want that
    - i also wanted to get some ruby experience
        - i never used it in school, we dont use it at work
    - jekyll is the most popular static site gen
        - it isnt even close
        - <http://www.staticgen.com>
- turns out the grass isn't always greener

### The Functionality I Want

- every post contains tags
- tags are displayed on every post
- tags are displayed every time the article is (index, archive)
- all tags are collected on a *topics* page with totals for how many pages are in each topic
- the tags themselves have pages where all of the articles discussing that tag are listed, reverse-chronologically

### Getting the Topics Page to Work

- liquid template

### A Tags Collections

- explain collections
- how the tags will work

### Bash Script

- go through the script, function-by-function
- <http://www.yaml.org/spec/1.2/spec.html>

### Makefile

- clean
- publish
- rsync
