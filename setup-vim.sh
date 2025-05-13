# curl -s https://raw.githubusercontent.com/aufam/dotfiles/main/setup-vim.sh | bash

sudo apt update
sudo apt install -y vim

curl https://raw.githubusercontent.com/aufam/dotfiles/main/.vimrc -o ~/.vimrc
