# ~/.config/fish/config.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    neofetch
end

# aliases
alias cat batcat
alias ls 'eza --group-directories-first'
alias la 'eza -a --group-directories-first'
alias ll 'eza -l --group-directories-first'
alias lt 'eza -T --group-directories-first'
alias please 'echo sudo $history[1] && eval command sudo $history[1]'
alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."
alias ..... "cd ../../../.."

# CPM.cmake
set CPM_SOURCE_CACHE $HOME/.cache/CPM

# bobthefish theme
set -g fish_prompt_pwd_dir_length 0
set -g theme_newline_cursor yes
set -g theme_nerd_fonts yes
set -g theme_newline_prompt ">> "
set -g theme_date_format +%T

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
