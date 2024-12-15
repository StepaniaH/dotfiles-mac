# All environment variables

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"              # Zap Plugin Manager

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.docker/bin":$PATH
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export PATH="$HOME/.local/share/neovim/bin":$PATH
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export STARSHIP_CONFIG=~/.config/starship.toml           # Starship Config
eval "$(starship init zsh)"                              # Starship Init

HISTFILE=~/.zsh_hist                                     # Where to store zsh history

autoload -Uz compinit                                    # Load completion system
compinit                                                 # Initialise completion system
