#!/bin/bash

# install NeoBundle"
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh;

# install required brew packages
brew tap homebrew/dupes
brew install cmake gawk git grep macvim reattach-to-user-namespace the_silver_searcher tmux vim watchman zsh zsh-completions dos2unix
brew install --HEAD tidy
brew link gawk

# install tmuxinator
sudo gem install tmuxinator

# install neovim package
pip3 install --user neovim

# install global npm packages
# Note: make sure node is installed before (install it via nvm)!
npm install -g bower coffee-script ember-cli ember-prerender express express-generator express-redis-cache grunt-cli gulp instant-markdown-d jshint jsxhint eslint mocha node-inspector nodemon nodev phantomjs

# install powerline-fonts
cd fonts && ./install.sh && cd ..
