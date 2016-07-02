#!/bin/sh

ls | egrep '(html)' |
perl -e 'print "<html><body><ul>"; while(<>) { chop $_; print "<li><a href=\"./$_\">$_</a></li>";} print "</ul></body></html>"' > listado_graficos.html
