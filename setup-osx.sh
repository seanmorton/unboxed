echo '============================================================> Installing Xcode CLI tools...'
xcode-select install

echo '============================================================> Installing homebrew & packages...'
brew install ag
brew install cowsay
brew install coreutils
brew install fortune
brew install gpg
brew install thefuck
brew install tmux
brew install vim
brew install watch
brew install zsh
brew cask install chromedriver
brew cask install iterm2
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

echo '============================================================> Setting up  SSH identity...'
ssh-keygen -t rsa -b 4096 -C "smorton517@gmail.com"
eval "$(ssh-agent -s)"
cat > ~/.ssh/configs << EOF
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
EOF
ssh-add -K ~/.ssh/id_rsa

echo '============================================================> Copying configuration from dotfiles...'
git clone git@github.com:seanmorton/dotfiles.git ~/.dotfiles
cp ~/.dotfiles/.agignore  ~/.agignore
cp ~/.dotfiles/.gitconfig  ~/.gitconfig
cp ~/.dotfiles/.gitignore  ~/.gitignore
cp ~/.dotfiles/.tmux.conf ~/.tmux.conf
cp ~/.dotfiles/.vimrc  ~/.vimrc
cp ~/.dotfiles/.zshrc ~/.zshrc
mkdir -p ~/.config
cp -R ~/.dotfiles/config/iterm2 ~/.config/

echo '============================================================> Installing Vim plugins...'
~/.dotfiles/vim/install.sh

echo '============================================================> Configuring git...'
git config --global core.excludesfile ~/.gitignore

echo '============================================================> Changing default shell to zsh...'
chsh -s $(which zsh)
