# 🤖 Agent Forge

A central repository of practical custom AI agents I use, refine, and share across Claude and other agentic AI platforms.

This space is dedicated to building, refining, and sharing specialized AI assistants that can autonomously manage workflows, generate content, and solve complex tasks.

---

## Featured agents

| Agent | Purpose |
| --- | --- |
| `claude-assistant` | Claude Code + Telegram assistant for homelab and local automation workflows. |
| `fit-coach` | Personal training and gym tracking assistant. |
| `pack-genius` | Travel packing assistant and example agent structure. |
| `purchase-advisor` | Purchase decision assistant for comparing options and tradeoffs. |

---

## 🤔 What is this?

As AI models evolve to become more autonomous, it's incredibly useful to have specialized agents tailored for specific tasks rather than relying on a single general prompt. This repository contains those specialized agents. 

Each agent lives in its own directory with its own tailored instructions, knowledge base, and structural requirements.

---

## 📁 Repo structure

```text
📂 agent root
├── 📂 claude-assistant/        ← Claude Code + Telegram homelab assistant
├── 📂 pack-genius/             ← Example agent for travel packing
├── 📂 fit-coach/               ← Personal training and gym tracking agent
├── 📂 purchase-advisor/        ← Smart purchasing decision skill agent
├── 📂 [future-agents]/         ← New agents will be added here
├── .gitignore
├── LICENSE
└── README.md                   ← You are here
```

---

## 🚀 How to use the agents

Each agent has its own specific instructions and requirements, but the general workflow is:

### 1. Set up your environment
Open [Claude Desktop](https://claude.ai/download) (or your preferred agentic environment) ideally with directory access or "Cowork" capabilities enabled.

### 2. Select the Agent
Navigate into the specific folder of the agent you want to use (e.g., `pack-genius/`) and set it as your working directory.

### 3. Follow the specific instructions
Read the `README.md` or `AGENT.md` inside that specific agent's folder to understand how to interact with it, how to customize its knowledge base, and what its capabilities are.

---

## 🛠️ Requirements

- [Claude Desktop](https://claude.ai/download) or a similar agentic interface.
- Local file system access for the AI (if the agent requires reading/writing files).
- Please check individual agent folders for any specific dependencies.

---

## 📝 License

MIT — use it, adapt it, share it. Let's build awesome agents together.
