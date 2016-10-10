#!/bin/bash

val=$(acpi -bi)
str=$(echo ${val} | sed -e 's/.* \([0-9]\+%\), \([0-9]\+\):\([0-9]\+\):.*/\1 \2h\3m/')

echo "| ${str}"
