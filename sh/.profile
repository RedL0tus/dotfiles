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

# Year Progress
if test_command bc && [ -z "${SOURCED_DOTFILES_SH_PROFILE}" ]; then
	"${HOME}/.local/bin/year_progress";
fi

# GPG Agent
if [ -f "${HOME}/.gnupg/gpg-agent.conf" ] && \
		test_command gpgconf && \
		test_command gpg-agent; then
	gpgconf --launch gpg-agent;
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket);
fi

export SOURCED_DOTFILES_SH_PROFILE=1;

# Detect distro ID
if [ -f "/etc/os-release" ]; then
	source "/etc/os-release";
fi

# if running bash on Debian
if [ -n "$BASH_VERSION" ] && { [ "x${ID}" == "xdebian" ] || [ "x${ID}" == "xubuntu" ]; }; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc";
	fi
fi

# GOPATH
if [ -d "${HOME}/Documents/GOPATH" ]; then
	export GOPATH="${HOME}/Documents/GOPATH";
fi
if [ -d "$GOPATH/bin" ]; then
	export PATH="${PATH}:${GOPATH}/bin";
fi

# Rustup
if [ -f "${HOME}/.cargo/env" ]; then
        source "${HOME}/.cargo/env"
fi
