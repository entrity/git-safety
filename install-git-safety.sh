#!/bin/bash
 
# Usage:
#
#   $ [sudo] curl https://raw.githubusercontent.com/Vaselinessa/git-safety/master/install-git-safety.sh | bash [-s destination]
#
 
# Determine destination for downloaded git extensions
[[ -z "$dst" ]] && dst=$1
[[ -z "$dst" ]] && dst=$([[ ! -z "$(which git-safetycommit)" ]] && dirname $(which git-safetycommit) )
[[ -z "$dst" ]] && dst="/usr/local/bin"
if [[ ! -w $dst ]]; then
	fail "ERROR: you have no write permissions to $dst. Please use sudo and try again"
fi

# Download extension files
echo Downloading git extensions
dl_dir=https://raw2.github.com/Vaselinessa/git-safety/master
wget $dl_dir/git-safety-functions.sh -P $dst
wget $dl_dir/git-safetymerge -P $dst
wget $dl_dir/git-safetycommit -P $dst
 
# Make safety extensions executable
echo Setting chmod +x
chmod +x $dst/git-safety*
 
# Alias git in .bash_profile
read -r -d '' bash_alias <<- 'EOF'

# Start git-safety code
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
# End git-safety code
EOF

echo Adding alias to \$HOME/.bash_profile

if [[ -f $HOME/.bash_profile ]]; then
  sed -i.bak '/Start git-safety code/,/End git-safety code/d' $HOME/.bash_profile
fi
echo -e "$bash_alias" >> $HOME/.bash_profile
 
# Echo instructions
echo !!! SUCCESSFUL UPDATE/INSTALL
echo !!! Please update your git aliases as necessary.
echo !!! IN ALL OF YOUR SHELL WINDOWS/TABS, SOURCE ~/.bash_profile \
OR CLOSE AND RE-OPEN ALL OF YOUR SHELL WINDOWS/TABS !!!