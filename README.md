# Dotfiles (Stow-based)

My personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each folder (like `shell`, `config`, `tmux`) is a Stow package. Symlinks are created into `$HOME` automatically.

## 📦 Usage

### Install Stow

```bash
sudo apt install stow
```
### Stow a config package

Create symlinks from the specified package directory into your home directory so your applications pick up the new or updated dotfiles.
```bash
cd ~/.dotfiles
stow shell      # Links .bashrc, .profile, etc. to ~/
stow config     # Links files in .config/
stow tmux       # Links .tmux.conf and plugins
```
### Unstow (remove symlinks)
Remove the symlinks for a given package—this safely “deactivates” those dotfiles without deleting any actual files.
```bash
stow -D shell
```
### Restow (force update symlinks)
Re-create all symlinks for a package in one step, useful if you’ve moved or renamed files and need to refresh the links.
```bash
stow -R shell
```
#### Do the Git
```bash
git add .
git commit -m "Describe your changes"
git push
```
