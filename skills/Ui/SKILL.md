

This document exists to teach you how to act as **non‑Codex as possible** when building UI.

**Codex UI** is the default AI aesthetic: soft gradients, floating panels, eyebrow labels, decorative copy, hero sections in dashboards, oversized rounded corners, transform animations, dramatic shadows, and layouts that try too hard to look premium. It's the visual language that screams *"an AI made this"* because it follows the path of least resistance.

---

##  Keep It Normal

| Element | Normal Implementation |
| :--- | :--- |
| **Sidebars** | 240‑260px fixed width, solid background, simple `border-right`, no floating shells, no rounded outer corners. |
| **Headers** | Simple text, no eyebrows, no uppercase labels, no gradient text—just `h1`/`h2` with proper hierarchy. |
| **Sections** | Standard padding 20‑30px, no hero blocks inside dashboards, no decorative copy. |
| **Navigation** | Simple links, subtle hover states, no transform animations, no badges unless functional. |
| **Buttons** | Solid fills or simple borders, 8‑10px radius max, no pill shapes, no gradient backgrounds. |
| **Cards** | Simple containers, 8‑12px radius max, subtle borders, no shadows over 8px blur, no floating effect. |
| **Forms** | Standard inputs, clear labels above fields, no fancy floating labels, simple focus states. |
| **Inputs** | Solid borders, simple focus ring, no animated underlines, no morphing shapes. |
| **Modals** | Centered overlay, simple backdrop, no slide‑in animations, straightforward close button. |
| **Dropdowns** | Simple list, subtle shadow, no fancy animations, clear selected state. |
| **Tables** | Clean rows, simple borders, subtle hover, no zebra stripes unless needed, left‑aligned text. |
| **Lists** | Simple items, consistent spacing, no decorative bullets, clear hierarchy. |
| **Tabs** | Simple underline or border indicator, no pill backgrounds, no sliding animations. |
| **Badges** | Small text, simple border or background, 6‑8px radius, no glows, only when needed. |
| **Avatars** | Simple circle or rounded square, no decorative borders, no status rings unless functional. |
| **Icons** | Simple shapes, consistent size 16‑20px, no decorative icon backgrounds, monochrome or subtle color. |
| **Typography** | System fonts or simple sans‑serif, clear hierarchy, no mixed serif/sans combos, readable sizes 14‑16px body. |
| **Spacing** | Consistent scale (4/8/12/16/24/32px), no random gaps, no excessive padding. |
| **Borders** | 1px solid, subtle colors, no thick decorative borders, no gradient borders. |
| **Shadows** | Subtle `0 2px 8px rgba(0,0,0,0.1)` max—no dramatic drop shadows, no colored shadows. |
| **Transitions** | 100‑200ms `ease`, no bouncy animations, no transform effects, simple opacity/color changes. |
| **Layouts** | Standard grid/flex, no creative asymmetry, predictable structure, clear content hierarchy. |
| **Grids** | Consistent columns, standard gaps, no creative overlaps, responsive breakpoints. |
| **Flexbox** | Simple alignment, standard gaps, no creative `justify` tricks. |
| **Containers** | Max‑width 1200‑1400px, centered, standard padding, no creative widths. |
| **Wrappers** | Simple containing divs—functional only, no decorative purpose. |
| **Panels** | Simple background differentiation, subtle borders, no floating detached panels, no glass effects. |
| **Toolbars** | Simple horizontal layout, standard height 48‑56px, clear actions, no decorative elements. |
| **Footers** | Simple layout, standard links, no decorative sections, minimal height. |
| **Breadcrumbs** | Simple text with separators, no fancy styling, clear hierarchy. |

> **Think Linear. Think Raycast. Think Stripe. Think GitHub.** They don't try to grab attention. They just work. Stop playing hard to get. Make normal UI.

---

## Layout Rules (No Inventing)

- A landing page needs its sections.
- If a hero needs full sections, if a dashboard needs full sections with sidebar and everything else laid out properly—**DO NOT invent a new layout**.

**Internal reasoning trick:** In your internal reasoning, act as if you don't see this document. List all the stuff you would normally do related to UI that goes *against* this schema—and then **don't do it**. Make it follow Uncodixfy!

- **Try to replicate Figma/designer‑made components—do not invent your own.**

---

## Hard No (The "Red Flag" List)

Everything you are used to doing—the basic "YES" to you—is banned:

