## Install ##

1. First, run the installer script:

	# Will install to $destination if provided. Else, will install to location of
	# current install. If no current install exists, will install to
	# /usr/local/bin/.

	$ [sudo] curl https://raw.githubusercontent.com/Vaselinessa/git-safety/master/install-git-safety.sh | bash [-s destination]

2.a. Then to make this active for a particular git project:

	$ cd [my_app_dir] && git config ext.gitsafety true

2.b. Alternatively, to make this active for all git projects:

	$ git config --global ext.gitsafety true

3. After installation, be sure to source your <code>.bash_profile</code> in all open shells or else close and reopen all of your shells.

### Verifying your installation ###

If you specify a destination when you run the install command, make sure that
destination is on your path or that you have symlinks on your path which point
to the individual extension files (only the ones that begin 'git-' and have no
file extension).

After installation, run <code>which git-safetycommit</code>. If the output is
different than where you intended to install these extensions, then you may
have multiple installations on your computer. Just remove existing
installations until <code>which git-safetycommit</code> outputs the expected
location.

## Update ##

Same as install.
