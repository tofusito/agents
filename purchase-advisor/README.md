# 🛍️ Purchase Advisor — Skill for Claude (Cowork)

A smart purchasing agent that helps you decide if something is worth buying, using filters for minimalism, BIFL (Buy It For Life), and real cost. When you decide to buy, it documents the analysis. It always keeps a log of the decision.

---

## 🧠 What does it do?

When you tell it you're thinking of buying something, the agent:

1. **Evaluates** if it makes sense using 4 filters: real value, cost per use, work hours, and BIFL philosophy.
2. **Debates** with you — if you push back, it counters with data.
3. **Issues a verdict**: ✅ YES / ❌ NO / ⏳ WAIT
4. **Asks** if you want an in-depth analysis of the product (strengths, weaknesses, alternatives, where to buy).
5. **Creates a folder** with all the documentation in your purchases directory.

---

## 📁 Generated Folder Structure

```
📂 2026-03-09 - Nuki Smart Lock Ultra/
├── LOG.md       → always: debate, filters, verdict
└── RESEARCH.md  → only if requested: product analysis
```

---

## 🚀 How to Install

### Requirements
- [Claude Desktop](https://claude.ai/download) with **Cowork** enabled

### Installation

1. Download or clone this repo.
2. Open the `purchase-advisor.skill` file with Claude Desktop.
3. Click on **"Copy to your skills"**.
4. Done — the skill is available in any Cowork session.

> The skill activates automatically when you mention you want to buy something. No need to invoke it manually.

---

## ⚙️ Customization (Important)

The agent is designed to adapt to **your profile**. Before using it, edit the `purchase-advisor/references/AGENT.md` file with your information:

### What you need to fill in

```
references/AGENT.md
```

- **Your profile**: purchasing philosophy, lifestyle, restrictions (e.g., vegan, minimalist...).
- **Your finances**: income, fixed expenses, monthly discretionary budget.
- **Your inventory**: what you already own (tech, home, audio...) to avoid redundancies.
- **Your hourly rule**: `Price ÷ (your discretionary budget / hours worked per month)`

### The X $/hour Rule

This is the most powerful filter. It converts every purchase into life time:

```
Rate = Monthly discretionary budget ÷ Effective hours worked per month
```

Example: if you have $1,000/month discretionary and work ~149 effective hours → **~$7/hour**. $210 headphones = 30 hours of work. Are they worth it?

Effective hours are calculated like this:
```
(52 weeks × 5 days - holidays - vacations) × 8h / 12 months ≈ 149 h/month
```

---

## 💬 Usage Examples

```
"I'm thinking of getting AirPods Pro 2, they're 229 €"
"Is it worth subscribing to Netflix now that X series is out?"
"I saw a $180 coffee maker, should I buy it?"
"Look at this thing I saw on Amazon [photo]"
```

The agent never searches for products from scratch — you come with what you have in mind, and it evaluates.

---

## 📂 Skill Structure

```
purchase-advisor/
├── SKILL.md                  → orchestrator: agent workflow
├── references/
│   └── AGENT.md              → your profile, finances, inventory, and decision frameworks
└── templates/
    ├── LOG.md                → template for the decision log
    └── RESEARCH.md           → template for the product analysis
```

---

## 🔒 Privacy

The `references/AGENT.md` file contains personal information (finances, inventory). Do not upload it to a public repository without reviewing it. The template included in this repo is an **anonymous example** — fill it with your data before using the skill.

---

## 📝 License

MIT — use it, fork it, adapt it.
