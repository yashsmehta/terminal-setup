# Setting up this repo with a coding agent

Goal: make a Mac's terminal and Claude Code look and behave like the setup in this repo.
`README.md` says what each file is; this file is the procedure and the things that went wrong before.

## Steps

1. Check Homebrew exists (`brew --version`). If not, stop and ask the user to install it.
2. Read `install.sh`, then run it. It is safe to re-run. It installs the Brewfile, Oh My Zsh and
   plugins, symlinks the configs, and loads the Caps Lock agent.
3. `~/.claude/settings.json`: the script only copies it when missing. If one exists, merge by hand.
   The keys that matter for the look are `"theme": "light-ansi"`, `"tui": "fullscreen"` and the
   `statusLine` block. Do not overwrite the user's other keys.
4. Fix machine-specific paths in `zsh/zshrc` if the username is not `mehtay` (search for `/Users/mehtay`).
5. Verify (below), then tell the user to quit and reopen Ghostty.

## Verify

```sh
/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config   # prints nothing, exit 0
zsh -n ~/.zshrc                                                     # syntax check
zsh -ic 'whence -w claude agy'                                      # both should be "function"
ls -l ~/.zshrc ~/.config/ghostty/config ~/.config/ghostty/themes    # symlinks into this repo
```

A theme that Ghostty cannot find shows up as a "Configuration Errors" window and a dark fallback
palette, so always run the validate command after touching `theme =`.

## Known gotchas

- **`~/.config/ghostty` not writable.** On one machine it was owned by root, so files could be
  edited but none created (no `themes/` folder). `install.sh` moves such a folder aside. Removing
  the leftover `~/.config/ghostty.not-writable` needs `sudo`.
- **Shell errors can be silent in long agent commands.** After creating files, list them.
- **The line under the Claude Code prompt ("bypass permissions on") cannot be hidden.** Every
  permission mode draws its own label there, there is no setting, and a mod's `PromptHint` hook
  only reaches the text after the label (blanking it leaves a dangling "·"). Checked on 2.1.328.
- **Diff backgrounds.** The ANSI themes show removed lines as dim text with coloured markers,
  with no red/green bands. That is expected.
- **Dark palette slot 8** is the user-message band in Claude Code, so other tools that use
  "bright black" for dim text look faint in dark mode.

## Changing the look

Edit `ghostty/themes/*` (colours) or `ghostty/config` (font, spacing), then reload Ghostty's config.
To judge a change, look at a real Claude Code session showing a diff, inline code, a code block
and a table. An agent can do this itself by starting a second Ghostty with
`ghostty --config-default-files=false --config-file=<test config> -e <script that runs claude>`
and capturing that window with `screencapture -l <window id>`. The window has to be visible on
screen or it captures blank, and the test folder must already be trusted by Claude Code.
