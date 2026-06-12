// ─── Paquetes externos ───────────────────────────────────────────────────────
#import "@preview/lilaq:0.6.0" as lq

// ─── Configuración global ────────────────────────────────────────────────────
#set page(
  paper: "presentation-16-9",
  background: rect(fill: rgb("#f9f8f5"), width: 100%, height: 100%),
  margin: (x: 32pt, y: 26pt),
)
#set text(font: "Arial", size: 18pt, lang: "es", fill: rgb("#032e35"))
#set par(justify: false, leading: 0.6em)
#show math.equation: set text(size: 15pt)

// ─── Paleta ──────────────────────────────────────────────────────────────────
#let cm1 = rgb("#a3804c")
#let cm2 = rgb("#032e35")
#let cm3 = rgb("#00a1ae")
#let grn = rgb("#15803D")
#let gry = rgb("#6B7280")
#let red = rgb("#e74c3c")

// ─── Componentes ─────────────────────────────────────────────────────────────
#let stitle(main, sub: none) = {
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
  place(top + left, block(width: 100%, fill: rgb("#00000000"), inset: (x: 20pt, y: 9pt))[#content])
  v(50pt)
}

#let sstitle(body) = {
  place(left)[
    #block(width: 100%, fill: rgb("#00000000"), inset: (x: 20pt, y: 9pt), text(
      fill: cm1,
      weight: "light",
      size: 18pt,
      tracking: 5pt,
    )[
      #box()[#line(start: (-8%, -1.5%), stroke: cm1, length: 10%)]
      #box(baseline: -12%, inset: (x: -10pt))[$circle.filled.small$]
      #text(" ")
      #upper(body)
    ])
  ]
  v(50pt)
}

#let ssstitle(body) = text(fill: cm3, weight: "light", size: 18pt)[#body]

#let slide(body) = pad(left: 10%, body)

#let section-divider(number, title, subtitle: none) = {
  pagebreak()
  place(left + top, dx: 0pt, dy: 0pt, rect(fill: cm2, width: 28%, height: 100%))
  place(left + top, dx: 0pt, dy: 0pt, rect(fill: cm1, width: 28%, height: 4pt))
  place(left + horizon, dx: 4%)[
    #text(fill: cm1, size: 64pt, weight: "bold")[#number]
  ]
  place(left + horizon, dx: 30%, dy: -10pt)[
    #text(fill: cm2, size: 28pt, weight: "bold")[#title]
  ]
  if subtitle != none {
    place(left + horizon, dx: 30%, dy: 24pt)[
      #text(fill: gry, size: 16pt, tracking: 2pt)[#upper(subtitle)]
    ]
  }
}

#let counter-display = context place(
  bottom + right,
  dx: 15pt,
  dy: 15pt,
  text(fill: cm2, size: 12pt)[
    #counter(page).display() / #counter(page).final().first()
  ],
)

#let cover(main_title, second_title, comment_line, footer_left, footer_right) = {
  page(margin: (x: 0pt, y: 0pt), background: rect(fill: rgb("#f9f8f5"), width: 100%, height: 100%), [
    #place(left + top, dx: 7%, dy: 15%)[
      #v(50pt)
      #text(fill: cm2, weight: "bold", size: 32pt)[#main_title]
      #v(5pt)
      #text(fill: cm3, weight: "bold", size: 32pt)[#second_title]
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
          #text(fill: cm2, size: 16pt, tracking: 3pt)[#footer_left]
        ]
      ]
    ]
    #place(top + left, dx: 50%, dy: 82%)[
      #block(width: 50%, height: 18%)[
        #align(center + horizon)[
          #text(fill: cm2, size: 16pt, tracking: 3pt)[#footer_right]
        ]
      ]
    ]
  ])
}

#let styled-table(..args) = table(
  stroke: none,
  inset: 4pt,
  fill: (col, row) => if row == 0 { cm2 } else if calc.odd(row) { rgb("#f0f4f4") } else { white },
  ..args,
)

#let th(body) = text(fill: white, weight: "bold", size: 12pt)[#body]
#let td(body) = text(fill: cm2, size: 12pt)[#body]
#let tdg(body) = text(fill: gry, size: 12pt)[#body]

// ════════════════════════════════════════════════════════════════════════════
// PORTADA
// ════════════════════════════════════════════════════════════════════════════
#cover(
  "Unidad II",
  "Partición de Datos",
  "Train · Validation · Test · Cross-validation",
  "Análisis de Datos Cualitativos",
  "2026",
)

