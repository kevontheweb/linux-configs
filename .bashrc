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


export PATH="$PATH:${HOME}/.config/nvim/lsps/"
export BROWSER="firefox"
export EDITOR="nvim"
export VISUAL="nvim"
export PATH="${PATH}:${HOME}/bin:${HOME}/Applications:${HOME}/Applications/JUCE/Projucer:${HOME}/.local/bin"
export PATH="$PATH:${HOME}/.config/nvim/lsps/"
export SYSTEMD_PAGER='less -R'
export TERMINAL="flatpak run org.wezfurlong.wezterm"

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

# settings
unset rc
set -o vi
bind -s 'set completion-ignore-case on'

# tab completion
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'


# ------- aliases --------
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
alias o=xdg-open
alias typst='$HOME/Applications/typst/target/release/typst'

# ----- rust alts -----
# alias grep='rg'
# alias find='fd'
# alias cat='bat'
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# # in your .bashrc/.zshrc/*rc
# alias bathelp='bat --plain --language=help'
# help() {
#     "$@" --help 2>&1 | bathelp
# }
# batdiff() {
#     git diff --name-only --relative --diff-filter=d | xargs bat --diff
# }

# shortcuts
alias esp='cd ~/Documents/Tuks/2023/ESP411/'
alias epr='cd ~/Documents/Tuks/2023/EPR400/'
alias epr-session='cd ~/Documents/Tuks/2023/EPR400/; nvim -S Session.vim'
alias rust='cd ~/Documents/Rust'
alias sites='cd ~/Documents/Web/Sites/'
# CDPATH="$CDPATH:~/Documents/Tuks/2023/ESP411/:~/Documents/Tuks/2023/EPR400/:~/Documents/Tuks/Textbooks/:~/Downloads/"

# my programs
alias socc='bash ~/Documents/Rust/scaling_and_offset_circuit_calculator/target/release/circuit_calculator'
alias bela='sudo sshfs -o allow_other root@192.168.7.2:/root/Bela/ /mnt/bela && cd /mnt/bela'

# history stuff
# shopt -s direxpand histappend
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTFILESIZE=-1
export HISTSIZE=-1
export HISTFILE="$XDG_STATE_HOME"/bash/history
# mkdir -p "$XDG_STATE_HOME"/bash

# ----- PS1 -----
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

export BAT_THEME="ansi"
export LC_ALL="C"

#------------------------------
# ShellFuncs
#------------------------------
# -- coloured manuals
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
# Get color support for 'less'
export LESS="--RAW-CONTROL-CHARS"

# Use colors for less, man, etc.
[[ -f ~/.LESS_TERMCAP ]] && . ~/.LESS_TERMCAP


#------------------------------
# home directory cleanup
#------------------------------
# set xdg directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_VIDEOS_DIR="$HOME/Videos"
# mkdir -p $XDG_CONFIG_HOME
# mkdir -p $XDG_CACHE_HOME
# mkdir -p $XDG_DATA_HOME
# mkdir -p $XDG_STATE_HOME
# mkdir -p $XDG_DESKTOP_DIR
# mkdir -p $XDG_PUBLICSHARE_DIR
# mkdir -p $XDG_DOWNLOAD_DIR
# mkdir -p $XDG_TEMPLATES_DIR
# mkdir -p $XDG_DOCUMENTS_DIR
# mkdir -p $XDG_MUSIC_DIR
# mkdir -p $XDG_PICTURES_DIR
# mkdir -p $XDG_VIDEOS_DIR

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
