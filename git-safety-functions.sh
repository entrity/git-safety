#!/bin/bash

# Determine whether this is a git repo that is configured for git-safety extensions
# To set this value, run the following:
# $ cd [my_app_dir] && git config ext.gitsafety true
use_safety_extension=false
[[ $(git config ext.gitsafety) == "true" ]] && use_safety_extension=true


# Failure message and exit
fail()
{
	echo ==========================
	echo -e $1
	echo ==========================
	exit 1
}