function fish_greeting
    neofetch
end

set -x PATH $PATH /usr/local/go/bin $HOME/go/bin
set -x CPM_SOURCE_CACHE $HOME/.cache/CPM
set -x CPPXX_CACHE $HOME/.cache/cppxx
set -x BAT_THEME gruvbox

# aliases
alias please 'echo sudo $history[1] && eval command sudo $history[1]'
alias ..     'cd ..'
alias ...    'cd ../..'
alias ....   'cd ../../..'
alias .....  'cd ../../../..'
alias vim    'NO_LAZY=ON nvim'

if type -q batcat; alias bat batcat; end
if type -q fd-find; alias fd fd-find; end

if type -q eza
    alias ls 'eza -g --group-directories-first'
    alias la 'eza -ga --group-directories-first'
    alias ll 'eza -gl --group-directories-first'
    alias lt 'eza -gT --group-directories-first'
    alias lla 'eza -gla --group-directories-first'
    alias llt 'eza -glT --group-directories-first'
    if not type -q tree; alias tree 'eza --tree --group-directories-first'; end
else if type -q exa
    alias ls 'exa -g --group-directories-first'
    alias la 'exa -ga --group-directories-first'
    alias ll 'exa -gl --group-directories-first'
    alias lt 'exa -gT --group-directories-first'
    alias lla 'exa -gla --group-directories-first'
    alias llt 'exa -glT --group-directories-first'
    if not type -q tree; alias tree 'exa --tree --group-directories-first'; end
else
    alias ls 'ls -g --color=auto'
    alias la 'ls -ga --color=auto'
    alias ll 'ls -gl --color=auto'
    alias lt 'ls -gR --color=auto'
    alias lla 'ls -gla --color=auto'
    alias llt 'ls -glR --color=auto'
end

# gemini
function gemini
    argparse 'x/xclip' 'v/verbose' 'l/long' -- $argv
    or return

    if set -q _flag_long
        set pre_prompt ""
    else
        set pre_prompt "answer shortly\n"
    end

    if set -q _flag_xclip
        set prompt "$pre_prompt$argv\n$(xclip -selection clipboard -o)"
    else
        set prompt "$pre_prompt$argv"
    end

    set api_url "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent"
    set prompt_json (echo $prompt | jq -Rsa .)
    if set -q _flag_verbose
        printf "prompt:\n$prompt\n\n"
        printf "response:\n"
    end

    curl -s "$api_url?key=$GEMINI_API_KEY" \
        -H "Content-Type: application/json" \
        -X POST \
        -d "{\"contents\":[{\"parts\":[{\"text\":$prompt_json}]}]}" \
        | jq -r '.candidates[0].content.parts[0].text // .error.message'
end

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

# user script
set -l script_dir (dirname (status -f))
set -l file_to_source "$script_dir/user-script.fish"
if test -f $file_to_source
    source $file_to_source
end