// ════════════════════════════════════════════════════════════════════════════
// CONTENIDOS
// ════════════════════════════════════════════════════════════════════════════
#counter-display
#stitle("Unidad II", sub: "Contenidos")
#sstitle("Índice")
#slide[
  #set text(size: 15pt)
  #set par(leading: 0.9em)
  + Motivación — ¿por qué no usar todos los datos para entrenar?
  + Holdout — partición train / test \
    #text(fill: gry, size: 12pt)[Sesgo · Varianza · Tamaño de muestra]
  + Tres conjuntos — train / validation / test \
    #text(fill: gry, size: 12pt)[Selección de hiperparámetros · Evaluación final]
  + Validación cruzada \
    #text(fill: gry, size: 12pt)[k-fold · Stratified k-fold · LOOCV]
  + Data leakage — errores frecuentes \
    #text(fill: gry, size: 12pt)[Preprocesamiento · Tiempo · Target leakage]
  + Implementación en Python
]

// ════════════════════════════════════════════════════════════════════════════
// 1. MOTIVACIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Motivación", subtitle: "El problema de la evaluación honesta")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Motivación")
#sstitle("¿Por qué partir los datos?")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      Un modelo *ajustado y evaluado sobre los mismos datos* siempre
      parece mejor de lo que realmente es.

      #v(6pt)
      #ssstitle[Sobreajuste (overfitting)]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        El modelo memoriza el ruido del conjunto de entrenamiento.
        Sus métricas en train son optimistas; su desempeño en datos
        nuevos es notablemente peor.
      ]

      #v(6pt)
      #ssstitle[Objetivo de la partición]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        Simular datos *no vistos durante el entrenamiento* para obtener
        una estimación honesta de la capacidad predictiva del modelo.
      ]
    ],
    [
      #block(stroke: 2pt + cm3, inset: 10pt, radius: 5pt, width: 100%)[
        #text(size: 13pt, fill: cm2, weight: "bold")[Analogía: el examen]
        #v(6pt)
        #text(fill: gry, size: 12pt)[
          Un estudiante que estudia con las respuestas del examen obtiene
          100 % en esa prueba, pero no aprendió realmente.

          #v(4pt)
          El *conjunto de test* son las preguntas que el modelo nunca vio.
          El *conjunto de train* es el material de estudio.
        ]
      ]

      #v(8pt)
      #block(stroke: 1.5pt + cm1, inset: 8pt, radius: 4pt, width: 100%)[
        #text(size: 11pt)[
          Regla fundamental: *el conjunto de test nunca debe influir
          en ninguna decisión de modelado*.
        ]
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Motivación")
#sstitle("Sesgo y varianza en la evaluación")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      #ssstitle[Problema con particiones pequeñas]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        Si el conjunto de test es pequeño, la métrica estimada tiene
        *alta varianza*: una muestra distinta daría un resultado muy diferente.
      ]

      #v(6pt)
      #ssstitle[Problema con particiones grandes de test]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        Usar demasiados datos para test *reduce el conjunto de entrenamiento*,
        lo que introduce sesgo: el modelo aprende menos de lo que podría.
      ]

      #v(6pt)
      #block(stroke: 1.5pt + grn, inset: 7pt, radius: 4pt, width: 100%)[
        #text(size: 12pt)[
          *Balance habitual:* 70–80 % train, 20–30 % test.
          Con datos escasos, preferir validación cruzada.
        ]
      ]
    ],
    [
      #styled-table(
        columns: (auto, auto, 1fr),
        th[n total], th[Split],       th[Observación],
        td[< 500],   tdg[CV k-fold],  tdg[Holdout inestable],
        td[500–5k],  tdg[80/20],      tdg[Razonable],
        td[5k–50k],  tdg[80/20],      tdg[Test fiable],
        td[> 50k],   tdg[90/10],      tdg[Test grande = fiable],
      )

      #v(8pt)
      #text(fill: gry, size: 11pt)[
        La estratificación (mantener la proporción de clases en cada
        partición) es *siempre recomendable* en clasificación desbalanceada.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 2. HOLDOUT
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Holdout", subtitle: "Train / Test")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Holdout")
#sstitle("Partición train / test")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      La estrategia más simple: dividir el dataset una sola vez en dos
      conjuntos *disjuntos*.

      #v(6pt)
      #styled-table(
        columns: (auto, auto, 1fr),
        th[Conjunto], th[Fracción],  th[Propósito],
        td[Train],    tdg[70–80 %], tdg[Ajuste de parámetros del modelo],
        td[Test],     tdg[20–30 %], tdg[Evaluación final — *no tocar hasta el final*],
      )

      #v(6pt)
      #ssstitle[Cuándo es suficiente]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        - Dataset grande (n > 5 000).
        - No se comparan múltiples modelos ni hiperparámetros.
        - Se necesita una estimación rápida del desempeño.
      ]
    ],
    [
      #ssstitle[Limitaciones]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        - La métrica depende del *azar de la partición*: semillas distintas
          pueden dar resultados muy diferentes con muestras pequeñas.
        - Si se ajustan hiperparámetros usando el conjunto de test, la
          evaluación deja de ser honesta (*test set leakage*).
        - Con clases desbalanceadas, sin estratificación es posible que
          el test quede sin ejemplos de la clase minoritaria.
      ]

      #v(6pt)
      #block(stroke: 1.5pt + cm1, inset: 7pt, radius: 4pt, width: 100%)[
        #text(size: 11pt)[
          Buena práctica: fijar `random_state` para reproducibilidad
          y usar `stratify=y` en clasificación.
        ]
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 3. TRES CONJUNTOS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Tres conjuntos", subtitle: "Train / Validation / Test")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Tres conjuntos")
#sstitle("Train / Validation / Test")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      Cuando se comparan modelos o se seleccionan hiperparámetros se
      necesita un tercer conjunto independiente.

      #v(6pt)
      #styled-table(
        columns: (auto, auto, 1fr),
        th[Conjunto],    th[Fracción],  th[Propósito],
        td[Train],       tdg[60–70 %], tdg[Ajuste de parámetros],
        td[Validation],  tdg[10–20 %], tdg[Selección de modelo / hiperparámetros],
        td[Test],        tdg[10–20 %], tdg[Evaluación final imparcial],
      )

      #v(6pt)
      #text(fill: gry, size: 12pt)[
        El conjunto de *validación* puede usarse tantas veces como sea
        necesario durante el desarrollo. El conjunto de *test* se usa
        *una sola vez* al final.
      ]
    ],
    [
      #ssstitle[Flujo de trabajo]
      #v(4pt)
      #set text(size: 12pt)
      + Dividir en train / val / test *antes de cualquier preprocesamiento*.
      + Ajustar transformaciones *solo* sobre train; aplicarlas a val y test.
      + Entrenar múltiples modelos sobre train.
      + Seleccionar el mejor modelo según la métrica en *validation*.
      + Reportar el desempeño final sobre *test*.

      #v(6pt)
      #block(stroke: 1.5pt + red, inset: 7pt, radius: 4pt, width: 100%)[
        #text(size: 11pt)[
          Mirar el test durante la selección convierte la evaluación final
          en una estimación *optimista y no reproducible*.
        ]
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 4. VALIDACIÓN CRUZADA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "Validación cruzada", subtitle: "k-fold · Stratified · LOOCV")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Validación cruzada")
#sstitle("k-fold cross-validation")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      Divide el dataset en *k pliegues (folds)* de igual tamaño.
      El proceso se repite k veces: cada fold actúa una vez como
      conjunto de validación.

      #v(4pt)
      $ "Score"_("CV") = frac(1, k) sum_(i=1)^k "Score"_i $

      #v(4pt)
      #styled-table(
        columns: (auto, 1fr),
        th[k],   th[Características],
        td[5],   tdg[Rápido · Alta varianza · Recomendado con n < 1 000],
        td[10],  tdg[Estándar · Buen compromiso sesgo/varianza],
        td[n],   tdg[LOOCV · Sin sesgo · Muy lento con n grande],
      )
    ],
    [
      #ssstitle[Ventajas frente a holdout]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        - Usa *todos los datos* tanto para entrenar como para validar.
        - Estimación más estable: menor varianza de la métrica.
        - Especialmente útil con *datasets pequeños* donde el holdout
          sería demasiado ruidoso.
      ]

      #v(6pt)
      #ssstitle[Stratified k-fold]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        Preserva la *proporción de clases* en cada fold.
        Es la variante recomendada para clasificación,
        especialmente con clases desbalanceadas.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Validación cruzada")
