#!/bin/zsh
# Sets up the terminal on a Mac: tools, Oh My Zsh + plugins, and symlinks to the configs in this repo.
# Safe to re-run. Existing files are moved aside to <name>.pre-dotfiles before being replaced.
set -e
DOT=${0:A:h}

echo "==> Homebrew packages"
if ! command -v brew >/dev/null; then
  echo "Homebrew is missing. Install it from https://brew.sh and re-run." >&2
  exit 1
fi
brew bundle --file="$DOT/Brewfile"

echo "==> Oh My Zsh"
if [[ ! -d ~/.oh-my-zsh ]]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "==> Zsh plugins"
plugins=~/.oh-my-zsh/custom/plugins
for repo in Aloxaf/fzf-tab zsh-users/zsh-autosuggestions zsh-users/zsh-syntax-highlighting; do
  [[ -d $plugins/${repo:t} ]] || git clone --depth 1 https://github.com/$repo $plugins/${repo:t}
done

link() {  # link <file in repo> <destination>
  local src=$DOT/$1 dst=$2
  mkdir -p ${dst:h}
  if [[ -L $dst && ${dst:A} == ${src:A} ]]; then return; fi
  if [[ -e $dst || -L $dst ]]; then mv $dst $dst.pre-dotfiles; echo "    moved existing $dst to $dst.pre-dotfiles"; fi
  ln -s $src $dst
  echo "    $dst -> $src"
}

echo "==> Linking configs"
link zsh/zshrc               ~/.zshrc
link ghostty/config          ~/.config/ghostty/config
link starship/starship.toml  ~/.config/starship.toml

echo "==> Caps Lock as F18 (toggles the Ghostty quick terminal)"
agent=~/Library/LaunchAgents/com.yashsmehta.capslock-f18.plist
mkdir -p ${agent:h}
cp "$DOT/macos/com.yashsmehta.capslock-f18.plist" $agent
launchctl unload $agent 2>/dev/null || true
launchctl load $agent

echo "Done. Quit and reopen Ghostty to pick everything up."
