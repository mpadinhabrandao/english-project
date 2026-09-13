# English project

A personal, 15-minutes-a-day system for a Portuguese-speaking developer to go from ~A2 to confident, all-round English — built as a thin layer on top of Claude and Cambridge's free tools instead of yet another app.

**Status:** v0.1 — plan and coach skill drafted, 13 Sep 2026. Level: A2 (estimate; placement pending). Block 1: 14 Sep → 6 Dec 2026.

## Why this exists

Courses teach in the order of *their* syllabus; this project teaches in the order of *your* errors. Every day you produce a little English about your real life, a coach corrects at most three things, and the recurring patterns go into an error bank that becomes tomorrow's warm-up. Portuguese speakers make a predictable set of mistakes — the coach knows them by ID.

We looked at what already exists before building anything (see below). Nothing was worth rebuilding. What was missing was the glue: a plan that fits 15 minutes, a coach that knows *your* errors, and files that make progress visible.

## Quick start — 5 minutes

1. **Install the coach.** Open `english-coach.skill` → **Save skill**. If skills aren't available on your plan, paste the body of `.claude/skills/english-coach/SKILL.md` into this Claude Project's instructions and add the two files in `.claude/skills/english-coach/references/` to the Project's knowledge.
2. **Give it your memory.** Add `ERROR_BANK.md` to the Project's knowledge. Re-add it after each Sunday review.
3. **Day 1:** take [Cambridge Test your English](https://www.cambridgeenglish.org/test-your-english/) (free, ~25 min). Write the result in `PROGRESS.md`. That's today's session.
4. **Every day after:** say **"daily session"** — or paste a Slack message / PR description with **"check this"**.
5. **End of session:** copy the coach's `LOG` block into `PROGRESS.md` and the rows into `ERROR_BANK.md`. It's one code block; one tap.
6. **Sunday:** say **"weekly review"**.

## Files

```
english-project/
├── README.md                      ← you are here
├── LEARNING_PLAN.md               ← the method, the week, the 12-week roadmap, the tools
├── ERROR_BANK.md                  ← your syllabus: recurring errors by pattern ID + vocab to recycle
├── PROGRESS.md                    ← level checks, daily log, weekly review template
├── english-coach.skill            ← installable Claude skill (Save skill button) — built, don't edit
├── build-skill.sh                 ← rebuilds english-coach.skill from the skill source
└── .claude/skills/english-coach/  ← the skill source; Claude Code loads it automatically here
    ├── SKILL.md                   ← how the coach runs a 15-minute session
    └── references/
        ├── pt-en-interference.md  ← ~60 Portuguese-driven error patterns with IDs (S04, P01, F21…)
        └── a1-a2-checklist.md     ← 44 "start from the beginning" items — tested, not re-taught
```

Keep the folder in a private Git repo — `git log` on `ERROR_BANK.md` is a progress chart. Google Drive works too; Claude can read the files from there during a session.

## How a session works

`daily` → warm-up (3 retrieval items) → main task by weekday (Write / Read / Speak / Grammar / Listen / Free) → micro-lesson on today's top fix → `LOG` block.
`work` → paste a real text, get it corrected with at most 3 explained fixes.
`review` → Sundays, 10 minutes.
`sweep` → the A1–A2 checklist, 3 items a day inside the warm-up, for the first ~4 weeks.

Details in `.claude/skills/english-coach/SKILL.md`; the reasoning in `LEARNING_PLAN.md`.

## What already exists — and why we didn't rebuild it

- **[FreeLingo](https://github.com/artcc/freelingo)** — open-source, self-hosted AI language platform: placement test, CEFR A1–C2 plan, AI tutor, listening/reading generators, SM-2 flashcards. The closest thing to a complete product. Overkill for 15 min/day, but a good block-2 option if you want an app.
- **[claude-language-tutor](https://github.com/gislio/claude-language-tutor)** — five Claude skills with learner data files and a long research reference. Good ideas on progress files; more machinery than we need.
- **[english-coach](https://github.com/tianmind-studio/english-coach)** (tianmind-studio) — Claude Code skill: conversation-based practice with categorised corrections. Closest in spirit to ours.
- **[lang-tutor](https://github.com/hamsamilton/lang-tutor)** — corrects your target language while you code in Claude Code. Recommended *alongside* this project: zero extra time.
- **Cambridge free tools** — [Test your English](https://www.cambridgeenglish.org/test-your-english/) for placement, [Write & Improve](https://writeandimprove.com/) for CEFR feedback on writing. Our external measuring sticks.

## Roadmap for the project itself

- **v0.1 (now):** plan, error bank seeded from your first message, coach skill v1.
- **v0.2 (after 2 weeks of use):** tune the coach from real sessions — what got skipped, what ran long, whether Wednesday speaking actually happens. Add `references/work-english.md` with your team's recurring vocabulary.
- **v0.3:** automation — an n8n reminder at session time with the day's mode; Anki export of the vocab table if you end up liking flashcards.
- **v0.4:** Claude Code integration — lang-tutor, or a small `.claude/agents/pr-english-reviewer.md` agent that checks PR descriptions before you open them; optional FreeLingo self-host.

## Changing the plan

Edit `LEARNING_PLAN.md` first, then keep `SKILL.md` consistent (the week table and the modes must match). After editing anything under `.claude/skills/english-coach/`, push: a GitHub Action rebuilds `english-coach.skill` and commits it. Then download it and re-install, or run `./build-skill.sh` locally if you want it straight away — the skill saved in your account never updates itself. In Claude Code inside this repo the source is picked up directly, no rebuild needed. Change the plan every 4 weeks based on the Sunday reviews — not on a bad day.
