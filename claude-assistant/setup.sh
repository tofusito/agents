#!/bin/bash
# Claude Homelab Assistant - Setup Script

set -euo pipefail

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

# ── 0. OS detection ──────────────────────────────────────────────────────────
if [[ "$(uname -s)" != "Linux" ]]; then
    echo -e "${RED}Error: This setup script requires Linux with systemd.${NC}"
    echo "  Detected OS: $(uname -s)"
    exit 1
fi

if ! command -v systemctl &>/dev/null; then
    echo -e "${RED}Error: systemd is required but not found.${NC}"
    exit 1
fi

# ── 1. Claude Code ────────────────────────────────────────────────────────────
echo -e "${BLUE}[1/7] Checking Claude Code...${NC}"
if ! command -v claude &>/dev/null; then
    echo -e "${RED}Error: Claude Code not found.${NC}"
    echo "  Install it from: https://claude.ai/download"
    exit 1
fi
CLAUDE_BIN=$(command -v claude)
echo -e "${GREEN}  ✓ Claude Code found at $CLAUDE_BIN${NC}"

# ── 2. Python 3 ───────────────────────────────────────────────────────────────
echo -e "${BLUE}[2/7] Checking Python 3...${NC}"
if ! command -v python3 &>/dev/null; then
    echo -e "${RED}Error: Python 3 is required but not found.${NC}"
    echo "  Install it with your package manager, e.g.: sudo apt install python3"
    exit 1
fi
echo -e "${GREEN}  ✓ Python 3 found at $(command -v python3)${NC}"

# ── 3. Bun ────────────────────────────────────────────────────────────────────
echo -e "${BLUE}[3/7] Checking Bun (required by the Telegram plugin)...${NC}"
BUN_PATH=""
if command -v bun &>/dev/null; then
    BUN_PATH=$(command -v bun)
elif [ -f "$HOME/.bun/bin/bun" ]; then
    BUN_PATH="$HOME/.bun/bin/bun"
else
    echo -e "${YELLOW}  Bun not found. Installing...${NC}"
    if ! curl -fsSL https://bun.sh/install | bash; then
        echo -e "${RED}Error: Bun installation failed.${NC}"
        exit 1
    fi
    BUN_PATH="$HOME/.bun/bin/bun"
fi

if [ ! -x "$BUN_PATH" ]; then
    echo -e "${RED}Error: Bun binary not found or not executable at $BUN_PATH${NC}"
    exit 1
fi
BUN_DIR=$(dirname "$BUN_PATH")
echo -e "${GREEN}  ✓ Bun found at $BUN_PATH${NC}"

# ── 4. Claude Code auth ───────────────────────────────────────────────────────
echo -e "${BLUE}[4/7] Checking Claude Code authentication...${NC}"
if ! claude --print "ok" &>/dev/null; then
    echo -e "${YELLOW}  Not authenticated. Opening Claude Code login...${NC}"
    claude
fi
echo -e "${GREEN}  ✓ Authenticated${NC}"

# ── 5. Telegram token ─────────────────────────────────────────────────────────
echo -e "${BLUE}[5/7] Telegram Bot Configuration${NC}"
echo ""
echo "  Create a bot with @BotFather on Telegram if you haven't already."
echo "  Send /newbot to @BotFather and follow the instructions."
echo ""
read -sp "  Paste your Telegram Bot Token: " TELEGRAM_TOKEN
echo ""
if [ -z "$TELEGRAM_TOKEN" ]; then
    echo -e "${RED}Error: Token cannot be empty.${NC}"
    exit 1
fi
echo -e "${GREEN}  ✓ Token received${NC}"

# ── 6. Configure Claude Code settings ────────────────────────────────────────
echo -e "${BLUE}[6/7] Configuring Claude Code...${NC}"
CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR"

# Global settings
SETTINGS_FILE="$CLAUDE_DIR/settings.json"
if [ ! -f "$SETTINGS_FILE" ]; then
    echo '{}' > "$SETTINGS_FILE"
fi
python3 - "$SETTINGS_FILE" <<'PYEOF'
import json, sys
settings_file = sys.argv[1]
with open(settings_file) as f:
    s = json.load(f)
s.setdefault('enabledPlugins', {})['telegram@claude-plugins-official'] = True
s['skipDangerousModePermissionPrompt'] = True
with open(settings_file, 'w') as f:
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

# ── 7. Interactive: install plugin and pair Telegram ─────────────────────────
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

# ── 8. Systemd service ────────────────────────────────────────────────────────
echo ""
echo -e "${BLUE}[7/7] Creating systemd service...${NC}"

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

# Only restart if the service is already running, otherwise start it
if systemctl is-active --quiet claude; then
    echo -e "${YELLOW}  Service 'claude' is already running. Restarting...${NC}"
    sudo systemctl restart claude
else
    sudo systemctl start claude
fi

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
