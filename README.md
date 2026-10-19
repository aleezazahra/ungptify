<img width="3780" height="1890" alt="image" src="https://github.com/user-attachments/assets/5c4ada0e-9c21-4e94-916c-901d8481849d" />

A curated set of skills or prompts to make em useless and ugly looking vibe coded apps into something meaningful and secure

---

##  Included Skills

| Skill Folder | Description |
| :--- | :--- |
| **`skills/secure-code/`** | Audits code for OWASP Top 10 vulnerabilities (XSS, SQLi, CSRF, hardcoded secrets, etc.) and provides secure fixes. |
| **`Ui/`** | Builds production‑quality, performant, accessible frontends that break the generic "AI‑generated" aesthetic . |

---

##  Prerequisites

- [Codex](https://github.com/openai/codex) installed globally or via the VS Code extension.
- Terminal / command line access.

---

##  Installation

Choose the method that suits you best.

### Method 1: Global Install (Recommended)
Makes skills available in **every** Codex session.

```bash
# Clone the repository
git clone https://github.com/aleezazahra/ungptify.git

# Create the Codex skills directory if it doesn't exist
mkdir -p ~/.codex/skills

# Copy BOTH skill folders into Codex's global skills directory
cp -r codex-skills/skills ~/.codex/skills/
cp -r codex-skills/Ui ~/.codex/skills/

# Clean up (optional)
rm -rf codex-skills
```

**Restart Codex** (or reload the VS Code window) and you're ready to go.

---

### Method 2: Project‑Specific Install
Keep skills scoped to a single project (great for team consistency).

```bash
# Clone the repository inside your project root
git clone https://github.com/aleezazahra/ungptify.git

# Create the local .codex/skills folder
mkdir -p .codex/skills

# Copy both skill folders into the project
cp -r codex-skills/skills .codex/skills/
cp -r codex-skills/Ui .codex/skills/

# (Optional) Remove the cloned repo
rm -rf codex-skills
```

---

### Method 3: One‑Click Installer Script
For users who prefer automation.

```bash
git clone https://github.com/aleezazahra/ungptify.git
cd codex-skills
chmod +x install.sh
./install.sh
cd .. && rm -rf codex-skills
```

---

### Method 4: Using `npx` (Community Package)
If you have the community skills CLI installed:

```bash
npx skills add aleezazahra/ungptify --skill secure-code
npx skills add aleezazahra/ungptify --skill Ui
```

---

##  `install.sh` Script Content

Make it executable: `chmod +x install.sh`

---

##  How to Use

Once installed, skills are auto‑discovered by Codex. You have two ways to invoke them:

### Option A: Direct Invocation
In any Codex session, type:

```text
$secure-code
```
or
```text
$Ui
```

Then paste your code. Codex will apply the full skill context.

### Option B: Manual Copy‑Paste
Navigate to the skill folder, open `SKILL.md`, and copy the prompt block directly into your chat.

---

## 📁 Repository Structure

```
codex-skills/
├── README.md
├── install.sh                 (optional helper script)
├── skills/
│   └── secure-code/
│       └── SKILL.md           # Full security checklist + prompt
└── Ui/
    └── SKILL.md               # Production UI workflow + Uncodixfy reference
```

---

## 🛠️ Skills Deep Dive

| Skill | What It Does |
| :--- | :--- |
| **secure-code** | Scans your code for XSS, SQLi, hardcoded secrets, and misconfigurations. Provides fixes with Argon2id, parameterized queries, CSP, RLS, and container hardening. |
| **Ui** | Builds production‑ready UI with Next.js defaults. Optimizes Core Web Vitals, adds a11y, error boundaries, state sync, and enforces the **Uncodixfy** aesthetic (no glows, no pill‑shapes, no generic AI fluff). |

---

## Contributing

Have a great skill for a specific domain? We'd love your help!

1. Fork this repo.
2. Add your skill in a new folder (either under `skills/` or at the root, like `Ui/`).
3. Include a `SKILL.md` with:
   - YAML frontmatter (`name`, `description`).
   - A clear, actionable workflow.
4. Open a Pull Request.

---

##  License

[MIT](LICENSE) – Use them freely, modify them, and share them with your team.
