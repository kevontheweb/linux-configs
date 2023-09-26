# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
setopt CORRECT

# Customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#------------------------------
# Variables
#------------------------------
export BROWSER="firefox"
export EDITOR="nvim"
export PATH="${PATH}:${HOME}/bin:${HOME}/Applications:${HOME}/Applications/JUCE/Projucer:${HOME}/.local/bin"
export PATH="$PATH:${HOME}/.config/nvim/lsps/"
# export PAGER="nvim -R -c AnsiEsc -"
export PAGER="less"
export MANPAGER="less"


#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# Alias stuff
#------------------------------
alias o=xdg-open
alias please='sudo '
alias sdi='sudo dnf install'
alias sdu='sudo dnf update'
alias sdr='sudo dnf remove'
alias fu='flatpak update'
alias q='exit'
alias :q='exit'

# Ensure exa is available
if (( ! ${+commands[exa]} )); then
	alias ls='ls --color -1 --group-directories-first '
	alias ll='ls -vAlh'
	alias la='ls -1A'
	alias lt='tree -L 2'
	alias tree='tree --dirsfirst -F'
else
	export EXA_COLORS='da=1;34:gm=1;34'

	alias ls='exa --git --group-directories-first'
	alias la='ls -a'
	alias ll='ls -lFh'  
	alias lla='ll -lFah' 
	alias lt='ls -T -L 3'
fi

alias c='clear'
alias h='history'

alias mkdir='mkdir -p -v'
# alias rm='trash-rm'
# alias v='nvim'
# alias vi='nvim'
# alias vim='nvim'

alias grep='grep --color=auto'

alias space='du -S | sort -n -r | less'
alias big-files='du -S | sort -n -r | head -n 10'
alias df='df -h'
alias du='du -h'
alias fetch='fastfetch'
alias less='less -r'
alias typst='$HOME/Applications/typst/target/release/typst'
#
# rust alts
# alias grep='rg'
# alias find='fd'
# alias cat='bat'
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export BAT_THEME="ansi"
# # in your .bashrc/.zshrc/*rc
# alias bathelp='bat --plain --language=help'
# help() {
#     "$@" --help 2>&1 | bathelp
# }
# batdiff() {
#     git diff --name-only --relative --diff-filter=d | xargs bat --diff
# }
#
# shortcuts
alias esp='cd ~/Documents/Tuks/2023/ESP411/'
alias epr-session='cd ~/Documents/Tuks/2023/EPR400/; nvim -S Session.vim'
alias epr='cd ~/Documents/Tuks/2023/EPR400/'
alias code='cd ~/Documents/Tuks/2023/EPR400/code'
alias rust='cd ~/Documents/Rust'
alias sites='cd ~/Documents/Web/Sites/'
# CDPATH="$CDPATH:~/Documents/Tuks/2023/ESP411/:~/Documents/Tuks/2023/EPR400/:~/Documents/Tuks/Textbooks/:~/Downloads/"

# my programs
# alias socc='bash ~/Documents/Rust/scaling_and_offset_circuit_calculator/target/release/circuit_calculator'
alias bela='sudo sshfs -o allow_other root@192.168.7.2:/root/Bela/ /mnt/bela && cd /mnt/bela'

#------------------------------
# ShellFuncs
#------------------------------
# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

#------------------------------
# home directory cleanup
#------------------------------
# set xdg directories
export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p $XDG_CONFIG_HOME
export XDG_CACHE_HOME="$HOME/.cache"
mkdir -p $XDG_CACHE_HOME
export XDG_DATA_HOME="$HOME/.local/share"
mkdir -p $XDG_DATA_HOME
export XDG_STATE_HOME="$HOME/.local/state"
mkdir -p $XDG_STATE_HOME
export XDG_DESKTOP_DIR="$HOME/Desktop"
mkdir -p $XDG_DESKTOP_DIR
export XDG_PUBLICSHARE_DIR="$HOME/Public"
mkdir -p $XDG_PUBLICSHARE_DIR
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
mkdir -p $XDG_DOWNLOAD_DIR
export XDG_TEMPLATES_DIR="$HOME/Templates"
mkdir -p $XDG_TEMPLATES_DIR
export XDG_DOCUMENTS_DIR="$HOME/Documents"
mkdir -p $XDG_DOCUMENTS_DIR
export XDG_MUSIC_DIR="$HOME/Music"
mkdir -p $XDG_MUSIC_DIR
export XDG_PICTURES_DIR="$HOME/Pictures"
mkdir -p $XDG_PICTURES_DIR
export XDG_VIDEOS_DIR="$HOME/Videos"
mkdir -p $XDG_VIDEOS_DIR

# node
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
mkdir -p $NPM_CONFIG_USERCONFIG

# wget
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
touch $WGETRC
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
mkdir -p $XDG_CACHE_HOME/wget-hsts

# octave
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave-hsts"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"

# # possibly need to add this to $XDG_CONFIG_HOME/octave/octaverc
# source /usr/share/octave/site/m/startup/octaverc;
# pkg prefix ~/.local/share/octave/packages ~/.local/share/octave/packages;
# pkg local_list /home/<your username>/.local/share/octave/octave_packages;

# java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
mkdir -p $XDG_CONFIG_HOME/java

#colored man pages with less
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
export GROFF_NO_SGR=1         # For Konsole and Gnome-terminal

# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc.
[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP


#------------------------------
# functions
#------------------------------
function newlb(){
	DATE=$(eval date '+%d_%m_%Y')
	FOLDER=$(eval date '+%m_%B' | tr A-Z a-z )
	mkdir -p $HOME/Documents/Tuks/2023/EPR400/lab_book/${FOLDER}/ 
	FILE_PATH="${HOME}/Documents/Tuks/2023/EPR400/lab_book/${FOLDER}/lab_book_${DATE}.md"
	touch ${FILE_PATH}
	echo "---" >> ${FILE_PATH}
	echo "author: Kevin Nel" >> ${FILE_PATH}
	echo "title: \"Lab Book Entry\"" >> ${FILE_PATH}
	echo "date: $(eval date "+%d-%m-%Y")" >> ${FILE_PATH}
	echo "bibliography: ../project.bib" >> ${FILE_PATH}
	echo "csl: ../ieee.csl" >> ${FILE_PATH}
	echo "---" >> ${FILE_PATH}
	cd $HOME/Documents/Tuks/2023/EPR400/lab_book/${FOLDER}/
	nvim ${FILE_PATH}
}



# stuff that gets added for me
. "$HOME/.cargo/env"

export BUNDLE_PATH=~/.gems


