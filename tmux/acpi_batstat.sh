#!/bin/bash

val=$(acpi -bi | head -1)
str=$(echo ${val} | sed -e 's/.* \([0-9]\+%\)\(, \([0-9]\+\):\([0-9]\+\):.*\|\(\)\)/\1 \2h\3m/')

echo "| ${str}"

#| Battery 0: Unknown, 97% Battery 0: design capacity 2900 mAh, last full capacity 2900 mAh = 100%
