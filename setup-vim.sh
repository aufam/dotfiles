# curl -s https://raw.githubusercontent.com/aufam/dotfiles/main/setup-vim.sh | bash

sudo apt update
sudo apt install -y vim

if [ ! -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

curl https://raw.githubusercontent.com/aufam/dotfiles/main/.vimrc -o ~/.vimrc
