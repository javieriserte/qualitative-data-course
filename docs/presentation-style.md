# Presentation Style Guide

This document describes the visual style of for presentations
so that new slides can be created consistently.

---

## Page Setup

- **Format:** 16:9 (`presentation-16-9`)
- **Background:** `#f9f8f5` (off-white, warm)
- **Margins:** `x: 32pt`, `y: 26pt` (cover slide uses `0pt` on all sides)
- **Font:** Arial, 18pt, Spanish (`lang: "es"`)
- **Paragraph:** no justification, `leading: 0.7em`

---

## Color Palette

| Name | Hex       | Role                                      |
|------|-----------|-------------------------------------------|
| cm1  | `#a3804c` | Gold/bronze — accents, subtitles, borders |
| cm2  | `#032e35` | Dark teal — primary text, headings        |
| cm3  | `#00a1ae` | Cyan — highlights, HTTP method badges     |
| grn  | `#15803D` | Green — third-level accents               |
| gry  | `#6B7280` | Gray — secondary / descriptive text       |

---

## Typography

| Context              | Font        | Size  | Weight | Color | Notes                    |
|----------------------|-------------|-------|--------|-------|--------------------------|
| Body text            | Arial       | 18pt  | normal | cm2   | default                  |
| Section label (top)  | Arial       | 12pt  | light  | cm2   | ALL CAPS, tracking 5pt   |
| Section sub-label    | Arial       | 12pt  | light  | cm1   | ALL CAPS, tracking 5pt   |
| Slide subtitle       | Arial       | 18pt  | light  | cm1   | ALL CAPS, tracking 5pt   |
| Tertiary subtitle    | Arial       | 18pt  | light  | cm3   |                          |
| Descriptive text     | Arial       | 13–14pt | normal | gry |                          |
| Code / monospace     | Courier New | 13–14pt | normal | cm2 |                          |
| Page counter         | Arial       | 12pt  | normal | cm2   | bottom-right corner      |

---

## Slide Layout

### Standard slide structure (top → bottom)

1. **Section label** (`stitle`) — placed at `top + left`, inside a full-width
   block with `inset: (x: 20pt, y: 9pt)`. Shows `MAIN TITLE | SUBSECTION`
   separated by `|` in cm1.
   Use this definition:

   ```typst
   #let stitle(main, sub) = {
     let content = if sub != none {
       text(weight: "light", size: 12pt, tracking: 5pt)[
         #text(fill: cm2)[#upper(main)]
         #text(fill: cm1)[#text(" | ") #upper(sub)]
       ]
     } else {
       text(fill: cm2, weight: "light", size: 12pt, tracking: 5pt)[
         #upper(main)
       ]
     }
     place(top + left,
       block(width: 100%, fill: rgb("#00000000"),
         inset: (x: 20pt, y: 9pt))[#content])
     v(50pt)
   }
   ```

2. **Slide subtitle** (`sstitle`) — placed at `left`, decorated with a short
   horizontal rule and a filled circle bullet in cm1, then ALL CAPS text.
   Followed by `v(50pt)` spacer.

   ```typst
   #let sstitle(body) = {
     place(left)[
       #block(width: 100%, fill: rgb("#00000000"),
         inset: (x: 20pt, y: 9pt),
         text(fill: cm1, weight: "light", size: 18pt, tracking: 5pt)[
           #box()[#line(start: (-8%, -1.5%), stroke: cm1, length: 10%)]
           #box(baseline: -12%, inset: (x: -10pt))[$circle.filled.small$]
           #text(" ")
           #upper(body)
         ])
     ]
     v(50pt)
   }
   ```

3. **Content area** (`slide`) — shifted right with `pad(left: 10%)`.

   ```typst
   #let slide(body) = pad(left: 10%, body)
   ```

### Content alignment

- Main content is left-aligned and shifted 10% from the left edge.
- Multi-column layouts use `grid` with explicit column sizes and `gutter: 8–20pt`.

---

## Recurring Components

### Code box (`code_box`)

```
width: 88%, fill: #f0fdf4 (very light green), stroke: 0.5pt + cm3 (cyan),
inset: (x: 12pt, y: 8pt), radius: 4pt
font: Courier New, 13pt, cm2
```

Use for shell commands and configuration snippets.

### Endpoint row (`endpoint_row`)

Three-column grid: `(50pt, 180pt, 1fr)`

- **Method badge:** filled box, `fill: cm3`, white bold text, 12pt, radius 3pt
- **Path:** Courier New, 13pt, cm2
- **Description:** Arial, 14pt, gry

Followed by `v(4pt)` spacing between rows.

### Tertiary subtitle (`ssstitle`)

Inline text in cm3, 18pt, light weight. Used to label sub-sections within a slide
(e.g., "Descubrimiento", "Una ubicación — salida CSV").

### Page counter

`context place(bottom + right, dx: 15pt, dy: 15pt)` — displays `current / total`
in 12pt cm2.

---

## Cover Slide

- No page counter, zero margins.
- Title parts: main_title, second_title, comment_line.
- Two bottom panels (50% width each): footer_left, footer_right.
- Use function below to generate:

```typst
#let cover(main_title, second_title, comment_line, footer_left, footer_right) = {
  page(margin: (x: 0pt, y: 0pt),
    [
    #place(left + top, dx: 7%, dy: 15%)[
      #v(50pt)
      #text(fill: cm2, weight: "bold", size: 32pt, main_title)
      #v(5pt)
      #text(fill: cm3, weight: "bold", size: 32pt, second_title)
      #v(5pt)
      #text(fill: cm2, size: 20pt, tracking: 2pt, weight: "thin")[
        #upper(comment_line)
      ]
    ]
    #place(bottom + center)[
      #block(width: 100%, height: 18%, fill: white)
    ]
    #place(center + bottom, dy: 0%)[
      #line(start: (0%, 0%), end: (0%, 16%), stroke: cm1)
    ]
    #place(top + left, dx: 0%, dy: 82%)[
      #block(width: 50%, height: 18%)[
        #align(center + horizon)[
          #text(fill: cm2, size: 16pt, tracking: 3pt, footer_left)
        ]
      ]
    ]
    #place(top + left, dx: 50%, dy: 82%)[
      #block(width: 50%, height: 18%)[
        #align(center + horizon)[
          #text(fill: cm2, size: 16pt, tracking: 3pt, footer_right)
        ]
      ]
    ]
  ])
}
```
---

## Spacing Conventions

| Element                          | Spacing      |
|----------------------------------|------------  |
| After `stitle`                   | `v(10pt)`    |
| After `sstitle`                  | `v(10pt)`    |
| Between `ssstitle` and content   | `v(4–8pt)`   |
| Between major sections on slide  | `v(10–16pt)` |
| Between endpoint rows            | `v(4pt)`     |

---

## Box / Card Style

Bordered cards use:
- `stroke: 2pt + <accent-color>`, `inset: 16pt`, `radius: 5pt`
- REST API card → cm3 border
- CLI card → cm1 border
- Agent skill card → grn border

---

## Do / Don't

- **Do** use ALL CAPS for section and slide titles.
- **Do** use Courier New exclusively for paths, commands, and variable names.
- **Do** keep descriptive body text in gry to maintain visual hierarchy.
- **Don't** use color fills on slide backgrounds (only the cover has a decorative element).
- **Don't** justify paragraph text.
- **Don't** use font weights heavier than `bold` — the palette relies on color,
  not weight, to establish hierarchy.
