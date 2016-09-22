#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

# This file is only used if you use `make publish` or
# explicitly specify it as your config file.

import os
import sys
sys.path.append(os.curdir)

# Import settings from pelicanconf.py file.
from pelicanconf import *

SITEURL = 'http://hypepat.com'
RELATIVE_URLS = False

FEED_ATOM = 'feeds/atom.xml'
FEED_RSS = None
FEED_MAX_ITEMS = 10
FEED_ALL_RSS = None
FEED_ALL_ATOM = None
TAG_FEED_RSS = None
TAG_FEED_ATOM = None
AUTHOR_FEED_RSS = None
AUTHOR_FEED_ATOM = None
CATEGORY_FEED_RSS = None
CATEGORY_FEED_ATOM = None

# output to public_html/
# this is set in Makefile
# OUTPUT_PATH = 'public_html'

DELETE_OUTPUT_DIRECTORY = True