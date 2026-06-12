# Project Context for AI Agents

## What this repository is

Course material for a **Qualitative Data Analysis** course, part of the
**Master's program in Bioinformatics and Systems Biology** at UNQ/UNNOBA
(Argentina). All content is in **Spanish**.

The course covers classical statistics, regression models, and machine learning
classification methods, taught via Python Jupyter notebooks and Typst slide
presentations.

---

## Repository layout

```
classes/
  C01.*   Module 1 — Statistical foundations
  C02.*   Module 2 — Regression models
  C03.*   Module 3 — Classification & ML
docs/
  presentation-style.md   Visual style guide for Typst slides
agents/
  agents.md               This file
pyproject.toml            Python project definition (managed with uv)
```

Each class `CXX.N` contains:

- `CXX.N.<Topic>.ipynb` — Jupyter notebook with code, examples, and exercises
- `CXX.N.presentation/CXX.N.<Topic>.typ` — Typst source for the slide deck
- `CXX.N.presentation/CXX.N.<Topic>.pdf` — Compiled slides
- `CXX.N.presentation/C0X.N.speech.md` — Presenter notes / script (not all classes)
- `CXX.N.presentation/generate_images.py` — Image generation scripts (where present)

---

## Course modules and classes

### Module 1 — Statistical foundations with Python (`C01`)

| ID    | Topic                        | Notebook                            |
| ----- | ---------------------------- | ----------------------------------- |
| C01.0 | Python introduction          | `C01.Intro.Python.ipynb`            |
| C01.1 | Variables and functions      | `C01.1.Variables_y_funciones.ipynb` |
| C01.2 | Descriptive analysis         | `C01.2.AnalisisDescriptivos.ipynb`  |
| C01.3 | Independence and correlation | `C01.3.Independencia.ipynb`         |
| C01.4 | Hypothesis testing           | `C01.4.PruebaDeHipotesis.ipynb`     |

### Module 2 — Regression models (`C02`)

| ID    | Topic                                   | Notebook                           |
| ----- | --------------------------------------- | ---------------------------------- |
| C02.1 | Linear regression                       | `C02.1.Regresion.ipynb`            |
| C02.2 | Data partitioning                       | (no notebook — slides only)        |
| C02.3 | Logistic regression                     | `C02.3.RegLogistica.ipynb`         |
| C02.4 | Regression with categorical vars        | `C02.4.RegConVarCategoricas.ipynb` |
| C02.5 | Dimensionality reduction (PCA/MDS/UMAP) | `C02.5.Reduccion.ipynb`            |

### Module 3 — Classification & machine learning (`C03`)

| ID    | Topic                              | Notebook                    |
| ----- | ---------------------------------- | --------------------------- |
| C03.1 | Linear Discriminant Analysis       | `C03.1.LDA.ipynb`           |
| C03.2 | Clustering (k-means, hierarchical) | `C03.2.Clustering.ipynb`    |
| C03.3 | Decision trees                     | `C03.3.DecisionTree.ipynb`  |
| C03.4 | Naive Bayes and kNN                | (no notebook — slides only) |

---

## Tech stack

- **Python 3.13**, managed with [uv](https://docs.astral.sh/uv/)
- **Jupyter notebooks** (`.ipynb`) for interactive code
- **Typst** (`.typ`) for slide presentations — compiled to PDF
- Key libraries: `pandas`, `scipy`, `statsmodels`, `matplotlib`, `prince`,
  `umap-learn`, `sympy`

Setup:

```bash
uv sync
uv run jupyter notebook
```

---

## Presentation style

Slides are written in Typst and follow a strict visual style defined in
`docs/presentation-style.md`. Key points for generating or editing slides:

- **Language:** Spanish (`lang: "es"`)
- **Format:** 16:9, off-white background (`#f9f8f5`), Arial 18pt
- **Color palette:** `cm2` (`#032e35`) for text, `cm1` (`#a3804c`) for accents,
  `cm3` (`#00a1ae`) for highlights
- **Title macros:** `stitle(main, sub)` for section headers, `sstitle(body)` for
  slide subtitles — always uppercase
- **Content macro:** `slide(body)` wraps main content with 10% left padding
- All section titles and slide subtitles use ALL CAPS

See `docs/presentation-style.md` for full Typst snippets and spacing conventions.

---

## Naming conventions

- Class IDs: `CXX.N` where `XX` = two-digit module number, `N` = class number
- Typst files mirror the PDF name exactly
- Notebook names use PascalCase topic names in Spanish
- Image generation scripts are always named `generate_images.py` or `gen_images.py`

---

## What agents are typically asked to do

- **Create or update Typst slides** following the style in `docs/presentation-style.md`
- **Add or extend Jupyter notebook content** with Python examples, exercises, or explanations
- **Generate image data** (via `generate_images.py` scripts) for use in slides
- **Update the README** to reflect new classes or structure changes

When editing slides, always consult `docs/presentation-style.md` before writing
any Typst. When adding notebook content, match the style and verbosity of
existing notebooks in the same module.
