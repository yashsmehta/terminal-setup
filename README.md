# dotfiles

My terminal setup: Ghostty, zsh (Oh My Zsh + fzf-tab), Starship, in a Claude Light palette.

## New machine

```sh
git clone git@github.com:yashsmehta/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

Needs Homebrew first (https://brew.sh). The script installs the tools and font, Oh My Zsh and its
plugins, then symlinks the configs below. Anything already in place is moved to `<name>.pre-dotfiles`.

## What's here

| File | Linked to | What it controls |
|---|---|---|
| `zsh/zshrc` | `~/.zshrc` | Shell, aliases, fzf / Tab-menu colours, `ls` colours |
| `ghostty/config` | `~/.config/ghostty/config` | Font, theme, window, quick terminal |
| `starship/starship.toml` | `~/.config/starship.toml` | Prompt |
| `macos/com.yashsmehta.capslock-f18.plist` | copied to `~/Library/LaunchAgents/` | Caps Lock as F18 |
| `Brewfile` | | Tools and font |

Because the configs are symlinks, editing `~/.zshrc` edits the repo copy. Commit and push to sync.

## Machine-specific bits

`zsh/zshrc` has a few paths that assume the username `mehtay` and some tools that may not exist
elsewhere (Antigravity, the labgpu2 helpers, wispr). They are harmless if missing; adjust as needed.
