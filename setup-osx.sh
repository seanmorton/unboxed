echo '============================================================> Installing Xcode CLI tools..'
xcode-select install

echo '============================================================> Installing homebrew & packages..'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install vim
brew install tmux
brew install zsh
brew install thefuck
brew install ag
brew install vim
brew cask install iterm2
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

echo '============================================================> Setting up  SSH identity..'
ssh-keygen -t rsa -b 4096 -C "smorton517@gmail.com"
eval "$(ssh-agent -s)"
cat > ~/.ssh/configs << EOF
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
EOF
ssh-add -K ~/.ssh/id_rsa

echo '============================================================> Copying configuration from dotfiles..'
git clone git@github.com:seanmorton/dotfiles.git ~/.dotfiles
cp ~/.dotfiles/.zshrc ~/.zshrc
cp ~/.dotfiles/.tmux.conf ~/.tmux.conf
cp ~/.dotfiles/.gitignore  ~/.gitignore
cp ~/.dotfiles/.agignore  ~/.agignore
cp ~/.dotfiles/.vimrc  ~/.vimrc
mkdir -p ~/.config
cp -R ~/.dotfiles/config/iterm2 ~/.config/

echo '============================================================> Installing Vim plugins..'
~/.dotfiles/vim/install.sh

echo '============================================================> Changing default shell to zsh..'
chsh -s $(which zsh)
