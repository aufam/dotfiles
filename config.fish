# curl -fLo ~/.config/fish/config.fish --create-dirs https://raw.githubusercontent.com/aufam/configs/main/config.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# sudo apt install bat exa
alias cat batcat
alias ls 'exa --group-directories-first'
alias la 'exa -a --group-directories-first'
alias ll 'exa -l --group-directories-first'
alias lt 'exa -T --group-directories-first'

# bobthefish theme
set -g fish_prompt_pwd_dir_length 0
set -g theme_newline_cursor yes
set -g theme_newline_prompt "↪ " 
set -g theme_date_format +%T 
