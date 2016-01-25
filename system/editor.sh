#!/bin/bash

# Fix insane stuff such as visudo opening nano
if [[ -L /etc/alternatives/editor ]]; then
	ln -sf `which vim` /etc/alternatives/editor
fi
