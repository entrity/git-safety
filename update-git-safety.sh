#!/bin/bash
 
# Usage:
#
# $ sudo update-gitsafety.sh
#
 
# Destination for downloaded git extensions
dst=
newInstall=false
# find PATH directory where git-safeties are installed curently
while IFS=':' read -ra DIRS; do
	for d in "${DIRS[@]}"; do
		if [[ -r "$d/git-safetymerge" ]]; then
			dst=$d
			break
		fi
	done
done <<< $PATH
if [[ -z "$dst" ]]; then dst=/usr/local/bin; newInstall=true; fi
if [[ ! -w $dst ]]; then
	echo "=============== ERROR: you have no write permissions to $dst. Please use sudo and try again"
	exit 1
fi
 
echo == Downloading git extensions to $dst ==
 
# Download extension files
wget https://gist.github.com/Vaselinessa/8361013/raw/git-safetymerge -O $dst/git-safetymerge
wget https://gist.github.com/Vaselinessa/8361013/raw/git-safetycommit -O $dst/git-safetycommit
wget https://gist.github.com/Vaselinessa/8361013/raw/update-gitsafety.sh -O $dst/update-gitsafety.sh
 
# Make safety extensions executable
chmod +x $dst/git-safetymerge
chmod +x $dst/git-safetycommit
chmod +x $dst/update-gitsafety.sh
 
if $newInstall; then
	# Alias git in .bash_profile
	cat <<-HERED >> $HOME/.bash_profile
 
	function git_safety {
	  cmd=$1
	  shift
	  extra=""
	  if [ "$cmd" == "commit" ]; then
	    cmd=safetycommit
	  elif [ "$cmd" == "merge" ]; then
	    cmd=safetymerge
	  fi
	  "`which git`" "$cmd" "$@"
	}
	alias git=git_safety
 
	HERED
 
	# Echo instructions
	echo !!! IN ALL OF YOUR SHELL WINDOWS/TABS, SOURCE ~/.bash_profile \
	OR CLOSE AND RE-OPEN ALL OF YOUR SHELL WINDOWS/TABS !!!
else
	# Echo instructions
	echo ...success
fi