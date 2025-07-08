
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.

# Function to extend hatch with an 'add' command
hatch() {
    if [[ "$1" == "add" ]]; then
        shift  # Remove 'add' from the arguments

        # Check if any packages were specified
        if [[ $# -eq 0 ]]; then
            echo "Error: No packages specified"
            return 1
        fi

        # Install packages with pip
        pip install "$@"

        # Check if pip install was successful
        if [[ $? -ne 0 ]]; then
            echo "Error: Failed to install one or more packages"
            return 1
        fi

        # Update pyproject.toml
        if [[ -f pyproject.toml ]]; then
            for package in "$@"; do
                # Get the installed version
                version=$(pip show $package | grep Version | cut -d ' ' -f 2)
                
                # Check if dependencies list exists
                if grep -q "dependencies = \[\]" pyproject.toml; then
                    # Replace empty dependencies list with new entry
                    sed -i '' 's/dependencies = \[\]/dependencies = \[\n  "'$package'>='$version'",\n\]/' pyproject.toml
                elif grep -q "dependencies = \[" pyproject.toml; then
                    # Add new entry to existing dependencies list
                    sed -i '' '/dependencies = \[/a\
  "'$package'>='$version'",' pyproject.toml
                else
                    echo "Error: Could not find dependencies list in pyproject.toml"
                    return 1
                fi
            done
            echo "Updated pyproject.toml with new dependencies"
        else
            echo "Warning: pyproject.toml not found. Dependencies were installed but not added to pyproject.toml"
        fi
    else
        command hatch "$@"
    fi
}

# Define the mcd function
function mcd() {
  mkdir -p "$1" && cd "$1"
}
alias mcd="mcd"

# Remove the alias for mcd
# alias mcd="mcd"  # This line should be removed or commented out

# Other configuration in your .zshrc...
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Which plugins would you like to load?
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases
alias lsl='ls -lah'
alias pydoc="python3.13 -m pydoc"
alias ec="/Applications/calibre.app/Contents/MacOS/ebook-convert"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


. "$HOME/.cargo/env"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jamescourson/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jamescourson/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jamescourson/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jamescourson/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# pnpm
export PNPM_HOME="/Users/jamescourson/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && . "$(brew --prefix nvm)/nvm.sh"
. "/Users/jamescourson/.deno/env"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export ANDROID_HOME=/Users/jamescourson/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
alias ebook-convert="/Applications/calibre.app/Contents/MacOS/ebook-convert"

# opencode
export PATH=/Users/jamescourson/.opencode/bin:$PATH
