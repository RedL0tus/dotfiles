# Load device profiles
source /etc/profile;

# Zgen
if [ ! -d "${HOME}/.zgen" ]; then
	git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen";
fi

# Load zgen
source "${HOME}/.zgen/zgen.zsh";

# If the init script doesn't exist
if ! zgen saved; then

        # Prezto
        zgen prezto;

        # Theme
        zgen prezto prompt theme "nicoulaj";

        # Prezto Plugins
        zgen prezto git;
        zgen prezto command-not-found;
        zgen prezto syntax-highlighting;

        # Prezto settings
        zgen prezto "*:*" color "yes";

        # Other plugins
        zgen load chrissicool/zsh-256color;

        zgen load junegunn/fzf shell;

        zgen load unixorn/autoupdate-zgen;

        zgen load zsh-users/zsh-completions;
        zgen load zsh-users/zsh-apple-touchbar;
        zgen load zsh-users/zsh-autosuggestions;
        zgen load zsh-users/zsh-syntax-highlighting;
        zgen load zsh-users/zsh-history-substring-search;

        # Generate init script
        zgen save;

        # Reload zshrc
        source ~/.zgen/zgen.zsh;
fi

# Common overrides
source "${HOME}/.source";

# Misc
zstyle ':prezto:module:syntax-highlighting' color 'yes';
export ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc ${HOME}/.zshrc.local);

# TeX MF
export TEXMFHOME="${HOME}/.texmf";

# Local bin
export PATH="${HOME}/.local/bin:${PATH}";

# Direnv
if command -v direnv &> /dev/null; then
	eval "$(direnv hook zsh)";
fi

# V4L2 Switch Capture Card
function capture_switch {
	ffmpeg \
		-fflags nobuffer -f v4l2 -input_format mjpeg \
		-video_size 1280x720 -framerate 30 -i "${1}" \
		-f alsa -ac 2 -i "hw:${2},0" \
		-vcodec copy -acodec copy -f matroska - | \
	ffplay \
		-fflags nobuffer -i -;
}

# OPAM
if command -v opam &> /dev/null; then
	eval $(opam env);
fi

# Tab-rs
if [ -f "${HOME}/.local/share/tab/completion/zsh-history.zsh" ]; then
	source "${HOME}/.local/share/tab/completion/zsh-history.zsh";
fi

# Starship
eval "$(starship init zsh)";
