# curl -fLo ~/.config/fish/config.fish --create-dirs https://raw.githubusercontent.com/aufam/configs/main/config.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# sudo apt install bat exa
alias cat batcat
alias ls exa
alias ll exa -l
