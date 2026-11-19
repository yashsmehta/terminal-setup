# terminal-setup

My terminal setup: Ghostty, zsh (Oh My Zsh + fzf-tab), Starship and Claude Code, in one warm
palette with a light ("Claude Paper") and a dark ("Claude Graphite") variant that follow macOS
appearance.

## New machine

```sh
git clone git@github.com:yashsmehta/terminal-setup.git ~/terminal-setup
~/terminal-setup/install.sh
```

Needs Homebrew first (https://brew.sh). The script installs the tools and font, Oh My Zsh and its
plugins, then symlinks the configs below. Anything already in place is moved to `<name>.pre-terminal-setup`.

Setting this up with a coding agent instead: point it at `AGENTS.md`.

## What's here

| File | Linked to | What it controls |
|---|---|---|
| `zsh/zshrc` | `~/.zshrc` | Shell, aliases, fzf / Tab-menu colours, `ls` colours, the `claude` and `agy` launchers |
| `ghostty/config` | `~/.config/ghostty/config` | Font, spacing, window, quick terminal |
| `ghostty/themes/claude-paper` | `~/.config/ghostty/themes/` | Light palette |
| `ghostty/themes/claude-graphite` | `~/.config/ghostty/themes/` | Dark palette |
| `starship/starship.toml` | `~/.config/starship.toml` | Prompt |
| `claude/statusline-command.sh` | `~/.claude/statusline-command.sh` | Claude Code status line |
| `claude/settings.json` | copied to `~/.claude/settings.json` if none exists | Claude Code settings (theme, status line, plugins) |
| `macos/com.yashsmehta.capslock-f18.plist` | copied to `~/Library/LaunchAgents/` | Caps Lock as F18 |
| `Brewfile` | | Tools and font |

Because the configs are symlinks, editing `~/.zshrc` edits the repo copy. Commit and push to sync.
`claude/settings.json` is the exception: Claude Code rewrites its settings file, so it is a copy.

## How the Claude Code look works

Claude Code's built-in themes use fixed colours. Its two "ANSI" themes (`light-ansi`, `dark-ansi`)
instead draw with the terminal's 16-colour palette, so the Ghostty theme files decide every colour.
Each theme file starts with a comment saying what Claude Code draws with each palette slot.

- Ghostty picks the palette from macOS appearance (`theme = light:...,dark:...`).
- The `claude` function in `zsh/zshrc` picks the matching Claude theme at launch. Claude Code's own
  "auto" theme only switches between the fixed-colour themes, which is why the function exists.
  After switching appearance mid-session, run `/theme`.
- `adjust-box-thickness = -1` in the Ghostty config makes table borders and prompt rules hairlines.

## Machine-specific bits

`zsh/zshrc` has a few paths that assume the username `mehtay` and some tools that may not exist
elsewhere (Antigravity, the labgpu2 helpers, wispr). They are harmless if missing; adjust as needed.
