# dotfiles

## Todo
Need to install vivid, (vim)

## Installation process
```sh
git clone --recurse-submodules -j8 git@github.com:N214/dotfiles.git
sudo ./install
```

### Linux
```yaml
# link block if onlu execte if kernel is Linux
- defaults:
    link:
      if: '[ "$(uname -s)" = "Linux" ]'
- link:
    ~/.vimrc: vimrc

```

### MacOS

```yaml
# link block if onlu execte if kernel is Darwin
- defaults:
    link:
      if: '[ "$(uname -s)" = "Darwin" ]'
    brewfile:
      stdout: true
      stderr: true
      include: ['tap', 'brew', 'cask']
- link:
    ~/.config/homebrew/Brewfile: Brewfile
```

### Always execute
```yaml
# shell will always execute
- shell:
  - description: Install package depending on the os type
    command: |
      if [ "$(uname -s)" = "Darwin" ]; then
        echo "MAC OS"
        brew bundle --file=Brewfile
      elif [ "$(uname -a | awk -F ' ' '{print $2}')" = "ubuntu" ]; then
        # Install linux package
        if [ "$(whoami)" = "root" ]; then   apt install -y <apt/packages.txt; else   sudo apt install <apt/packages.txt; fi
        # From Packer install Neovim packages
        # nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
      elif [ "$(uname -a | awk -F ' ' '{print $2}')" = "fedora" ]; then 
        cat dnf/packages.txt | xargs dnf install -y
      fi
    stdout: true
    stdin: true
```
