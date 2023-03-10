export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export AWS_PAGER=""

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?

RPROMPT="%{$fg[white]%}[%D{%f/%m/%y}|%@]"
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
  #tmux
  )

source $ZSH/oh-my-zsh.sh

# autojump config

[[ -s /Users/n214/.autojump/etc/profile.d/autojump.sh ]] && source /Users/n214/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

# Antigen config
#source ~/.antigen.zsh
#antigen bundle thewtex/tmux-mem-cpu-load


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias nz="nvim ~/.zshrc"
alias nn="nvim ~/.config/nvim/init.vim"
#alias n="nnn -e"
alias nv=nvim
alias sz="source ~/.zshrc && echo 'zshrc sourced'"
alias d=docker
alias k=kubectl
alias t="tmux -2"
alias ta="tmux -2 a"
alias r="ranger"
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

# restore fzf default options ('fzf clear')
alias fzfcl="export FZF_DEFAULT_COMMAND='fd .'"

# reinstate fzf custom options ('fzf-' as in 'cd -' as in 'back to where I was')
alias fzf-="export FZF_DEFAULT_COMMAND='fd . $HOME'"


# Export path if mac or linux
if [ "$(uname -s)" = "Darwin" ]; then
  do_mac_stuff() {
    echo "Hi From Mac"
  }

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

elif [ "$(uname -s)" = "Linux" ]; then
  do_linux_stuff() {
    echo "Hi from Linux"
  }

  # Python on Linux
  export PATH="${HOME}/.local/bin:${PATH}"
fi



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

    nnn -deEFnQruxPa "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
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
open_with_fzf() { fd -t f -H -I -E .git/ -E node_modules/ | fzf -m --preview="xdg-mime query default {}" | xargs xdg-mime query default }

# Quick cd
cd_with_fzf() {
    cd $HOME && cd "$(fd -t d -E .git/ -E node_modules/ | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window right )"
}

fv() {du -a ~/Dropbox/* | awk '{print $2}' | fzf | xargs -r nvim;}

# fC() {du -a ~/Downloads ~/.config/* | awk '{print $2}' | fzf | xargs -r nvim;}

fh() {du -a ~/* | awk '{print $2}' | fzf | xargs -r nvim;}
C() {cp -v "$1" "$(du -a ~/Dropbox/* | awk '{print $2}' | fzf | sed "s|~|$HOME|")" ;}
R() {rm -rfv "$(du -a ~/Dropbox/* ~/Downloads | awk '{print $2}' | fzf | sed "s|~|$HOME|")" ;}


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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/{$USER}/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/{$USER}/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/{$USER}/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/{$USER}/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
