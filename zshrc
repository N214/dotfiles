export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export AWS_PAGER=""
# add pg utils to path without installing the whole pg
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# OS specific config
case "$OSTYPE" in
  darwin*)
    alias ls="gls --color"
    alias nodev="/opt/homebrew/bin/n"

    # homebrew path
    export PATH="/usr/local/sbin:${PATH}"
    export PATH="/opt/homebrew/bin:${PATH}"
    export PATH="/Users/$USER/miniconda3/bin:${PATH}"

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/${USER}/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
        export CONDA_AUTO_ACTIVATE_BASE=true
    else
        if [ -f "/Users/${USER}/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/${USER}/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/${USER}miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    # autojump config

    [[ -s /Users/n214/.autojump/etc/profile.d/autojump.sh ]] && source /Users/n214/.autojump/etc/profile.d/autojump.sh
    autoload -U compinit && compinit -u

    ######################################
    #               go                   #
    ######################################

    export GOPATH="${HOME}/go"
    export GOROOT="$(brew --prefix golang)/libexec"

    # Google Cloud SDK.
    if [ -f "/Users/${USER}/Downloads/google-cloud-sdk/path.zsh.inc" ]; then . "/Users/${USER}/Downloads/google-cloud-sdk/path.zsh.inc"; fi
    if [ -f "/Users/${USER}/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then . "/Users/${USER}/Downloads/google-cloud-sdk/completion.zsh.inc"; fi

    # pnpm
    export PNPM_HOME="${HOME}/Library/pnpm"
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
    # pnpm end
    # NVM 
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

    # direnv
    eval "$(direnv hook zsh)"

    # bun completions
    [ -s "/Users/n214/.bun/_bun" ] && source "/Users/n214/.bun/_bun"

    # bun
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"

  ;;
  linux*)
    alias ls="ls --color"
    # pnpm
    export PNPM_HOME="${HOME}/.local/share/pnpm"
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
    # pnpm end

  ;;
esac

# ZSH config
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  docker
  docker-compose
  sudo
  last-working-dir
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-fzf-history-search
  kubectl
  virtualenv
  #tmux
  )

source $ZSH/oh-my-zsh.sh


# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


# aliases
alias nz="nvim ~/.zshrc"
alias nn="nvim ~/.config/nvim/init.vim"
alias nv=nvim
alias sz="source ~/.zshrc && echo 'zshrc sourced'"
alias d=docker
alias k=kubectl
alias t="tmux -2"
alias ta="tmux -2 a"
alias r="ranger"
alias rg="rg --vimgrep --color ansi"
alias sr="sudo ranger"
alias mkd="mkdir -pv"
alias nt="nvim ~/.tmux.conf"

alias shutdown='sudo shutdown now'
alias restart='sudo restart now'
alias server='python3 -m http.server' # optional arg: port (defaults to 8000)
alias kd="kubectl describe"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias tf="terraform"
alias fzfcl="export FZF_DEFAULT_COMMAND='fd .'"   # restore fzf default options ('fzf clear')
alias fzf-="export FZF_DEFAULT_COMMAND='fd . $HOME'"   # reinstate fzf custom options ('fzf-' as in 'cd -' as in 'back to where I was')

# LS_COLORS for vivid, need vivid installed
export LS_COLORS="$(vivid -m 8-bit generate molokai)"


######################################
#               nnn                  #
######################################

