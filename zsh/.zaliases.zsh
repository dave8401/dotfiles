alias tm="tmux new -A -s $(whoami)"
alias ga="git add ."
alias gc="git commit -m ${1}"
alias gd="git diff"
alias gdt="git difftool"
alias gmt="git mergetool"
alias gp="git push ${1} ${2}"
alias gco="git checkout ${1} ${2}"
alias gpl="git pull ${1} ${2}"
alias grb="git rebase ${1} ${2}"
alias gs="git status"
alias la="ls -al"
alias lf="ls -al | grep ${1}"
alias ls="ls -Gl"
alias zx="source ~/.zshrc"
alias zz="$EDITOR ~/.zshrc"
alias kr="defaults write -g ApplePressAndHoldEnabled -bool false"
alias knr="defaults write -g ApplePressAndHoldEnabled -bool true"
alias switch-keys="gpg-connect-agent \"scd serialno\" \"learn --force\" /bye"
alias flutter="fvm flutter"
alias pw="pass show -c"
alias pwo="pass otp show -c"
## eza
alias ls="eza --icons=always" # ls
alias ll='eza -lbF --git --icons=always' # list, size, type, git
alias llm='eza -lbF --git --icons=always --sort=modified' # long list, modified date sort
alias la='eza -lbhHigUmuSa --time-style=long-iso --git --icons=always' # all list
alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --icons=always' # all + extended list
alias lS='eza -1' # one column, just names
alias lt='eza --tree --level=2 --icons=always' # tree
alias fzf="fzf --cycle  --multi --bind 'tab:toggle-up,btab:toggle-down'"

alias ibrew='arch -x86_64 /usr/local/bin/brew'

alias init="initTPM && initApps";
alias initApps="cd ~/dotfiles/ && stow -t /Applications Applications";
alias initTPM="rm -rf ~/.tmux && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm";

# nvim
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
