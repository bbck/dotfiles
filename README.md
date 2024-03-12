# dotfiles
My personal dotfiles for ZSH

## Installing
```
git clone https://github.com/bbck/dotfiles.git ~/Developer/dotfiles
cd ~/Developer/dotfiles
./install.sh
```

## Post-install tasks

### macOS settings

```
./.macos
```

### Generate machine specific SSH and GPG keys

```
ssh-keygen -t ed25519
gpg --full-generate-key
```

## Inspiration
Credit to other dotfiles repos that have influenced this one
* https://github.com/caarlos0/dotfiles
* https://github.com/holman/dotfiles
* https://github.com/mathiasbynens/dotfiles
