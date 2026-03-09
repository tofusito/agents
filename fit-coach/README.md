# 🏃 Personal Training Agent

A personal training agent powered by Claude (Cowork mode) that tracks your gym and running workouts, remembers your history, and gives you coaching based on your actual data — not generic advice.

---

## 🧠 What This Is

This is not a chatbot that gives generic fitness tips. It's a **persistent memory system** that Claude reads before every response. It knows your lifts, your running phase, your injuries, your rules, and your goals. The more you update it, the smarter it gets.

Everything lives in plain markdown files. No database, no app, no subscription.

---

## 📁 Folder Structure

```
📁 your-folder/
├── AGENT.md              ← Who Claude is and how it behaves
├── GYM.md                ← Your strength training memory
├── RUNNING.md            ← Your running memory
└── ROUTINES/
    ├── GYM/
    │   └── PPL-v1.md     ← Active gym routine (or your own split)
    └── RUNNING/
        └── MONTH_YEAR.md ← Monthly running plan
```

---

## 🚀 How to Set It Up

### 1. Copy the files
Drop the `GIT/templates/` folder contents into your Cowork working directory (the folder you select in Claude desktop).

### 2. Edit the templates
Fill in your own information:
- `AGENT.md` — your profile, your rules, your fixed constraints
- `GYM.md` — your current level, goals, PRs, injuries
- `RUNNING.md` — your current pace, zones, phase
- `ROUTINES/GYM/` — your actual routine
- `ROUTINES/RUNNING/` — your current monthly plan

### 3. Talk to Claude
Open Cowork, select your folder, and just talk. Claude will read the files automatically before every response.

Start with something like:

> *"Read my files and tell me what you know about me. Then let's review my current routine."*

---

## 💬 How to Use It Day to Day

**After a workout:**
> *"Just did Push. Smith incline 4×8 at 60kg, OHP 3×6 at 40kg. Update my logs."*

**To review progress:**
> *"Check my last 3 running sessions on Strava and tell me if my pace is improving."*

**To adjust the plan:**
> *"I want to swap Bulgarian split squat for something else, I hate it."*

**To ask technical questions:**
> *"Is my Z2 heart rate zone calibrated correctly? What should I expect at my current fitness level?"*

Claude will always cross-reference your files before answering. If something contradicts what's in the files, it will flag it.

---

## 🔌 Optional Integrations

The agent can connect to external services if you have them set up in Claude:

| Integration | What it enables |
|-------------|----------------|
| **Strava** | Pull real activity data (pace, HR, distance) to validate what you report |
| **Google Calendar** | Check your schedule before suggesting session days |
| **Google Drive** | Store files in Drive instead of local folder |

Strava is the most useful one — the agent can catch inconsistencies between what you remember and what your watch actually recorded.

---

## ✏️ Keeping It Updated

The agent is only as good as the data in the files. Update them regularly:

- **After PRs** → add to `GYM.md` PR table
- **After each running session** → add to the monthly `ROUTINES/RUNNING/MONTH.md`
- **When injured** → update `GYM.md` or `RUNNING.md` injury section immediately
- **When changing routines** → create a new versioned file (e.g. `PPL-v2.md`) and update the reference in `GYM.md`

You can ask Claude to update the files for you mid-conversation:
> *"Update my running log with today's session."*

---

## 🧩 Customizing the Agent

The `AGENT.md` file controls Claude's personality, priorities, and rules. Key things to customize:

- **Fixed rules** — movements you can't do due to injury, constraints that never change
- **Priority order** — what matters most (e.g. running > strength)
- **Tone** — how direct, how technical, how much explanation you want
- **Your profile** — experience level, goals, diet, available equipment

The more specific your rules, the better the agent behaves.

---

## 📋 File Descriptions

| File | Purpose |
|------|---------|
| `AGENT.md` | Claude's instructions — who it is, what it knows, how it acts |
| `GYM.md` | Strength training memory: goals, PRs, injuries, progression protocol |
| `RUNNING.md` | Running memory: zones, pace benchmarks, phase, technical notes |
| `ROUTINES/GYM/PPL-v1.md` | Active gym routine with exercises, sets, reps, and notes |
| `ROUTINES/RUNNING/MONTH.md` | Monthly running plan with session breakdown and history |

---

## ⚙️ Technical Notes

- Files are plain markdown — edit them in any text editor
- Claude reads them via the Cowork folder integration, no special setup needed
- Version your routines by creating new files (`PPL-v2.md`) instead of overwriting
- The agent works without Strava, but it's significantly more useful with it

---

## 📄 License

Do whatever you want with this. It's a folder of markdown files.
