# Repository Guidelines

## Project Structure & Module Organization
GNU Stow manages symlinks into `$HOME`. Each top-level folder is a Stow package.
- `shell/` for `.bashrc`, `.profile`, `.bash_aliases`.
- `config/.config/` for app configs (e.g., `starship.toml`).
- `tmux/` for `.tmux.conf` and `.tmux/`.
- `scripts/.scripts/` for utilities (e.g., `audio-reset.sh`).
- `setup.sh` is a root-required bootstrap script that installs packages and creates backups/symlinks.

## Dotfile Management
GNU Stow is the standard for this repo. Ansible will live in a separate repo later.

## Dependencies (For Future Ansible)
Keep this list in sync; it will be used to build the Ansible playbook:
- `stow`
- `tmux`
- `vim`
- `starship`
- `git`
- `curl`

## Build, Test, and Development Commands
No build system or tests. Common workflows:
- `stow shell` / `stow config` / `stow tmux` to link packages.
- `stow -D shell` to remove symlinks for a package.
- `sudo ./setup.sh` to install packages and create backups/symlinks.

## Coding Style & Naming Conventions
- Use 2-space indentation in shell scripts; follow existing style.
- Prefer lowercase filenames with dashes (e.g., `audio-reset.sh`).
- Avoid non-ASCII unless the file already uses it.

## Testing Guidelines
Manual checks only:
- `stow -R <package>` and verify symlinks.
- Launch the app (bash/tmux/vim/starship) and validate behavior.

## Contribution Workflow (Branches & PRs)
- `git checkout -b feat/<short-name>` for changes.
- Keep commits concise, plain-language summaries.
- Push, open a PR, describe the change and validation, then merge to `main`.

## Tmux Defaults, Cheatsheet, and Plugins
Tmux key bindings stay at defaults (prefix `C-b`).

Cheatsheet:
- `C-b c` new window, `C-b ,` rename window.
- `C-b "` split vertical, `C-b %` split horizontal.
- `C-b n/p` next/prev window, `C-b &` kill window, `C-b x` kill pane.
- `C-b [` enter copy mode, `C-b ]` paste buffer.

Plugins and usage:
- `tmux-plugins/tpm`: `C-b I` installs/updates plugins.
- `tmux-plugins/tmux-sensible`: sane defaults, no config needed.
- `tmux-plugins/tmux-yank`: copies selection to system clipboard when supported.
- `tmux-plugins/tmux-resurrect`: `C-b C-s` save, `C-b C-r` restore.
- `tmux-plugins/tmux-continuum`: auto save/restore (enabled via `@continuum-boot`/`@continuum-restore`).

## Local-Only Config
- `config/.config/nvim/` is intentionally untracked and should remain local only.

## Security & Configuration Tips
- `setup.sh` runs as root and touches user files; read it before running.
- Backups live in `$HOME/.dotfile_backup`.
