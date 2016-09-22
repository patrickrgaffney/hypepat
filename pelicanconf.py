#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

#####################################################################
# SITE
#####################################################################

# Default author of all posts.
AUTHOR = 'Pat Gaffney'

# Name of site -- to be used in theme templates.
SITENAME = 'hypepat'

# Turn OFF URL's for local testing -- add back in publishconf.py.
SITEURL = ''

# Default language to use.
DEFAULT_LANG = 'en'

#####################################################################
# DATES
#####################################################################

# Set the default date for posts to be the file system timestamp for
# the file in question (only if no time is provided in metadata).
DEFAULT_DATE = 'fs'

# Format of dates: "Month DD, YYYY".
DEFAULT_DATE_FORMAT = '%B %d, %Y'

# Timezone used to generate date information.
TIMEZONE = 'America/Chicago'


#####################################################################
# THEME
#####################################################################

# Path to theme folder
THEME = 'theme'

# Ignore pre-made theme directives.
DISPLAY_PAGES_ON_MENU = False
DISPLAY_CATEGORIES_ON_MENU = True

# Pagination turned off for this theme.
DEFAULT_PAGINATION = False

# Order newer articles on top in archive.
NEWEST_FIRST_ARCHIVES = True

# Order articles by date -- newest first.
ARTICLE_ORDER_BY = 'reversed-date'

# Order pages alphabetically by their page name.
PAGE_ORDER_BY = 'basename'

#####################################################################
# CONTENT
#####################################################################

# Path to content directory to be processed by Pelican.
PATH = 'content'

# I'm not use categories for this site -- only tags.
USE_FOLDER_AS_CATEGORY = False
DEFAULT_CATEGORY = 'Misc'
REVERSE_CATEGORY_ORDER = False

# If summary metadata is not set, it will default to first 50 words.
SUMMARY_MAX_LENGTH = 50

# Do NOT copy the *.md files to the output folder.
OUTPUT_SOURCES = False

# Extensions for Python-Markdown processor.
## http://pythonhosted.org/Markdown/extensions/
MD_EXTENSIONS = [
    'codehilite(css_class=highlight)', 
    'extra',
    'smarty'
]

# Dates set in the future will default to 'draft' status.
WITH_FUTURE_DATES = False

# Posts will default to a 'draft' status -- can be overriden by 
# updating post's metadata to 'published'.
DEFAULT_METADATA = {'status': 'draft'}

#####################################################################
# LINKS
#####################################################################

# Used throughout the templates.
TWITTER_URL = 'https://twitter.com/patrickrgaffney'
GITHUB_URL = 'https://github.com/patrickrgaffney'
EMAIL_URL = 'mailto:pat@hypepat.com'
DIGITAL_OCEAN_URL = 'https://www.digitalocean.com/?refcode=51e4a0710dcc'
HOVER_URL = 'https://hover.com/9ruS0o2u'
GITHUB_PELICAN_URL = 'https://github.com/getpelican/'

#####################################################################
# OUTPUT
#####################################################################

# Folder to put output .html files
OUTPUT_PATH = 'public_html'

# List of directories to find 'pages', relative to $PATH
PAGE_PATHS = ['pages']

# A list of directories relative to $PATH where to look for static
# files. These files are copied to the output directory.
STATIC_PATHS = ['images', 'icons']

# Articles become 'hypepat.com/year/slug.html'.
ARTICLE_SAVE_AS = '{date:%Y}/{slug}.html'
ARTICLE_URL = '{date:%Y}/{slug}.html'

# Pages become 'hypepat.com/slug.html'.
PAGE_URL = '{slug}.html'
PAGE_SAVE_AS = '{slug}.html'

# Tags become 'hypepat.com/tag/slug.html.
TAG_URL = 'tag/{slug}.html'
TAG_SAVE_AS = 'tag/{slug}.html'

# Not using categories.
CATEGORY_URL = ''
CATEGORY_SAVE_AS = ''

# Not using author template -- I am the only author.
AUTHOR_SAVE_AS = ''
AUTHORS_SAVE_AS = ''

# Turn off Year / Month / Day archives -- just use the main archive.
YEAR_ARCHIVE_SAVE_AS = ''
MONTH_ARCHIVE_SAVE_AS = ''
DAY_ARCHIVE_SAVE_AS = ''

# Feed generation turned off for local development.
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None