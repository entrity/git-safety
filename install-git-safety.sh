#!/bin/bash
 
# Usage:
#
# $ sudo curl https://gist.github.com/Vaselinessa/8361013/raw/install-gitsafety.sh | bash
#
 
# Destination for downloaded git extensions
dst=
 
# If user is ROOT (sudo), install at usr/local/bin
if [[ "$(whoami)" == "root" ]]; then
	dst="/usr/local/bin"
else
	# If user is not ROOT (sudo), find earliest PATH directory which is writable for current user
	while IFS=':' read -ra DIRS; do
		for d in "${DIRS[@]}"; do
			if [[ -w $d ]]; then
				dst=$d
				break
			fi
		done
	done <<< $PATH
fi
 
if [[ -z "$dst" ]]; then
	echo "== ERROR: you have no write permissions to anything on your \$PATH. Please update your \$PATH variable OR use sudo and try again"
	exit 1
fi
 
echo Downloading git extensions
 
# Download extension files
wget https://gist.github.com/Vaselinessa/8361013/raw/git-safetymerge -O $dst/git-safetymerge
wget https://gist.github.com/Vaselinessa/8361013/raw/git-safetycommit -O $dst/git-safetycommit
 
# Make safety extensions executable
chmod +x $dst/git-safetymerge
chmod +x $dst/git-safetycommit
 
# Alias git in .bash_profile
cat << 'HERED' >> $HOME/.bash_profile
 
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