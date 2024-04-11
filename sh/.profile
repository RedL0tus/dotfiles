export PATH="${HOME}/.local/bin:$PATH";

function test_command {
	command -v $1 &> /dev/null;
}

# direnv
eval "$(direnv hook bash)";

# year progress
"${HOME}/.local/bin/year_progress";

# GPG Agent
if [ -f "${HOME}/.gnupg/gpg-agent.conf" ] || \
		! test_command gpgconf || \
		! test_command gpg-agent; then
	gpgconf --launch gpg-agent;
	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket);
fi
