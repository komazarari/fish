fzf_key_bindings
function l --description alias\ l=rg\ --files\ --hidden\ --glob\ \"!.git/\*\"\ \|\ batcat\ \(fzf\ --preview\ \'batcat\ --style=numbers\ --color=always\ --line-range\ :\$LINES\ \{\}\'\)
  fzf --preview 'batcat --style=numbers --color=always --line-range :$LINES {}' | read -l result
  [ "$result" ]; and batcat $result
end

# Defined in - @ line 1
function bat --wraps=batcat --description 'alias bat=batcat'
  batcat  $argv;
end

function fzf-bcd-widget -d 'cd backwards'
  pwd | awk -v RS=/ '/\n/ {exit} {p=p $0 "/"; print p}' | tac | eval (__fzfcmd) +m --select-1 --exit-0 $FZF_BCD_OPTS | read -l result
  [ "$result" ]; and cd $result
  commandline -f repaint
end

function j -d 'jump z'
  __z -l 2>&1 | eval (__fzfcmd --height 40% --nth 2.. --reverse --inline-info +s --tac --query '${*##-* }')
end
