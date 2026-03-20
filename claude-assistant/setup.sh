#!/bin/bash
# Claude Homelab Assistant - Setup Script

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔══════════════════════════════════════════╗"
echo "║     Claude Homelab Assistant Setup       ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"

# ── 1. Claude Code ────────────────────────────────────────────────────────────
echo -e "${BLUE}[1/6] Checking Claude Code...${NC}"
if ! command -v claude &>/dev/null; then
    echo -e "${RED}Error: Claude Code not found.${NC}"
    echo "Install it from: https://claude.ai/download"
    exit 1
fi
CLAUDE_BIN=$(which claude)
echo -e "${GREEN}  ✓ Claude Code found at $CLAUDE_BIN${NC}"

# ── 2. Bun ────────────────────────────────────────────────────────────────────
echo -e "${BLUE}[2/6] Checking Bun (required by the Telegram plugin)...${NC}"
BUN_PATH=""
if command -v bun &>/dev/null; then
    BUN_PATH=$(which bun)
elif [ -f "$HOME/.bun/bin/bun" ]; then
    BUN_PATH="$HOME/.bun/bin/bun"
else
    echo -e "${YELLOW}  Bun not found. Installing...${NC}"
    curl -fsSL https://bun.sh/install | bash
    BUN_PATH="$HOME/.bun/bin/bun"
fi
BUN_DIR=$(dirname "$BUN_PATH")
echo -e "${GREEN}  ✓ Bun found at $BUN_PATH${NC}"

# ── 3. Claude Code auth ───────────────────────────────────────────────────────
echo -e "${BLUE}[3/6] Checking Claude Code authentication...${NC}"
if ! claude --print "ok" &>/dev/null; then
    echo -e "${YELLOW}  Not authenticated. Opening Claude Code login...${NC}"
    claude
fi
echo -e "${GREEN}  ✓ Authenticated${NC}"

# ── 4. Telegram token ─────────────────────────────────────────────────────────
echo -e "${BLUE}[4/6] Telegram Bot Configuration${NC}"
echo ""
echo "  Create a bot with @BotFather on Telegram if you haven't already."
echo "  Send /newbot to @BotFather and follow the instructions."
echo ""
read -p "  Paste your Telegram Bot Token: " TELEGRAM_TOKEN
if [ -z "$TELEGRAM_TOKEN" ]; then
    echo -e "${RED}Error: Token cannot be empty.${NC}"
    exit 1
fi

# ── 5. Configure Claude Code settings ────────────────────────────────────────
echo -e "${BLUE}[5/6] Configuring Claude Code...${NC}"
CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR"

# Global settings
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
if [ ! -f "$SETTINGS_FILE" ]; then
    echo '{}' > "$SETTINGS_FILE"
fi
python3 - <<PYEOF
import json
with open('$SETTINGS_FILE') as f:
    s = json.load(f)
s.setdefault('enabledPlugins', {})['telegram@claude-plugins-official'] = True
s['skipDangerousModePermissionPrompt'] = True
with open('$SETTINGS_FILE', 'w') as f:
    json.dump(s, f, indent=2)
PYEOF
echo -e "${GREEN}  ✓ Settings configured${NC}"

# Telegram token
CHANNEL_DIR="$CLAUDE_DIR/channels/telegram"
mkdir -p "$CHANNEL_DIR"
echo "TELEGRAM_BOT_TOKEN=$TELEGRAM_TOKEN" > "$CHANNEL_DIR/.env"
chmod 600 "$CHANNEL_DIR/.env"
echo -e "${GREEN}  ✓ Telegram token saved${NC}"

# Trust home directory
PROJECT_HASH=$(echo -n "$HOME" | sed 's|/|-|g' | sed 's|^-||')
PROJECT_DIR="$CLAUDE_DIR/projects/$PROJECT_HASH"
mkdir -p "$PROJECT_DIR"
echo '{"hasTrustDialogAccepted": true}' > "$PROJECT_DIR/settings.json"
echo -e "${GREEN}  ✓ Home directory trusted${NC}"

# ── 6. Interactive: install plugin and pair Telegram ─────────────────────────
echo ""
echo -e "${YELLOW}╔══════════════════════════════════════════════════════╗"
echo "║           Manual Step — Read carefully               ║"
echo "╚══════════════════════════════════════════════════════╝${NC}"
echo ""
echo "  Claude Code will now open in channels mode."
echo "  Follow these steps inside the Claude session:"
echo ""
echo "    1. Send any message to your Telegram bot"
echo "    2. In Claude, run:  /telegram:access pair"
echo "    3. Enter the pairing code shown in Telegram"
echo "    4. Run:  /telegram:access policy allowlist"
echo "    5. Type: /exit"
echo ""
read -p "  Press Enter to open Claude Code..."

claude --channels plugin:telegram@claude-plugins-official --dangerously-skip-permissions || true

# ── 7. Systemd service ────────────────────────────────────────────────────────
echo ""
echo -e "${BLUE}[6/6] Creating systemd service...${NC}"

CLAUDE_LOCAL="$CLAUDE_DIR/local"
PATH_ENV="$BUN_DIR:$CLAUDE_LOCAL:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

sudo tee /etc/systemd/system/claude.service > /dev/null <<EOF
[Unit]
Description=Claude Homelab Assistant
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=$USER
WorkingDirectory=$HOME
Environment="PATH=$PATH_ENV"
ExecStart=$CLAUDE_BIN --channels plugin:telegram@claude-plugins-official --dangerously-skip-permissions
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable claude
sudo systemctl restart claude

echo ""
echo -e "${GREEN}"
echo "╔══════════════════════════════════════════╗"
echo "║           Setup Complete! 🎉             ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"
echo "  Claude is now running as a systemd service."
echo "  Send a message to your Telegram bot to test it."
echo ""
echo "  Useful commands:"
echo "    sudo systemctl status claude      # Check status"
echo "    sudo journalctl -u claude -f      # Live logs"
echo "    sudo systemctl restart claude     # Restart"
echo ""
