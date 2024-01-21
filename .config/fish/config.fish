if status is-interactive
    # Commands to run in interactive sessions can go here
end

# source ~/.bash_aliases

set PATH $HOME/bin $HOME/Applications $HOME/.local/bin $HOME/.config/nvim/lsps/ $HOME/.cargo/bin $PATH
set EDITOR vim
set GIT_EDITOR $EDITOR
set BROWSER firefox

fish_vi_key_bindings
set fish_prompt_pwd_dir_length 0

source ~/.config/fish/abr.fish
source ~/.config/fish/colors.fish
source ~/.config/fish/motd.fish
source ~/.config/fish/functions/my_funcs.fish

set BUNDLE_PATH ~/.gems

