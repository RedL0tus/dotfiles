# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc";
	fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH";
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH";
fi

function note {
	if [ -z "${DOTFILES_IGNORE_NOTES+x}" ]; then
		echo ">>> note: $1";
	fi
}

if [ -f "$HOME/.local_profile" ]; then
	. "$HOME/.local_profile";
else
	note "Creating empty ${HOME}/.local_profile";
	touch "$HOME/.local_profile";
fi

function test_command {
	command -v "$1" &> /dev/null;
	if [ "$?" -ne 0 ]; then
		note "command not found: $1";
		return 1;
	fi
}

# direnv
if test_command direnv; then
	eval "$(direnv hook bash)";
fi

# year progress
if test_command bc; then
	"${HOME}/.local/bin/year_progress";
fi

# GPG Agent
if [ -f "${HOME}/.gnupg/gpg-agent.conf" ] || \
		! test_command gpgconf || \
		! test_command gpg-agent; then
	gpgconf --launch gpg-agent;
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket);
fi
