#!/bin/bash

# Check if the script is running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# Global Variables. 
user_home=$(getent passwd ${SUDO_USER:-$USER} | cut -d: -f6)
backup_dir="$user_home/.dotfile_backup"
config_dir="$user_home/.config"
script_dir="$user_home/.scripts"
tmux_dir="$user_home/.tmux"
log_file="./error.log"

# Create directories and files if it doesn't exist
mkdir -p "$backup_dir"
[ -f "$log_file" ] || touch "$log_file"

# Change ownership and permissions of the log file
chown "$SUDO_USER:$SUDO_USER" "$backup_dir"
chmod 700 "$backup_dir"
chown "$SUDO_USER:$SUDO_USER" "$log_file"
chmod 664 "$log_file"

# Function to install required packages
install_packages() {
    local packages=("vim" "neovim" "git" "curl")
    echo "Installing required packages..."
    sudo apt-get update
    for package in "${packages[@]}"; do
        sudo apt-get install -y "$package"
    done
}

# Function to install Starship
install_starship() {
    if ! command -v starship >/dev/null 2>&1; then
        echo "Installing Starship..."
        curl -sS https://starship.rs/install.sh | sh 2> >(tee -a "$log_file">&2)
    else
        echo "Starship is already installed."
    fi
}

# Function to create backup
backup_file() {
    local file=$1
    local backup_target="$backup_dir/$(basename "$file")"

    # Check if the file exists and is a regular file
    if [ -f "$file" ]; then
        # Check if the file already exists in the backup directory
                if [ -f "$backup_target" ]; then
            echo "Backup already exists for $(basename "$file"), skipping..." | tee -a "$log_file" >&2
            return
        fi

        echo "Backing up $(basename "$file")..."
        sudo -u "$SUDO_USER" cp "$file" "$backup_dir"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to backup $(basename "$file")" | tee -a "$log_file" >&2
        fi
        echo "backing up file $file" >> "$log_file" 
        echo "backing up dir $backup_dir" >> "$log_file" 
        
    else
        echo "Info: File $file does not exist, skipping backup." | tee -a "$log_file" >&2
    fi
}

# Function to create symbolic link
create_symlink() {
    local source_file=$1 
    local target_file=$2
    echo "Creating symbolic link for $(basename "$source_file")..."
    ln -sf "$source_file" "$target_file"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create symlink for $(basename "$source_file")" >&2
    fi
    echo "create sym link source file $source_file" >> "$log_file" 
    echo "create sym link target file $target_file" >> "$log_file" 

}

# Function to process files and create their backups and symlinks to new dotfiles
Process_bkup_smlk() {
    local source_dir=${1%/}
    local target_dir=${2%/}

    mkdir -p "$target_dir"

    find "$source_dir" -maxdepth 1 -type f | while IFS= read -r file; do
        
        # Skip 'error.log' and 'setup.sh'
        if [[ "$(basename "$file")" == "error.log" || "$(basename "$file")" == "setup.sh" || "$(basename "$file")" == "README.md" || "$(basename "$file")" == "LICENSE" || "$(basename "$file")" == ".gitignore" ]]; then
            continue
        fi

        local target_file="$target_dir/$(basename "$file")"
        backup_file "$target_file"
        echo "Processing backup target $target_file" >> "$log_file" 
        create_symlink "$file" "$target_file"
        echo "Processing sym link file $file and target $target_file" >> "$log_file" 
    done
}

# Main execution
# install_packages
install_starship

# Run the functions to proces the files the source dir,.config/, and .scripts/
Process_bkup_smlk "$(pwd)/.config" "$config_dir"
Process_bkup_smlk "$(pwd)/.scripts" "$script_dir"
Process_bkup_smlk "$(pwd)/" "$user_home/"

echo "Setup complete."
