## Install ##

	# Will install to $destination if provided. Else, will install to location of
	# current install. If no current install exists, will install to
	# /usr/local/bin/.

	$ [sudo] curl https://raw.githubusercontent.com/Vaselinessa/git-safety/master/install-git-safety.sh | bash [-s destination]

	# To make this active for a particular git project:

	$ cd [my_app_dir] && git config ext.gitsafety true

	# To make this active for all git projects:

	$ git config --global ext.gitsafety true

## Update ##

Same as install.
