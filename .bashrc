# .bashrc

if [ -f /etc/bashrc ];
then
    . /etc/bashrc
fi

# User specific environment

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
      PATH="$HOME/.local/bin:$HOME/bin:$HOME/Applications/STM32CubeMX:$HOME/Applications/STM32CubeProgrammer/bin:$HOME/Applications/intelFPGA_lite/20.1/quartus/bin:$PATH"
      # :$HOME/Applications/arm-gnu-toolchain-12.2.rel1-x86_64-arm-none-eabi/bin
fi

export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:

# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

#
# ~/.bashrc
#

# ---- PS1 ----
# export PS1="\W \[\e[0;34m\]>\[\e[0;37m\] " #mnml
export PS1="\W:\\$ \[$(tput sgr0)\]"

# ---- my $PATH ----

#PATH=$PATH:$HOME/.local/bin:$HOME/Bin/scripts
#export PATH

# ---- swap caps and escape ---- (gives warning on wayland)
# /usr/bin/setxkbmap -option "caps:swapescape"

# --- vi mode ----
set -o vi

# ---- preferences ----
EDITOR=nvim
PAGER=less
# ---- aliases ----

# fix sudo for aliases
alias sudo='sudo '
alias please='sudo'

# I'm a fedora man now, "tips fedora" m'lady
#alias pacman='pacman --color=auto'
#alias yay='yay --color=auto'
alias update='sudo dnf update --color auto -y; flatpak update -y'


# laziness
alias p='pwd'
alias n='nnn -C -e'
alias nn='nnn -C -e'
alias nnn='nnn -C -e'
alias q='exit'
alias vim='nvim'
alias v='nvim'

# shortcuts (unused atm)
alias esp="cd ~/Documents/Tuks/2023/ESP411"
alias epr="cd ~/Documents/Tuks/2023/EPR400"

alias o='xdg-open'
# save deleter
alias rm='trash'

# youtube downloaders
alias yt-dlv="yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' --prefer-free-formats"
alias yt-mp3='yt-dlp --extract-audio --audio-format mp3'

# shutdown and logout
alias logout='sudo loginctl terminate-user cheese'
alias off='sudo systemctl poweroff'

# screen recording no sound
alias obs='ffmpeg -video_size 1280x800 -framerate 60 -f x11grab -i :0.0+0,0 ~/Videos/recordings/out.mkv'

# ---- fix trash java fonts ----
# export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel ${_JAVA_OPTIONS}"
JAVA_FONTS=/usr/share/fonts/TTF

# ---- increase bash history (unlimitied) ----
HISTFILESIZE=-1
HISTSIZE=-1

# ---- fix qt styling ----
# export QT_STYLE_OVERRIDE=gtk

# ---- nnn conifg ----
export LC_COLLATE="C"
export NNN_DE_FILE_MANAGER=nautilus
export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
export NNN_FALLBACK_OPENER=xdg-open
export NNN_COLORS='1234'

# ---- cleanup ----
export LESSHISTFILE=-
export XDG_CONFIG_HOME="$HOME"/.config/
export XDG_CACHE_HOME="$HOME"/.cache/

# ---- ImageMagick PDF fix ----
# MAGICK_CONFIGURE_PATH=$XDG_CONFIG_HOME/ImageMagick

# quartus jank
# export GTK_PATH=/usr/lib64/gtk3.0/
# export GTK_THEME=adw-gtk3-dark quartus

# colors
alias ls='lsd'
alias l='ls -l -X --group-directories-first '
alias la='ls -a  -X --group-directories-first '
alias lla='ls -la  -X --group-directories-first '
alias lt='ls -X --group-directories-first --tree --depth 2'

# alias ls='ls --color=auto'
# alias ll='ls -lh --color=auto'
# alias l1='ls -1 --color=auto'
# alias la='ls -A --color=auto'

alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias dnf='dnf --color=auto'

# colors for less
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s" # enables syntax highlighting in less (install source-highlight packge)
export LESS='-R ' # not sure

export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

export STDERRED_ESC_CODE=$(echo -e "\e[1;31m")

export GREP_COLORS='ms=1;37:mc=1;37:sl=:cx=:fn=1;33:ln=1;36:bn=1;35:se=1;30'

# eval 'dircolors -b ~/.dircolors' > /dev/null
LS_COLORS='rs=0:di=01;32:ln=01;36:mh=00:pi=0;35:so=0;35:do=0;35:bd=33;01:cd=33;01:or=30;01:mi=00:su=0;34:sg=0;34:ca=0;34:tw=32:ow=32:st=32:ex=01;35:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=0;35:*.jpeg=0;35:*.mjpg=0;35:*.mjpeg=0;35:*.gif=0;35:*.bmp=0;35:*.pbm=0;35:*.pgm=0;35:*.ppm=0;35:*.tga=0;35:*.xbm=0;35:*.xpm=0;35:*.tif=0;35:*.tiff=0;35:*.png=0;35:*.svg=0;35:*.svgz=0;35:*.mng=0;35:*.pcx=0;35:*.mov=0;35:*.mpg=0;35:*.mpeg=0;35:*.m2v=0;35:*.mkv=0;35:*.webm=0;35:*.webp=0;35:*.ogm=0;35:*.mp4=0;35:*.m4v=0;35:*.mp4v=0;35:*.vob=0;35:*.qt=0;35:*.nuv=0;35:*.wmv=0;35:*.asf=0;35:*.rm=0;35:*.rmvb=0;35:*.flc=0;35:*.avi=0;35:*.fli=0;35:*.flv=0;35:*.gl=0;35:*.dl=0;35:*.xcf=0;35:*.xwd=0;35:*.yuv=0;35:*.cgm=0;35:*.emf=0;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

# man pages colors
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# quartus shenanigans
export QSYS_ROOTDIR="/home/cheese/Applications/intelFPGA_lite/20.1/quartus/sopc_builder/bin"
export OCTAVE_EXECUTABLE="/bin/octave"

# nvidia shenanigans
LIBVA_DRIVER_NAME=nvidia
MOZ_DISABLE_RDD_SANDBOX=1
EGL_PLATFORM=wayland

# fix borked electron apps on wayland
# alias code='flatpak run com.visualstudio.code --enable-features=Vulkan,UseOzonePlatform --ozone-platform=wayland'
# alias discord='flatpak run com.discordapp.Discord --use-gl=desktop'

# rust shenanigans
. "$HOME/.cargo/env"
#

# pandoc shenanigans
eval "$(pandoc --bash-completion)"

# starships were meant to fly
eval "$(starship init bash)"
bind 'set completion-ignore-case on'
