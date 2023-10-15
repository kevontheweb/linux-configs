if status is-interactive
    # Commands to run in interactive sessions can go here
end

# source ~/.bash_aliases

set PATH $HOME/bin $HOME/Applications $HOME/.local/bin $HOME/.config/nvim/lsps/ $HOME/.cargo/bin $PATH
set EDITOR vim
set GIT_EDITOR $EDITOR
set BROWSER firefox

fish_vi_key_bindings

abbr please 'sudo '
abbr pls 'sudo '
abbr q 'exit'
abbr :q 'exit'
abbr ls 'ls --color -1 --group-directories-first '
abbr ll 'ls -vAFlh'
abbr la 'ls -1A'
abbr lt 'tree -L 2'
abbr c 'clear'
abbr h 'history'
abbr tree 'tree --dirsfirst -F -L 3'
abbr mkdir 'mkdir -p -v'
abbr v 'nvim'
abbr vi 'nvim'
abbr vim 'nvim'
abbr grep 'grep --color=auto'
abbr space 'du -S | sort -n -r | less'
abbr big-files 'du -S | sort -n -r | head -n 10'
abbr df 'df -h'
abbr du 'du -h'
abbr fetch 'fastfetch'
abbr less 'less -r'
abbr o 'xdg-open'
abbr ds 'dnf search'
abbr sdu 'sudo dnf update'
abbr sdi 'sudo dnf install'
abbr sdr 'sudo dnf remove'
abbr fu 'flatpak update'
abbr ytx 'yt-dlp -x --audio-format mp3 --audio-quality best'

# shortcuts
abbr esp 'cd ~/Documents/Tuks/2023/ESP411/'
abbr epr 'cd ~/Documents/Tuks/2023/EPR400/'
abbr eprc 'cd ~/Documents/Tuks/2023/EPR400/code/cpp'
abbr rust 'cd ~/Documents/Rust'
abbr sites 'cd ~/Documents/Web/Sites/'

# my programs
abbr socc 'bash ~/Documents/Rust/scaling_and_offset_circuit_calculator/target/release/circuit_calculator'
abbr bela 'sudo sshfs -o allow_other root@192.168.7.2:/root/Bela/ /mnt/bela && cd /mnt/bela'
abbr mount_bela 'sudo sshfs -o allow_other root@192.168.7.2:/ /mnt/bela'
abbr ssh_bela 'sudo ssh 192.168.7.2 -l root'

set fish_prompt_pwd_dir_length 0

set BUNDLE_PATH ~/.gems


