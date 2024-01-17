# My Dot Files

This repository contains my personal dot file setup. It includes a setup script and configuration files for the bash shell and the Starship prompt.

## Setup Script

The `setup.sh` script is used to initialize the workspace. It first creates backups of any existing dotfiles in your home directory to a directory named `dotfile_backups` in your home directory. Then, it creates symbolic links from your home directory to the new dotfiles in this repository.

To run the setup script, navigate to the directory containing the script and execute it:

```sh
./setup.sh
```

Please note that you may need to grant execute permissions to the script before running it:

```sh
chmod +x setup.sh
```

## Bash Configuration

The [`.bashrc`](.bashrc) and [`.bash_aliases`](.bash_aliases) files contain configurations for the bash shell. They include aliases, functions, and other settings to customize the shell environment.

## Starship Prompt

The Starship prompt is configured using the `starship.toml` file. 

To use these configurations, clone the repository and run the setup script. The script will back up your existing dotfiles to `~/.dotfile_backup`.
