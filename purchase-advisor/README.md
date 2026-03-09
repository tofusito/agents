# 🛍️ Purchase Advisor — Purchasing Agent for Claude

A smart purchasing agent that evaluates if something is worth buying using minimalism, BIFL, and real cost filters. It documents every decision in a structured folder so you can review it later.

Works with **Claude** (and any AI supporting `AGENT.md`) by opening this folder as your working directory.

---

## 🧠 What does it do?

When you tell it you're thinking of buying something, the agent:

1. **Evaluates** if it makes sense using 4 filters: real value, cost per use, work hours, and BIFL.
2. **Debates** with you — if you push back, it counters with data.
3. **Issues a verdict**: ✅ YES / ❌ NO / ⏳ WAIT
4. **Asks** if you want an in-depth analysis of the product (strengths, weaknesses, alternatives, where to buy).
5. **Creates a folder** with the decision documentation.

---

## 📁 Generated Folder Structure

```
📂 2026-03-09 - Nuki Smart Lock Ultra/
├── LOG.md        → always: debate, filters, verdict
└── RESEARCH.md   → only if requested: product analysis
```

---

## 🚀 How to Install

1. Download or clone this repo to your computer.
2. Open the folder with **Claude Desktop** in Cowork mode (or any AI that supports `AGENT.md`).
3. Fill in `knowledge/profile.md` with your information.
4. Fill in `knowledge/filters.md` with your $/hour rate and category guidelines.
5. Done — the agent loads the context automatically when opening the folder.

---

## ⚙️ Customization

Everything you need to edit is in `knowledge/`:

### `knowledge/profile.md`
Your financial profile and current inventory. The agent uses it to detect redundancies — if you already have something that covers the need, the bar to approve a purchase is raised.

### `knowledge/filters.md`
The 4 decision filters. The most important thing to customize is **your $/hour rule**:

```
Rate = Monthly discretionary budget ÷ Effective hours worked per month
```

Example: $1,000/month ÷ 149h ≈ **$7/hour**. $210 headphones = 30 hours of work. Are they worth it?

Effective hours are calculated like this:
```
(52 weeks × 5 days - holidays - vacations) × 8h / 12 months ≈ 149 h/month
```

---

## 💬 Usage Examples

```
"I'm thinking of getting AirPods Pro 2, they're 229 €"
"Is it worth subscribing to Netflix?"
"I saw a $180 coffee maker, should I buy it?"
"Look at this thing I saw on Amazon [photo]"
```

The agent doesn't search for products from scratch — you come with what you have in mind, and it evaluates.

---

## 📂 Repository Structure

```
📁 purchase-advisor/
├── AGENT.md                  → agent instructions (workflow, tone, verdict)
├── knowledge/
│   ├── profile.md            → your financial profile and inventory
│   └── filters.md            → the 4 filters with your numbers
└── templates/
    ├── LOG.md                → template for the decision log
    └── RESEARCH.md           → template for the product analysis
```

---

## 🔒 Privacy

`knowledge/profile.md` contains personal information (finances, inventory). Do not upload it to a public repo. Add it to your `.gitignore` if you are going to version it:

```
knowledge/profile.md
```

---

## 📝 License

MIT — use it, fork it, adapt it.
