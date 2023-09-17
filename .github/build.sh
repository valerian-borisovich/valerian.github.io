#!/usr/bin/env bash

BASE_PATH="../.publish"
DIST_PATH="pages"
SITE_PATH="site"

. ../venv/bin/activate

cd $BASE_PATH

python -m pip install --upgrade pip
pip install mkdocs-material mkdocs-redirects
pip install mkdocs-roamlinks-plugin mkdocs-gitbook mkdocs-github

# ###			https://github.com/mkdocs/catalog
# ###

#pip install mkdocs-callouts
#pip install mkdocs-bootstrap
#pip install mkjsfiddle
#plugins:
#  - jsfiddle

#pip install mkdocs-multirepo-plugin
#pip install mkdocs-zettelkasten
#pip install mkdocs-click
#pip install mkdocs-mermaid2-plugin
#plugins:
#  - mermaid2


#https://github.com/ultrabug/mkdocs-static-i18n
#pip install mkdocs-static-i18n
#pip install mkdocs-site-urls
#pip install mkdocs-multirepo-plugin
#pip install markdown_inline_graphviz_extension
#pip install markdown-full-yaml-metadata
#pip install mkdocs-swagger-ui-tag
#pip install mkdocs-video

cd $BASE_PATH
# cd "../.publish"

rm -rf $DIST_PATH
rm -rf $SITE_PATH
mkdir pages

mkdocs build