export VISUAL=ewrap
export NNN_OPENER="/home/${USER}/.config/nnn/plugins/nuke"
export NNN_SSHFS_OPTS='sshfs -o reconnect,idmap=user,cache_timeout=3600'
export NNN_BMS="c:$HOME/BD/Carrefour/;h:$HOME;d:$HOME/Downloads/"
export GUI=1
export NNN_FIFO=/tmp/nnn.fifo
n () 
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="$HOME/.config/nnn/.lastd"
    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
        # This will create a fifo where all nnn selections will be written to
    NNN_FIFO="$(mktemp -u)"
    export NNN_FIFO
    (umask 077; mkfifo "$NNN_FIFO")

    preview_cmd="${HOME}/.config/nnn/preview.sh"
    # Use `tmux` split as preview
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef
    export EDITOR=nvim
    export PAGER='less -Ri'
    export VISUAL=ewrap
    export NNN_PLUG='f:fzcd;o:fzopen;p:mocplay;d:diffs;t:treeview;m:mounts;v:preview-tui'
    export NNN_FIFO=/tmp/nnn.fifo
    export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"
    export NNN_SSHFS_OPTS='sshfs -o reconnect,idmap=user,cache_timeout=3600'
    export GUI=1
    export NNN_COLORS='#55555555'

    if [ -e "${TMUX%%,*}" ]; then
        tmux split-window -e "NNN_FIFO=$NNN_FIFO" -dh "$preview_cmd"
    else
        echo "unable to open preview, please install tmux or xterm"
    fi
    nnn -deEFnQruxPa "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
    rm -f "$NNN_FIFO"
}


######################################
#               FZF                  #
######################################

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd -d 10 -pai -HL . $HOME"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
#export FZF_
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_TRIGGER='~~'
export FZF_COMPLETION_OPTS='+c -x'


# Open a file with emc
#open_with_fzf() { fd -t f -H -I -E .git/ -E node_modules/ | fzf -m --preview="xdg-mime query default {}" | xargs -ro emacsclient --create-frame -n 2>/dev/null }
open_with_fzf() { fd -t f -H -I -E .git/ -E node_modules/ | fzf -m --preview="bat  --style=numbers --color=always {}" | xargs nvim }

# Quick cd
cd_with_fzf() {
    cd $HOME && cd "$(fd -t d -E .git/ -E node_modules/ | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window right )"
}

# Clean
fv() {du -a . | awk '{ print $2 }' | fzf | xargs -r nvim;}
fh() {du -a ~/* | awk '{ print $2 }' | fzf | xargs -r nvim;}

C() {cp -v "$1" "$( du -a ~/Dropbox/* | awk '{ print $2 }' | fzf | sed "s|~|$HOME|")" ;}
R() {rm -rfv "$( du -a ~/Dropbox/* ~/Downloads | awk '{ print $2 }' | fzf | sed "s|~|$HOME|")" ;}


zle -N cd_with_fzf
zle -N open_with_fzf

bindkey -s '^f' 'cd_with_fzf \n'
bindkey -s '^o' 'open_with_fzf \n'

# Terraform completion ZSH
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# docker completion
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes


f() {
    # if no arguments passed, just lauch fzf
    if [ $# -eq 0 ]
    then
        fzf | sort
        return 0
    fi

    # Store the program
    program="$1"    


    # Remove first argument off the list
    shift

    # Store any option flags
    typeset -A options
    options="$@"

    # Store the arguments from fzf
    arguments=$(fzf --multi)

    # If no arguments passed (e.g. if Esc pressed), return to terminal
    if [ -z "${arguments}" ]; then
        return 1
    fi

    # Sanitise the command by putting single quotes around each argument, also
    # first put an extra single quote next to any pre-existing single quotes in
    # the raw argument. Put them all on one line.
    for arg in "${arguments[@]}"; do
        arguments=$(echo "$arg" | sed "s/'/''/g; s/.*/'&'/g; s/\n//g")
        echo $arguments
    done

    # If the program is on the GUI list, add a '&'
    if [[ "$program" =~ ^(nautilus|zathura|evince|vlc|eog|kolourpaint)$ ]]; then
        arguments="$arguments >> /dev/null 2>&1 &"
    fi

    # Write the shell's active history to ~/.bash_history.
    #history 
    #fc -AI

    # Add the command with the sanitised arguments to .bash_history
    echo $program $options $arguments >> ~/.zsh_history

    # Reload the ~/.bash_history into the shell's active history
    #history -r

    # execute the last command in history

    cmd="$program $options $arguments"
    eval "$cmd"
}

