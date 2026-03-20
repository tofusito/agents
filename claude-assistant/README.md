# Claude Homelab Assistant

Run Claude Code 24/7 on your homelab and talk to it via Telegram. Ask it to check services, fix issues, restart containers, or anything else — all from your phone.

![Claude Code + Telegram](https://img.shields.io/badge/Claude_Code-v2.1.80+-blue) ![Telegram](https://img.shields.io/badge/Telegram-Channel-blue)

## How it works

Claude Code runs as a systemd service in [channels mode](https://code.claude.com/docs/en/channels), listening for messages from a Telegram bot. When you send a message, Claude receives it, thinks about it, acts on your homelab (runs commands, edits files, restarts services...) and replies back.

```
You (Telegram) ──► Bot ──► Claude Code (homelab) ──► executes stuff ──► replies
```

## Prerequisites

- A Linux machine (your homelab server)
- [Claude Code](https://claude.ai/download) installed and logged in
- A Claude Pro subscription (required for channels)
- A Telegram account

## Quick Start

### 1. Create a Telegram Bot

1. Open Telegram and search for **@BotFather**
2. Send `/newbot` and follow the instructions
3. Copy the **bot token** you receive (looks like `1234567890:ABCdef...`)

### 2. Run the setup script

Clone this repo on your homelab server and run:

```bash
git clone https://github.com/yourusername/claude-assistant
cd claude-assistant
chmod +x setup.sh
./setup.sh
```

The script will:
- Check prerequisites (Claude Code, Bun)
- Ask for your Telegram bot token
- Configure Claude Code settings
- Walk you through the Telegram pairing step
- Create and enable a systemd service

### 3. Pair your Telegram account

During setup, Claude Code will open in channels mode. You need to:

1. **Send any message** to your Telegram bot (e.g. `/start`)
2. In the Claude Code terminal, run:
   ```
   /telegram:access pair
   ```
3. Enter the pairing code that appeared in your Telegram chat
4. Set the access policy so only you can use it:
   ```
   /telegram:access policy allowlist
   ```
5. Exit with `/exit`

The service will start automatically after this.

## Usage

Just send messages to your bot from Telegram:

```
you: is portainer running?
claude: Yes, Portainer is running. Container ID abc123, up 3 days.

you: restart the nginx container
claude: Restarting nginx... done. It's back up and healthy.

you: check disk space
claude: /dev/sda1: 45% used (120GB free). All good.
```

Claude has full access to your server — it can run shell commands, edit files, manage Docker containers, and more.

## Manage the service

```bash
# Check status
sudo systemctl status claude

# View live logs
sudo journalctl -u claude -f

# Restart
sudo systemctl restart claude

# Stop
sudo systemctl stop claude
```

## Security considerations

- The bot uses an **allowlist** — only your paired Telegram account can send commands
- Claude runs as your user (not root)
- `--dangerously-skip-permissions` is required for headless operation — Claude won't ask for confirmation on every action, so be mindful of what you ask it to do
- Don't share your bot token or add other users to the allowlist unless you fully trust them

## Troubleshooting

**Bot doesn't respond**
- Check the service is running: `sudo systemctl status claude`
- Make sure `bun` is in the PATH (the setup script handles this, but verify with `journalctl -u claude`)
- Verify your Telegram user ID is in `~/.claude/channels/telegram/access.json`

**Service keeps restarting**
- Run `sudo journalctl -u claude -n 50` to see why it's crashing
- The most common cause is the trust dialog — re-run `setup.sh` to fix it

**Authentication expired**
- Run `claude` manually to re-authenticate, then restart the service