#sstitle("Variantes de validación cruzada")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      #ssstitle[Leave-One-Out CV (LOOCV)]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        Caso extremo de k-fold con k = n. Cada observación actúa
        una vez como conjunto de validación.
        - *Ventaja:* sesgo mínimo.
        - *Desventaja:* costo computacional $O(n)$ y alta varianza
          de la estimación.
        - Práctico solo cuando n es muy pequeño (< 100).
      ]

      #v(6pt)
      #ssstitle[Repeated k-fold]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        Repite el proceso de k-fold con distintas semillas aleatorias
        y promedia los resultados. Reduce la varianza asociada a la
        partición sin incrementar el sesgo.
      ]
    ],
    [
      #ssstitle[CV en series de tiempo]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        Los datos temporales *no pueden partirse aleatoriamente*:
        el futuro no puede usarse para predecir el pasado.
      ]

      #v(4pt)
      #block(stroke: 1.5pt + cm3, inset: 7pt, radius: 4pt, width: 100%)[
        #text(size: 12pt, weight: "bold", fill: cm2)[Time Series Split]
        #v(4pt)
        #text(fill: gry, size: 11pt)[
          Cada fold usa *solo observaciones anteriores* como train.
          La ventana de entrenamiento crece en cada iteración
          (_expanding window_) o se desliza (_sliding window_).
        ]
      ]

      #v(6pt)
      #text(fill: gry, size: 11pt)[
        `sklearn.model_selection.TimeSeriesSplit` implementa
        directamente esta estrategia.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 5. DATA LEAKAGE
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Data Leakage", subtitle: "Errores frecuentes en la partición")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Data Leakage")
#sstitle("¿Qué es el data leakage?")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      El *data leakage* ocurre cuando información que no estaría
      disponible en producción se filtra al proceso de entrenamiento
      o evaluación, produciendo métricas artificialmente optimistas.

      #v(6pt)
      #ssstitle[Tipos principales]
      #v(4pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Tipo],            th[Descripción],
        td[Preprocesamiento], tdg[Escalar o imputar con estadísticos del test],
        td[Target leakage],   tdg[Incluir variables causadas por el target],
        td[Temporal],         tdg[Usar datos futuros para predecir el pasado],
        td[Duplicados],       tdg[Misma obs. en train y test],
      )
    ],
    [
      #ssstitle[Leakage en preprocesamiento]
      #v(3pt)
      #block(stroke: 2pt + red, inset: 8pt, radius: 5pt, width: 100%)[
        #text(size: 12pt, fill: red, weight: "bold")[Incorrecto]
        #v(3pt)
        #text(fill: gry, size: 11pt)[
          Calcular la media y desviación estándar sobre *todo el dataset*
          y luego dividir en train/test.
          El escalado ya "vio" los datos de test.
        ]
      ]

      #v(6pt)
      #block(stroke: 2pt + grn, inset: 8pt, radius: 5pt, width: 100%)[
        #text(size: 12pt, fill: grn, weight: "bold")[Correcto]
        #v(3pt)
        #text(fill: gry, size: 11pt)[
          Dividir primero. Ajustar `StandardScaler` solo sobre train.
          Transformar train y test con ese mismo scaler.
        ]
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Data Leakage")
#sstitle("Target leakage y leakage temporal")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      #ssstitle[Target leakage]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        Una variable predictora contiene información que *solo se conoce
        después de que ocurre el evento* que se intenta predecir.
      ]

      #v(4pt)
      #styled-table(
        columns: (1fr, 1fr),
        th[Target],              th[Variable con leakage],
        td[Impago de crédito],   tdg[`días_en_mora` al momento del impago],
        td[Diagnóstico cáncer],  tdg[`biopsia_realizada`],
        td[Abandono de cliente], tdg[`última_llamada_soporte`],
      )

      #v(4pt)
      #text(fill: gry, size: 11pt)[
        El modelo aprende la consecuencia, no la causa.
        Funciona perfectamente en el histórico, falla en producción.
      ]
    ],
    [
      #ssstitle[Leakage temporal]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        En datos con dimensión temporal, la partición aleatoria mezcla
        observaciones pasadas y futuras en train y test.
      ]

      #v(4pt)
      #block(stroke: 1.5pt + cm1, inset: 7pt, radius: 4pt, width: 100%)[
        #text(size: 12pt)[
          *Regla:* el conjunto de test debe contener siempre
          observaciones *posteriores en el tiempo* a las de train.
          Ordenar por fecha antes de cualquier partición.
        ]
      ]

      #v(6pt)
      #text(fill: gry, size: 11pt)[
        Síntoma: accuracy excelente en validación, desempeño pobre en
        producción — especialmente si el dataset contiene columnas de fecha.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 6. IMPLEMENTACIÓN EN PYTHON
