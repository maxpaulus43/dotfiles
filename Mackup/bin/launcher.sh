#!/bin/bash
# Prepend this script to a JAR to make it self-executing
# Don't forget to 'chmod 755'. The "java" command must
# be working
me=$(realpath "$0")
exec java -jar "$me" "$@"
exit 0
