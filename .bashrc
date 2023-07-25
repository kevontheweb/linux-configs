# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER='less -R'
# export TERMINAL="flatpak run com.raggesilver.BlackBox"
export EDITOR="nvim"
# export VISUAL="nvim"


# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

set -o vi

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

alias please='sudo '
alias q='exit'
alias :q='exit'
alias ls='ls --color -1 --group-directories-first '
alias ll='ls -vAFlh'
alias la='ls -1A'
alias lt='tree -L 2'
alias ..='cd ..;pwd'
alias ...='cd ../..;pwd'
alias ....='cd ../../..;pwd'
alias c='clear'
alias h='history'
alias tree='tree --dirsfirst -F'
alias mkdir='mkdir -p -v'
# alias rm='trash-rm'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias grep='grep --color=auto'
alias space='du -S | sort -n -r | less'
alias big-files='du -S | sort -n -r | head -n 10'
alias df='df -h'
alias du='du -h'
alias fetch='fastfetch'
alias less='less -r'
alias typst='$HOME/Applications/typst/target/release/typst'
# rust alts
alias grep='rg'
alias find='fd'
alias cat='bat'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# in your .bashrc/.zshrc/*rc
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}
batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

# shortcuts
alias esp='cd ~/Documents/Tuks/2023/ESP411/'
alias epr='cd ~/Documents/Tuks/2023/EPR400/'
alias rust='cd ~/Documents/Rust'
# CDPATH="$CDPATH:~/Documents/Tuks/2023/ESP411/:~/Documents/Tuks/2023/EPR400/:~/Documents/Tuks/Textbooks/:~/Downloads/"

# my programs
# alias socc='bash ~/Documents/Rust/scaling_and_offset_circuit_calculator/target/release/circuit_calculator'

# history stuff
# shopt -s direxpand histappend
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTFILESIZE=-1
export HISTSIZE=-1
export HISTFILE="$XDG_STATE_HOME"/bash/history
mkdir -p "$XDG_STATE_HOME"/bash

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\[\e[32m\]\@\[\e[m\] : \w \n\[\e[36m\]\u\[\e[m\]@\[\e[35m\]\h\[\e[m\] \[\e[34m\]\`parse_git_branch\`\[\e[m\] \\$ -> "

# clean up home directory
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

export BAT_THEME="ansi"

. "$HOME/.cargo/env"

alias o=xdg-open


export BUNDLE_PATH=~/.gems

function newlb(){
	date=$(eval date '+%d_%m_%Y')
	cp ~/Templates/lab_book_xx_0x_2023.md ~/Documents/Tuks/2023/EPR400/lab_book/lab_book_${date}.md
}

export LC_ALL="C"
