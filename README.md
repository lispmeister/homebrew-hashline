# homebrew-hashline

Homebrew tap for [hashline](https://github.com/lispmeister/hashline) — a content-addressable line editing tool for AI coding assistants.

## Install

```sh
brew install lispmeister/hashline/hashline
```

## Claude Code Integration

After installing, set up the Claude Code skill (one-time):

```sh
mkdir -p ~/.claude/skills/hashline-setup
curl -fsSL https://raw.githubusercontent.com/lispmeister/hashline/main/contrib/skills/hashline-setup/SKILL.md \
    -o ~/.claude/skills/hashline-setup/SKILL.md
```

Then run `/hashline-setup` in any project to activate the hooks.

For other agents (Cursor, Windsurf, etc.), see the [Agent Integration](https://github.com/lispmeister/hashline#agent-integration) docs.

## License

MIT — see [LICENSE](LICENSE).
