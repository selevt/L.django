#!/bin/sed -f

#s/<!--\([^\[><]\)/{% comment %}\1/g
#s/\([^]!]\)-->/\1{% endcomment %}/g

s/<title>\([^<]*\)<\/title>/<title>{% block title %}\1{% endblock %}<\/title>/g

s/<\(body\)>/&{% block \1 %}/g
s/<\(header\)>/&{% block \1 %}/g
s/<\(footer\)>/&{% block \1 %}/g

s/<\/\(body\)>/{% block extra_script %}{% endblock %}\n&/g
s/<\/\(body\)>/{% endblock \1 %}&/g
s/<\/\(header\)>/{% endblock \1 %}&/g
s/<\/\(footer\)>/{% endblock \1 %}&/g

s/ src=\(["']\)\([^\/]\)/ src=\1{{ STATIC_URL }}\2/g
s/ href="[\/]\{0,1\}/ href="{{ STATIC_URL }}/g

#humans.txt
0,/\( *\)<link/s##\1<link type="text/plain" rel="author" href="{{ STATIC_URL }}humans.txt" />\n&#

## only first occurrence
0,/\( *\){% comment %} Place .*favicon.ico/s//\1{% block extra_meta %}{% endblock %}\n\n&/  

0,/<\/head>/s//{% block extra_head %}{% endblock %}\n\n&/

s/doctype html>/&\n{% load i18n %}/
s/lang="en"/lang="{{ LANGUAGE_CODE }}"/g


0,/\( *\){% comment %} All JavaScript/s//\1{% block extra_css %}{% endblock %}\n\n&/

s/<div id="main" role="main">/&{% block content %}/
0,/<\/div>/s#</div>#{% endblock content %}&#

s/name="description" content="/&{% block meta_description %}{% endblock %}/
s/name="author" content="/&{% block meta_author %}{% endblock %}/

s#<body>#<body class="{% block body_class %}{% endblock %}">#