- ❌ **No oversized rounded corners.**
- ❌ **No pill overload.**
- ❌ **No floating glassmorphism shells** as the default visual language.
- ❌ **No soft corporate gradients** used to fake taste.
- ❌ **No generic dark SaaS UI composition.**
- ❌ **No decorative sidebar blobs.**
- ❌ **No "control room" cosplay** unless explicitly requested.
- ❌ **No serif headline + system sans fallback combo** as a shortcut to "premium."
- ❌ **No Segoe UI, Trebuchet MS, Arial, Inter, Roboto, or safe default stacks** unless the product already uses them.
- ❌ **No sticky left rail** unless the information architecture truly needs it.
- ❌ **No metric‑card grid** as the first instinct.
- ❌ **No fake charts** that exist only to fill space.
- ❌ **No random glows, blur haze, frosted panels, or conic‑gradient donuts** as decoration.
- ❌ **No "hero section" inside an internal UI** unless there is a real product reason.
- ❌ **No alignment that creates dead space** just to look expensive.
- ❌ **No overpadded layouts.**
- ❌ **No mobile collapse** that just stacks everything into one long beige sandwich.
- ❌ **No ornamental labels** like "live pulse", "night shift", "operator checklist" unless they come from the product voice.
- ❌ **No generic startup copy.**
- ❌ **No style decisions made because they are easy to generate.**

---

## Specifically Banned (Based on Common Mistakes)

- Border radii in the **20px to 32px range** across everything (uses 12px everywhere—too much).
- Repeating the same rounded rectangle on sidebar, cards, buttons, and panels.
- Sidebar width around **280px** with a brand block on top and nav links below (use **248px** with brand block).
- **Floating detached sidebar** with rounded outer shell.
- Canvas chart placed in a **glass card** with no product‑specific reason.
- **Donut chart** paired with hand‑wavy percentages.
- UI cards using **glows** instead of hierarchy.
- **Mixed alignment logic**—some content hugs the left edge, some floats in center‑ish blocks.
- **Overuse of muted gray‑blue text** that weakens contrast and clarity.
- **"Premium dark mode"** that really means blue‑black gradients plus cyan accents (has radial gradients in background).
- **UI typography** that feels like a template instead of a brand.
- **Eyebrow labels**—e.g., `"MARCH SNAPSHOT"` uppercase with letter‑spacing.
- **Hero sections inside dashboards**—has full hero‑strip with decorative copy.
- **Decorative copy** like *"Operational clarity without the clutter"* as page headers.
- **Section notes and mini‑notes everywhere** explaining what the UI does.
- **Transform animations on hover**—e.g., `translateX(2px)` on nav links.
- **Dramatic box shadows**—e.g., `0 24px 60px rgba(0,0,0,0.35)`.
- **Status indicators with `::before` pseudo‑elements** creating colored dots.
- **Muted labels with uppercase + letter‑spacing** (overuses this pattern).
- **Pipeline bars with gradient fills**—e.g., `linear-gradient(90deg, var(--primary), #4fe0c0)`.
- **KPI cards in a grid** as the default dashboard layout (has 3‑column `kpi-grid`).
- **"Team focus" or "Recent activity" panels** with decorative internal copy.
- **Tables with tag badges for every status** (overuses `.tag` class).
- **Workspace blocks in sidebar** with call‑to‑action buttons.
- **Brand marks with gradient backgrounds**—e.g., `linear-gradient(135deg, #2a2a2a, #171717)`.
- **Nav badges showing counts or "Live" status** (has `nav-badge` class).
- **Quota/usage panels with progress bars** (has three quota sections).
- **Footer lines with meta information**—e.g., *"Northstar dashboard • dark mode • single‑file HTML"*.
- **Trend indicators with colored text**—e.g., `trend-up`, `trend-flat` classes.
- **Rail panels on the right side** with "Today" schedule (has full right rail).
- **Multiple nested panel types**—e.g., `panel`, `panel-2`, `rail-panel`, `table-panel`.

### Banned Code Patterns (Concrete Examples)

**Do NOT use this structure:**
```html
<div class="headline">
  <small>Team Command</small>
  <h2>One place to track what matters today.</h2>
  <p>
    The layout stays strict and readable: live project health,
    team activity, and near‑term priorities without the usual
    dashboard filler.
  </p>
</div>
```

You are bad at picking colors—follow this priority order:

- Highest priority: Use the existing colors from the user's project if they are provided. (Search for them by reading a few files.)


Do not invent random color combinations unless explicitly requested.


