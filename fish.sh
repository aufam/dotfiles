#!/bin/bash

fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fish -c "fisher install ilancosman/tide@v6"
fish -c "fisher install patrickf1/fzf.fish"
