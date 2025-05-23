# ~/.config/fish/config.fish

if status is-interactive
  # Commands to run in interactive sessions can go here
  neofetch
end

set script_dir (dirname (status -f))
set file_to_source "$script_dir/user-script.fish"
if test -f $file_to_source
    source $file_to_source
end

# go
set -x PATH $PATH /usr/local/go/bin $HOME/go/bin

# nvim
set -x PATH $PATH $HOME/nvim-linux-x86_64/bin/

# CPM.cmake
set -x CPM_SOURCE_CACHE $HOME/.cache/CPM

# bat theme
set -x BAT_THEME gruvbox-dark

# aliases
alias bat batcat
alias ls 'exa --group-directories-first'
alias la 'exa -a --group-directories-first'
alias ll 'exa -l --group-directories-first'
alias lt 'exa -T --group-directories-first'
alias please 'echo sudo $history[1] && eval command sudo $history[1]'
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

# extract
function ex
  if test (count $argv) -eq 0
    echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|exe|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
  else
    for n in $argv
      if test -f "$n"
        switch "$n"
          case '*.tar.bz2' '*.tar.gz' '*.tar.xz' '*.tbz2' '*.tgz' '*.txz' '*.tar'
            tar xvf "$n"
          case '*.lzma'
            unlzma "$n"
          case '*.bz2'
            bunzip2 "$n"
          case '*.rar' '*.cbr'
            unrar x -ad "$n"
          case '*.gz'
            gunzip "$n"
          case '*.zip' '*.cbz' '*.epub'
            unzip "$n"
          case '*.z'
            uncompress "$n"
          case '*.7z' '*.arj' '*.cab' '*.cb7' '*.chm' '*.deb' '*.dmg' '*.iso' '*.lzh' '*.msi' '*.pkg' '*.rpm' '*.udf' '*.wim' '*.xar'
            7z x "$n"
          case '*.xz'
            unxz "$n"
          case '*.exe'
            cabextract "$n"
          case '*.cpio'
            cpio -id < "$n"
          case '*.ace' '*.cba'
            unace x "$n"
          case '*'
            echo "ex: '$n' - unknown archive method"
            return 1
        end
      else
        echo "'$n' - file does not exist"
        return 1
      end
    end
  end
end
