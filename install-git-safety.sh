#!/bin/bash
 
# Usage:
#
# $ sudo curl https://gist.github.com/Vaselinessa/8361013/raw/install-gitsafety.sh | bash
#
 
# Determine destination for downloaded git extensions
[[ -z "$dst" ]] && dst=$(which git-safetycommit)
[[ -z "$dst" ]] && dst=$1
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
chmod +x $dst/git-safety*
 
# Alias git in .bash_profile
read -r -d '' bash_alias <<- 'EOF'

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

EOF

if [[ ! -f $HOME/.bash_profile ]] || ! grep -q $bash_alias $HOME/.bash_profile; then
	echo "$bash_alias" >> $HOME/.bash_profile
fi
 
# Echo instructions
echo !!! SUCCESSFUL UPDATE/INSTALL
echo !!! IN ALL OF YOUR SHELL WINDOWS/TABS, SOURCE ~/.bash_profile \
OR CLOSE AND RE-OPEN ALL OF YOUR SHELL WINDOWS/TABS !!!