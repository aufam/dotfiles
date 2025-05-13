# curl -s https://raw.githubusercontent.com/aufam/dotfiles/main/setup-rust.sh | bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo sh
rustup component add rust-analyzer rustfmt
