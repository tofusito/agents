# 🛫 Travel Packing Agent

A personal AI agent for managing travel packing. Generates custom checklists per destination, weather, airline, and activities — and saves them as ready-to-use Markdown files.

---

## 🤔 What does this do?

Tell it where you're going, how many days, and what you'll be doing. The agent looks up the weather forecast and airline carry-on limits by itself, reads your personal inventory of bags, clothes, and tech, and generates a fully customised packing checklist. It won't tell you which specific t-shirt to pack, but it will tell you how many and what type.

Each checklist is saved in its own folder with a standardised name, and always ends with a summary table for a quick glance before closing the bag.

---

## 📁 Repo structure

```
📂 agent root
├── AGENT.md                        ← agent instructions (do not edit)
├── KNOWLEDGE/
│   ├── packing-memoria.md          ← YOUR inventory and packing philosophy ⬅️ edit this
│   └── packing-checklist.md        ← base template for generated checklists
├── 01_DESTINATION_DATE/            ← auto-generated trip folders
│   └── CHECKLIST-DESTINATION-DATE-NDAYS.md
└── README.md                       ← this file
```

---

## 🚀 How to use it

### 1. Set up your inventory

Open `KNOWLEDGE/packing-memoria.md` and edit it to reflect **your** actual gear:

- What bags do you own? Weights and dimensions?
- What tech do you travel with? Chargers, cables, laptop?
- What clothes do you typically pack? What are your go-to travel pieces?
- What's your philosophy? Ultralight? Comfort-first? Always carry-on only?

This file is the agent's **source of truth**. The more accurate it is, the better the checklists it generates.

### 2. Select the folder in Cowork

Open [Claude Desktop](https://claude.ai/download) in Cowork mode and select this folder as your working directory.

### 3. Ask for a checklist

Just tell the agent what you need:

```
I'm going to Rome from June 10 to 15 with Ryanair. No laptop, no camera.
Activities: sightseeing and restaurants. Nothing special.
```

The agent will look up the weather forecast for Rome in mid-June, check Ryanair's carry-on limits, read your inventory, pick the right bag configuration, verify it fits the weight limit, and generate the checklist. It saves everything in a new folder automatically.

### 4. Update your inventory

When you buy something new (bag, charger, clothing) or change your philosophy, just tell the agent:

```
I bought an Osprey Farpoint 40L, add it to my inventory
```

Or edit `packing-memoria.md` directly.

---

## ⚙️ How it works internally

The agent follows this flow every time you generate a checklist:

```
1. Reads packing-memoria.md       → knows your full inventory
2. Reads packing-checklist.md     → loads the base template
3. Looks up weather forecast      → for destination and travel dates
4. Looks up airline limits        → carry-on weight and size (if flying)
5. Analyses the trip              → destination, days, activities
6. Selects configuration          → main bag + day bag
7. Calculates weight              → verifies it fits the airline limit (if flying)
8. Customises clothing            → adapts to weather, duration, activities
9. Picks tech                     → selects charger and which devices to bring
10. Generates the file            → CHECKLIST-DESTINATION-DATE-NDAYS.md
11. Creates the folder            → NN_DESTINATION_DATE/
```

---

## ✏️ Customisation

### Add destination heuristics

In `packing-memoria.md` there's a destination heuristics section. Add your own:

```markdown
| Southeast Asia | Travel backpack + sling | No | Universal adapter | Low-cost airlines, 7kg limit |
```

### Change the base template

If you want all your checklists to include an extra section (e.g. "Travel insurance details"), add it to `packing-checklist.md`. The agent will include it in future checklists.

### Change the filename or folder format

Tell the agent directly or document it in `AGENT.md`.

---

## 💡 Tips

- **Be specific** when requesting a checklist: exact destination, dates, and activities. The more context, the better the decisions.
- **Review and adjust** the generated checklist before closing your bag. The agent may miss things if the inventory isn't up to date.
- **Update your inventory** after each trip if something didn't work ("the hoodie took too much space, skip it for summer trips").
- Past checklists work as references. Tell the agent "make it similar to the Rome one from June" and it will adapt.

---

## 🛠️ Requirements

- [Claude Desktop](https://claude.ai/download) with **Cowork** enabled
- Select this folder as your working directory when starting a session
- Nothing else — no APIs, no code, no extra configuration

---

## 📝 License

MIT — use it, adapt it, share it.
