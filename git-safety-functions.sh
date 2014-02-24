#!/bin/bash

# Determine whether this is a git repo that is configured for git-safety extensions
use_safety_extension=false
[[ $(git config ext.gitsafety) ]] && use_safety_extension=true


# Failure message and exit
fail()
{
	echo ==========================
	echo -e $1
	echo ==========================
	exit 1
}