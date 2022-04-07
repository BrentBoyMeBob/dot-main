# Install and load zplug.
if [ -d "~/.zplug" ]; then
    git clone https://github.com/zplug/zplug ~/.zplug
fi
source ~/.zplug/init.zsh

# Configure the ZSH history.
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Enable syntax highlighting and checking.
zplug "zsh-users/zsh-syntax-highlighting"

# Configure the tools for history substring searching.
zplug "zsh-users/zsh-history-substring-search" 
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Set the prompt.
setopt PROMPT_SUBST
setprompt() {
    setpromptgit() {
	if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
	    echo " +$(git status | grep 'new file:' | wc -l)/-$(git status | grep 'modified:' | wc -l)"
	fi
    }
    
    export PROMPT=">> "
    export RPROMPT='${PWD##*/}$(setpromptgit)'
}
setprompt

# Set the aliases for existing commands.
alias ls="ls --color=auto"

# Instantiate zplug.
if zplug check || zplug install; then
    zplug load
fi