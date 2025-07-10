# fzf_key_bindings
function l --description alias\ l=rg\ --files\ --hidden\ --glob\ \"!.git/\*\"\ \|\ bat\ \(fzf\ --preview\ \'bat\ --style=numbers\ --color=always\ --line-range\ :\$LINES\ \{\}\'\)
  fzf --preview 'bat --style=numbers --color=always --line-range :$LINES {}' | read -l result
  [ "$result" ]; and bat --plain $result
end

function fzf-bcd-widget -d 'cd backwards'
  pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tac | eval (__fzfcmd) +m --select-1 --exit-0 $FZF_BCD_OPTS | read -l result
  [ "$result" ]; and cd $result
  commandline -f repaint
end

function j -d 'jump z'
  __z -l 2>&1 | eval (__fzfcmd --height 40% --nth 2.. --reverse --inline-info +s --tac --query '${*##-* }')
end
bind \cj j
bind \ej fzf-bcd-widget


function __myawsprofile -d 'insert profile'
    echo hoge
    set -l profopt
    cat ~/.aws/config | grep -o -P "\[profile\s+\K[\w-]+" | fzf | read select
    [ -n "$select" ]; and set profopt "--profile $select"
    commandline -it -- "$profopt"
    commandline -f repaint
end
bind \eP '__myawsprofile'
bind -M insert \eP '__myawsprofile'

function __fzfcmd
    set -q FZF_TMUX; or set FZF_TMUX 0
    set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
    if [ $FZF_TMUX -eq 1 ]
        echo "fzf-tmux -d$FZF_TMUX_HEIGHT"
    else
        echo "fzf"
    end
end

function fzf-file-widget -d 'Insert selected file(s) at cursor'
    set -l fzf_query (commandline --current-token)
    [ -n "$fzf_query" ]; and set fzf_options --query="$fzf_query"

    eval "$FZF_CTRL_T_COMMAND" | eval (__fzfcmd) -m --select-1 $fzf_options $FZF_CTRL_T_OPTS | while read -l r; set result $result $r; end

    if [ -z "$result" ]
        commandline -f repaint
        return
    else
        commandline -t ""
    end

    for i in $result
        commandline -it -- (string escape $i)
        commandline -it -- ' '
    end
    commandline -f repaint
end

bind \ct fzf-file-widget
bind -M insert \ct fzf-file-widget
