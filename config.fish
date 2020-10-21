# status --is-interactive; and source (rbenv init - | grep -v 'rbenv rehash' |psub)
# status --is-interactive; and source (nodenv init - | grep -v 'nodenv rehash' |psub)

# export LSCOLORS=gxfxcxdxbxegedabagacad

# # install fisher
# if not functions -q fisher
#     set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
#     curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
#     fish -c fisher
# end

# https://github.com/rafaelrinaldi/pure
set pure_color_current_folder $pure_color_cyan
set pure_color_blue (set_color brblue)

set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH
# set -x DOCKER_HOST tcp://localhost:2375
# set -x RUBYOPT '-w'

# for WSL
# set -x BROWSER 'wslview'
# umask 22

# # keychain
# if status --is-interactive
#     if not pidof ssh-agent > /dev/null
#         keychain -q ~/.ssh/id_rsa
#     end
# end
# begin
#     set -l HOSTNAME (hostname)
#     if test -f ~/.keychain/$HOSTNAME-fish
#         source ~/.keychain/$HOSTNAME-fish
#     end
# end

alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias k='kubectl'

set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --glob "!.git/*"'
set -x FZF_CTRL_T_COMMAND "command rg --files --hidden --glob \"!.git/*\" \$dir | sed '1d; s#^\./##'"

# aws
test -x (which aws_completer); and complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.fish.inc" ]; . "$HOME/google-cloud-sdk/path.fish.inc"; end
