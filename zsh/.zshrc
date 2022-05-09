# Load zplug.
git clone https://github.com/zplug/zplug ~/.zplug > /dev/null 2>&1 || true
source ~/.zplug/init.zsh

# Load the home-manager PATH.
if [ -x "$(command -v home-manager)" ]; then
	export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
fi

# Configure the ZSH history.
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Allow interactive comments.
setopt interactive_comments

# Disable case sensitivity in autocompletion.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# Load colors.
autoload -U colors && colors

# Enable syntax highlighting and checking.
zplug "zsh-users/zsh-syntax-highlighting"

# Configure the tools for history substring searching.
zplug "zsh-users/zsh-history-substring-search" 
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Set a custom prompt.
#setopt PROMPT_SUBST
#setprompt() {
#    setpromptgit() {
#	if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
#	    echo " %{$fg[green]%}+$(git status | grep 'new file:' | wc -l)%{$reset_color%}/%{$fg[red]%}-$(git status | grep 'modified:' | wc -l)%{$reset_color%}"
#	fi
#    }
#    
#    export PROMPT="%{$fg[cyan]%}>> %{$reset_color%}"
#    export RPROMPT='%{$fg[blue]%}${PWD##*/}$(setpromptgit)'
#}
#setprompt

# Load the Typewritten prompt.
git clone https://github.com/reobin/typewritten.git "$HOME/.zsh/typewritten" > /dev/null 2>&1 || true
fpath+=$HOME/.zsh/typewritten
autoload -U promptinit; promptinit
prompt typewritten

# Set the aliases for existing binutils.
alias ls="ls --color=auto"

# Find the Sudo or Sudo-like command.
if [ -x "$(command -v doas)" ]; then
     export SUDO="doas"
elif [ -x "$(command -v sudo)" ]; then
     export SUDO="sudo"
else
     export SUDO="su -c"
fi

# Alias shortcuts for Nix and Home Manager.
alias ns="nix-channel --update && $SUDO nixos-rebuild switch"
alias nu="nix-channel --update"
alias nhs="nix-channel --update && home-manager switch"
alias nc="nix-collect-garbage -d && nix-store --gc"

# Alias specific shortcuts for Arch.
if [ -x "$(command -v paru)" ]; then
    export ARCHFRONTEND="paru"
elif [ -x "$(command -v yay)" ]; then
    export ARCHFRONTEND="yay"
else
    export ARCHFRONTEND="$SUDO pacman"
fi
alias pi="$ARCHFRONTEND -S"
alias pr="$ARCHFRONTEND -Rcns"
alias pu="$ARCHFRONTEND -Syu"
alias prfm="sudo reflector -f 5 --country 'United States' --protocol https --sort rate --save /etc/pacman.d/mirrorlist"

# Alias specific shortcuts for the worst distro.
if [ -x "$(command -v nala)" ]; then
    export DEBIANFRONTEND="$SUDO nala"
else
    export DEBIANFRONTEND="$SUDO apt"
fi
alias ai="$DEBIANFRONTEND update && $DEBIANFRONTEND install"
alias ar="$DEBIANFRONTEND purge --auto-remove"
alias au="$DEBIANFRONTEND update && $DEBIANFRONTEND upgrade"

# Alias specific shortcuts for DNF and Zypper.
alias di="$SUDO dnf install"
alias dr="$SUDO dnf remove"
alias du="$SUDO dnf update"
alias zi="$SUDO zypper in"
alias zr="$SUDO zypper rm"
alias zu="$SUDO zypper dup"

# Instantiate zplug.
if zplug check || zplug install; then
    zplug load
fi
