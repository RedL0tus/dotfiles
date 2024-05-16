# Load universal .profile
if [ -f "${HOME}/.profile" ]; then
	source "${HOME}/.profile";
fi

# Install and start OKC SSH agents
if ! test_command okc-ssh-agent; then
	pkg install okc-agents;
fi
export OKC_ENV="${PREFIX}/tmp/okc-agent.env";
if ! pgrep okc-ssh-agent > /dev/null; then
	okc-ssh-agent > "${OKC_ENV}";
fi
source "${OKC_ENV}" > /dev/null;
