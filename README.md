# Curso de Análisis de Datos Cualitativos

Material del curso de análisis de datos cualitativos de la Maestría en
Bioinformática y Biología de Sistemas (UNQ/UNNOBA).

## Contenido del curso

### Módulo 1 — Fundamentos estadísticos con Python

| Clase                       | Notebook                            | Presentación          |
| --------------------------- | ----------------------------------- | --------------------- |
| Introducción a Python       | `C01.Intro.Python.ipynb`            | `C01.0.presentation/` |
| Variables y funciones       | `C01.1.Variables_y_funciones.ipynb` | `C01.1.presentation/` |
| Análisis descriptivos       | `C01.2.AnalisisDescriptivos.ipynb`  | `C01.2.presentation/` |
| Independencia y correlación | `C01.3.Independencia.ipynb`         | `C01.3.presentation/` |
| Prueba de hipótesis         | `C01.4.PruebaDeHipotesis.ipynb`     | `C01.4.presentation/` |

### Módulo 2 — Modelos de regresión

| Clase                               | Notebook                           | Presentación          |
| ----------------------------------- | ---------------------------------- | --------------------- |
| Regresión lineal                    | `C02.1.Regresion.ipynb`            | `C02.1.presentation/` |
| Partición de datos                  | —                                  | `C02.2.presentation/` |
| Regresión logística                 | `C02.3.RegLogistica.ipynb`         | `C02.3.presentation/` |
| Regresión con variables categóricas | `C02.4.RegConVarCategoricas.ipynb` | `C02.4.presentation/` |
| Reducción de dimensiones            | `C02.5.Reduccion.ipynb`            | `C02.5.presentation/` |

### Módulo 3 — Clasificación y aprendizaje automático

| Clase                               | Notebook                   | Presentación          |
| ----------------------------------- | -------------------------- | --------------------- |
| Análisis discriminante lineal (LDA) | `C03.1.LDA.ipynb`          | `C03.1.presentation/` |
| Clustering                          | `C03.2.Clustering.ipynb`   | `C03.2.presentation/` |
| Árboles de decisión                 | `C03.3.DecisionTree.ipynb` | `C03.3.presentation/` |
| Naive Bayes y kNN                   | —                          | `C03.4.presentation/` |

## Estructura del repositorio

```
classes/
├── C01.*   # Módulo 1: Fundamentos estadísticos
├── C02.*   # Módulo 2: Modelos de regresión
└── C03.*   # Módulo 3: Clasificación y ML
docs/       # Documentación adicional
```

Cada clase incluye un notebook Jupyter (`.ipynb`) y una presentación en formato
Typst (`.typ` / `.pdf`).

## Requisitos

- Python 3.13
- Se recomienda usar [uv](https://docs.astral.sh/uv/) para gestionar el entorno

```bash
uv sync
uv run jupyter notebook
```

Dependencias principales: `pandas`, `scipy`, `statsmodels`, `matplotlib`,
`scikit-learn` (vía `prince`, `umap-learn`), `sympy`.