// ════════════════════════════════════════════════════════════════════════════
#section-divider("6", "Python", subtitle: "Implementación con scikit-learn")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Python")
#sstitle("Holdout y tres conjuntos")
#slide[
  #block(
    width: 100%, fill: rgb("#f0fdf4"),
    stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
    [
      #set text(size: 10pt)
      ```python
      from sklearn.model_selection import train_test_split

      # ── Holdout simple (train / test) ──────────────────────────────────────
      X_train, X_test, y_train, y_test = train_test_split(
          X, y,
          test_size=0.20,       # 20 % para test
          random_state=42,      # reproducibilidad
          stratify=y,           # mantener proporción de clases
      )

      # ── Tres conjuntos (train / validation / test) ─────────────────────────
      # Paso 1: separar test definitivo
      X_tmp, X_test, y_tmp, y_test = train_test_split(
          X, y, test_size=0.15, random_state=42, stratify=y
      )
      # Paso 2: separar validation del resto
      X_train, X_val, y_train, y_val = train_test_split(
          X_tmp, y_tmp, test_size=0.18, random_state=42, stratify=y_tmp
      )
      # Resultado: ~70 % train, ~15 % val, ~15 % test
      print(len(X_train), len(X_val), len(X_test))
      ```
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Python")
#sstitle("k-fold y preprocesamiento correcto")
#slide[
  #block(
    width: 100%, fill: rgb("#f0fdf4"),
    stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
    [
      #set text(size: 10pt)
      ```python
      from sklearn.model_selection import StratifiedKFold, cross_val_score
      from sklearn.pipeline import Pipeline
      from sklearn.preprocessing import StandardScaler
      from sklearn.linear_model import LogisticRegression

      # ── Pipeline: evita leakage en preprocesamiento ────────────────────────
      pipe = Pipeline([
          ("scaler", StandardScaler()),      # fit solo sobre train de cada fold
          ("model",  LogisticRegression()),
      ])

      # ── Stratified k-fold (k=10) ───────────────────────────────────────────
      cv = StratifiedKFold(n_splits=10, shuffle=True, random_state=42)

      scores = cross_val_score(pipe, X_train, y_train, cv=cv, scoring="roc_auc")

      print(f"AUC media:  {scores.mean():.3f}")
      print(f"AUC std:    {scores.std():.3f}")
      print(f"AUC por fold: {scores.round(3)}")
      ```
    ]
  )
  #v(6pt)
  #text(fill: gry, size: 11pt)[
    El `Pipeline` garantiza que el `StandardScaler` se ajusta *solo* sobre
    los datos de train de cada fold — nunca ve los datos de validación.
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Python")
#sstitle("Resumen — ¿qué estrategia usar?")
#slide[
  #styled-table(
    columns: (1fr, auto, auto, 1fr),
    th[Situación],                   th[Estrategia],       th[n recomendado], th[Nota],
    td[Dataset grande, un modelo],   tdg[Holdout 80/20],   tdg[> 5 000],      tdg[Rápido y suficiente],
    td[Comparar modelos],            tdg[Train/Val/Test],  tdg[> 2 000],      tdg[Val para tuning, test final],
    td[Dataset pequeño],             tdg[k-fold (k=10)],   tdg[< 1 000],      tdg[Estabilidad > velocidad],
    td[Muy pocos datos],             tdg[LOOCV],           tdg[< 100],        tdg[Sin sesgo, lento],
    td[Series de tiempo],            tdg[TimeSeriesSplit],  tdg[cualquiera],   tdg[Nunca aleatorio],
    td[Clases desbalanceadas],       tdg[Stratified],      tdg[cualquiera],   tdg[Siempre estratificar],
  )

  #v(8pt)
  #block(stroke: 1.5pt + cm1, inset: 7pt, radius: 4pt, width: 90%)[
    #text(size: 11pt)[
      *Regla de oro:* dividir los datos *antes* de cualquier
      exploración, transformación o selección de variables.
      El conjunto de test es sagrado — usarlo una sola vez, al final.
    ]
  ]
]

#pagebreak()
#align(center + horizon)[
  #text(fill: cm2, weight: "bold", size: 36pt)[Muchas Gracias]
  #v(16pt)
  #line(length: 30%, stroke: 2pt + cm1)
  #v(24pt)
  #text(fill: gry, size: 16pt)[
    Análisis de Datos Cualitativos \
    Partición de Datos · Train · Validation · Test · Cross-validation
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
