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
  "Regresión Logística",
  "Clasificación binaria · Métricas · Curva ROC",
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
  + Motivación — límites de la regresión lineal con respuestas binarias
  + Función logística y formulación del modelo
  + Estimación e inferencia \
    #text(fill: gry, size: 12pt)[Verosimilitud · Supuestos · Algoritmo IRLS]
  + Ajuste del modelo — ejemplo con el dataset *survey* \
    #text(fill: gry, size: 12pt)[Train/test split · Predicción binaria]
  + Evaluación del clasificador \
    #text(fill: gry, size: 12pt)[Matriz de confusión · Sensibilidad · Especificidad · Métricas]
  + Curva ROC y AUC \
    #text(fill: gry, size: 12pt)[Construcción paso a paso · Umbral de decisión · Calibración]
  + Comparación de métricas
]

// ════════════════════════════════════════════════════════════════════════════
// 1. MOTIVACIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Motivación", subtitle: "Límites de la regresión lineal")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Motivación")
#sstitle("Variables dependientes categóricas")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      Los modelos lineales trabajan con variables dependientes *continuas*.

      #v(4pt)
      Muchas preguntas en investigación tienen respuesta *binaria*:

      #v(3pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Variable],    th[Categorías],
        td[Enfermedad],  tdg[Sí / No],
        td[Resultado],   tdg[Éxito / Fracaso],
        td[Sexo],        tdg[Masculino / Femenino],
        td[Defecto],     tdg[Presente / Ausente],
      )

      #v(4pt)
      #text(fill: gry, size: 12pt)[
        La regresión lineal puede producir predicciones *fuera del rango*
        $[0, 1]$, lo que impide interpretar los valores como probabilidades.
      ]
    ],
    align(center + horizon)[
      #figure(image("images/logistic_vs_linear.png", height: 195pt))
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Motivación")
#sstitle("¿Por qué no funciona la regresión lineal?")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 18pt,
    [
      #ssstitle[Problema 1 — valores fuera de rango]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        La recta puede predecir valores $hat(Y) < 0$ o $hat(Y) > 1$, sin
        interpretación como probabilidades.
      ]

      #v(6pt)
      #ssstitle[Problema 2 — supuestos violados]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        Con respuesta binaria los residuos *no son normales* ni tienen
        varianza constante (heterocedasticidad estructural). Las inferencias
        sobre los coeficientes se invalidan.
      ]

      #v(6pt)
      #ssstitle[Solución — función logística]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        Modelar directamente $P(Y=1 | bold(X))$ con una función que mapee
        cualquier valor real al intervalo $(0, 1)$ y que sea lineal en los
        predictores tras una transformación adecuada.
      ]
    ],
    [
      #block(stroke: 2pt + cm3, inset: 10pt, radius: 5pt, width: 100%)[
        #text(size: 13pt)[
          En el dataset *survey* queremos predecir el *sexo* del estudiante
          (Male/Female) a partir de:
        ]
        #v(4pt)
        #set list(marker: [#text(fill: cm3)[▸]])
        - Altura (cm)
        - Pulso (latidos/min)
        - Tamaño de la mano de escritura (cm)

        #v(6pt)
        #text(fill: gry, size: 12pt)[
          154 observaciones completas de 237 estudiantes de
          la Universidad de Adelaide.
        ]
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 2. FUNCIÓN LOGÍSTICA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Función Logística", subtitle: "Formulación del modelo")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Función Logística")
#sstitle("La función logística")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      La *función logística* (sigmoide) transforma cualquier valor real a $(0, 1)$:

      #v(4pt)
      $ sigma(eta) = frac(1, 1 + e^(-eta)) $

      #v(2pt)
      #text(size: 12pt)[donde $eta = alpha + beta X$ es el *predictor lineal*.]

      #v(4pt)
      #table(
        stroke: none,
        inset: 4pt,
        fill: (col, row) => if row == 0 { cm2 } else if calc.odd(row) { rgb("#f0f4f4") } else { white },
        columns: (auto, 1fr),
        th[$eta$],         th[$sigma(eta)$],
        td[$-infinity$],   tdg[$approx 0$],
        td[$-2$],          tdg[$approx 0.12$],
        td[$0$],           tdg[$= 0.5$],
        td[$+2$],          tdg[$approx 0.88$],
        td[$+infinity$],   tdg[$approx 1$],
      )

      #v(3pt)
      #text(fill: gry, size: 12pt)[
        Forma de *S*, simétrica alrededor de $eta = 0$.
      ]
    ],
    align(center + horizon)[
      #figure(image("images/logistic_vs_linear.png", height: 180pt))
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Función Logística")
#sstitle("El modelo logístico")
#slide[
  El modelo expresa la *probabilidad de la clase positiva* como:

  #v(3pt)
  $ P(Y=1 | bold(X)) = frac(1, 1 + e^{-(alpha + beta_1 X_1 + dots + beta_p X_p)}) $

  #v(4pt)
  #grid(
    columns: (1.1fr, 1fr),
    gutter: 16pt,
    [
      #ssstitle[Función de enlace — logit]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        Tomando el logaritmo del cociente de probabilidades:
      ]
      #v(2pt)
      $ "logit"(p) = ln frac(p, 1-p) = alpha + sum_(j=1)^p beta_j X_j $

      #v(3pt)
      #text(fill: gry, size: 12pt)[
        El logit toma cualquier valor real $(-infinity, +infinity)$ mientras
        que $p in (0,1)$. Permite aplicar estimación lineal a clasificación.
      ]
    ],
    [
      #block(stroke: 2pt + cm3, inset: 8pt, radius: 5pt, width: 100%)[
        #text(size: 13pt, fill: cm2, weight: "bold")[Codificación de Y]
        #v(3pt)
        #text(fill: gry, size: 12pt)[
          La variable dependiente debe ser *0/1*:
          - Female → 1 (evento)
          - Male → 0 (no-evento)

          #v(2pt)
          El modelo estima $P(Y = 1 | bold(X))$: probabilidad
          de pertenecer a la categoría codificada como 1.
        ]
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 3. ESTIMACIÓN E INFERENCIA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Estimación e inferencia", subtitle: "Verosimilitud · Supuestos · IRLS")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Estimación e inferencia")
#sstitle("Estimación por máxima verosimilitud")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      Los coeficientes se obtienen *maximizando la verosimilitud*: la
      probabilidad de observar los datos bajo el modelo.

      #v(4pt)
      #ssstitle[Función de log-verosimilitud]
      #v(3pt)
      $ ell(bold(beta)) = sum_(i=1)^n [y_i ln hat(p)_i + (1-y_i) ln(1-hat(p)_i)] $

      #v(4pt)
      #text(fill: gry, size: 12pt)[
        - Si $y_i = 1$: contribuye con $ln hat(p)_i$; si $y_i = 0$: con $ln(1-hat(p)_i)$.
        - El máximo se busca numéricamente con el algoritmo *IRLS*
          (equivalente a Newton-Raphson).
        - A diferencia de OLS, *no existe solución analítica cerrada*.
      ]
    ],
    [
      #block(stroke: 2pt + cm1, inset: 7pt, radius: 5pt, width: 100%)[
        #text(size: 12pt, fill: cm2, weight: "bold")[¿Por qué no OLS?]
        #v(2pt)
        #text(fill: gry, size: 11pt)[
          Minimizar cuadrados con respuesta binaria no tiene justificación
          probabilística. Bajo $Y_i tilde "Bernoulli"(p_i)$, MLE es el
          estimador óptimo (consistente, asintóticamente eficiente).
        ]
      ]
      #v(4pt)
      #block(stroke: 2pt + cm3, inset: 7pt, radius: 5pt, width: 100%)[
        #text(size: 12pt, fill: cm2, weight: "bold")[Convergencia]
        #v(2pt)
        #text(fill: gry, size: 11pt)[
          El algoritmo puede *no converger* si una variable separa
          completamente las clases (separación perfecta): los coeficientes
          divergen a infinito.
        ]
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Estimación e inferencia")
#sstitle("Supuestos del modelo")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      #set text(size: 12pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Supuesto],             th[Descripción],
        td[Respuesta binaria],
          tdg[$Y_i in {0, 1}$, independientes entre sí],
        td[Linealidad en el logit],
          tdg[Relación lineal entre predictores y el *logit* de $p$, no con $p$ directamente],
        td[Independencia],
          tdg[Observaciones no correlacionadas (sin datos longitudinales ni agrupados sin corrección)],
        td[Sin multicolinealidad],
          tdg[Los predictores no deben estar altamente correlacionados],
        td[Tamaño muestral],
          tdg[Al menos 10–20 eventos por predictor incluido],
      )
    ],
    [
      #ssstitle[Lo que NO se requiere]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        A diferencia de la regresión lineal, la regresión logística *no exige*:
        #v(3pt)
        - Normalidad de los residuos
        - Homocedasticidad
        - Distribución normal de los predictores

        #v(4pt)
        Esto la hace más robusta para datos binarios en contextos
        donde la regresión lineal falla estructuralmente.
      ]
    ],
  )
]


// ════════════════════════════════════════════════════════════════════════════
// ════════════════════════════════════════════════════════════════════════════
// 5. AJUSTE DEL MODELO
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "Ajuste del modelo", subtitle: "Dataset survey · Train/test split")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Ajuste del modelo")
#sstitle("Dataset survey")
#slide[
  #grid(
    columns: (1fr, 1.8fr),
    gutter: 20pt,
    [
      #text(size:14pt)[
      *Fuente:* Encuesta a *237 estudiantes* de la Universidad de Adelaide (Australia).

      #v(6pt)
      *Observaciones completas:* 154

      #v(6pt)
      *Variable objetivo:* `Sex` — sexo del estudiante, codificado como :
      
      - *0* = Male
      - *1* = Female.

      ]
    ],
    [
      #styled-table(
        columns: (0.5fr, 1fr),
        th[*Variable*], th[*Descripción*],
        td[`Sex`],     td[Sexo (Male / Female) — *target*],
        td[`Wr.Hnd`],  td[Envergadura mano escritora (cm)],
        td[`NW.Hnd`],  td[Envergadura mano no escritora (cm)],
        td[`W.Hnd`],   td[Mano dominante (Left / Right)],
        td[`Fold`],    td[Forma de cruzar los brazos],
        td[`Pulse`],   td[Frecuencia cardíaca (lpm)],
        td[`Clap`],    td[Mano encima al aplaudir],
        td[`Exer`],    td[Frecuencia de ejercicio],
        td[`Smoke`],   td[Hábito de fumar],
        td[`Height`],  td[Estatura (cm)],
        td[`M.I`],     td[Sistema de medición (Metric / Imperial)],
        td[`Age`],     td[Edad (años)],
      )
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Ajuste del modelo")
#sstitle("Regresión lineal vs logística en los datos")
#slide[
  #grid(
    columns: (1fr, 1.2fr),
    gutter: 16pt,
    [
      #text(size: 13pt)[
        Para el dataset *survey* usamos *Altura* como único predictor para
        visualizar la diferencia entre ambos modelos.
      ]
      #v(5pt)
      #text(fill: gry, size: 12pt)[
        La regresión lineal ajusta una recta que sale del rango $[0,1]$.
        La función logística se mantiene dentro del rango válido de
        probabilidades para cualquier valor de Altura.
      ]
      #v(6pt)
      #block(stroke: 1.5pt + cm3, inset: 8pt, radius: 4pt, width: 100%)[
        #text(size: 12pt)[
          $ P("Female" | "Height") = frac(1, 1 + e^{-(alpha + beta dot "Height")}) $

          #v(3pt)
          Los valores ajustados se interpretan como *probabilidades estimadas*,
          no como categorías. La clasificación requiere aplicar un umbral.
        ]
      ]
    ],
    align(center + horizon)[
      #figure(image("images/cell_06.png", height: 210pt))
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Ajuste del modelo")
#sstitle("Partición train/test y predicción")
#slide[
  #text(fill: cm1, size: 11pt)[
    _Ejemplo con el dataset survey — 154 observaciones completas, predictores: Height, Wr.Hnd, Pulse_
  ]
  #v(6pt)
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      #ssstitle[División de datos]
      #v(2pt)
      #text(fill: gry, size: 11pt)[
        Para estimar la capacidad predictiva real del modelo se divide el
        dataset en dos conjuntos mutuamente excluyentes:
      ]
      #v(2pt)
      #styled-table(
        columns: (auto, auto, 1fr),
        th[Partición], th[Fracción],        th[Uso],
        td[Train],     tdg[80 % (123 obs.)], tdg[Ajuste de coeficientes],
        td[Test],      tdg[20 % (31 obs.)],  tdg[Evaluación honesta del modelo],
      )
      #v(2pt)
      #text(fill: gry, size: 10pt)[
        Con n=154, el split simple es pequeño. En la práctica se prefiere
        *validación cruzada k-fold* para mayor estabilidad de las estimaciones.
      ]
    ],
    [
      #ssstitle[Umbral de decisión]
      #v(2pt)
      #text(fill: gry, size: 10pt)[
        El modelo produce $hat(p)_i in (0,1)$. Para clasificar:
        $ hat(Y)_i = cases(1 quad "si" hat(p)_i > tau, 0 quad "si" hat(p)_i lt.eq tau) $
        El umbral por defecto $tau = 0.5$ es solo una convención.
      ]
      #v(6pt)
      #ssstitle[Predictores del modelo]
      #v(2pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Variable], th[Descripción],
        td[Height],   tdg[Altura (cm)],
        td[Wr.Hnd],   tdg[Envergadura mano escritora (cm)],
        td[Pulse],    tdg[Pulso (lpm)],
      )
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Ajuste del modelo")
#sstitle("Código Python — ejemplo survey")
#slide[
  #block(
    width: 100%, fill: rgb("#f0fdf4"),
    stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
    [
      #set text(size: 10pt)
      ```python
      import pandas as pd
      from sklearn.linear_model import LogisticRegression
      from sklearn.model_selection import train_test_split
      from sklearn.preprocessing import LabelEncoder
      from sklearn.metrics import accuracy_score
      import statsmodels.api as sm

      # Carga y preparación
      df = sm.datasets.get_rdataset("survey", "MASS").data.dropna()
      df["Sex_bin"] = LabelEncoder().fit_transform(df["Sex"])   # 0=Male, 1=Female
      features = ["Height", "Wr.Hnd", "Pulse"]
      X = df[features]
      y = df["Sex_bin"]

      # División train/test estratificada
      X_train, X_test, y_train, y_test = train_test_split(
          X, y, test_size=0.2, random_state=42, stratify=y
      )

      # Ajuste
      model = LogisticRegression(max_iter=1000)
      model.fit(X_train, y_train)

      # Predicción y evaluación
      y_pred = model.predict(X_test)
      print(f"Accuracy: {accuracy_score(y_test, y_pred):.3f}")
      ```
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Ajuste del modelo")
#sstitle("Resultados del modelo — ejemplo survey")
#slide[
  #grid(
    columns: (1.15fr, 1fr),
    gutter: 20pt,
    [
      #ssstitle[Coeficientes estimados]
      #v(4pt)
      #styled-table(
        columns: (auto, auto, auto, auto, auto),
        th[Variable], th[β],       th[OR],    th[z],      th[p-valor],
        td[Intercept], tdg[-45.31], tdg[—],   tdg[-5.25], tdg[< 0.001],
        td[Height],    tdg[+0.202], tdg[1.22], tdg[4.01], tdg[< 0.001],
        td[Wr.Hnd],    tdg[+0.572], tdg[1.77], tdg[2.69], tdg[0.007],
        td[Pulse],     tdg[-0.004], tdg[1.00], tdg[-0.16], tdg[0.870],
      )
      #v(6pt)
      #text(fill: gry, size: 10pt)[
        *Height* y *Wr.Hnd* son predictores significativos (p < 0.01).
        *Pulse* no aporta evidencia de efecto ($p = 0.87$).
      ]
    ],
    [
      #ssstitle[Bondad de ajuste]
      #v(4pt)
      #styled-table(
        columns: (1fr, auto),
        th[Métrica],           th[Valor],
        td[McFadden R²],       tdg[0.516],
        td[Log-verosimilitud], tdg[-41.30],
        td[LLR p-valor],       tdg[6.2 × 10⁻¹⁹],
        td[Observaciones],     tdg[123 (train)],
      )
      #v(6pt)
      #ssstitle[Evaluación en test (n = 31)]
      #v(4pt)
      #styled-table(
        columns: (1fr, auto),
        th[Métrica],   th[Valor],
        td[Accuracy],  tdg[87.1 %],
        td[TN / FP],   tdg[15 / 1],
        td[FN / TP],   tdg[3 / 12],
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 6. EVALUACIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Evaluación", subtitle: "Matriz de confusión · Métricas")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Evaluación")
#sstitle("Matriz de confusión")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 18pt,
    [
      #text(size: 12pt)[
        La *matriz de confusión* cruza los valores reales con las predicciones,
        revelando el tipo de errores que comete el modelo.
      ]
      #v(4pt)
      #styled-table(
        columns: (auto, auto, auto),
        th[],                   th[Pred: 0 (Male)], th[Pred: 1 (Female)],
        td[Real: 0 (Male)],     tdg[TN = 17],       tdg[FP = 7],
        td[Real: 1 (Female)],   tdg[FN = 2],        tdg[TP = 20],
      )
      #v(4pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Término], th[Significado],
        td[TP], tdg[Female correctamente predicha como Female],
        td[TN], tdg[Male correctamente predicho como Male],
        td[FP], tdg[Male predicho erróneamente como Female],
        td[FN], tdg[Female predicha erróneamente como Male],
      )
    ],
    align(center + horizon)[
      #figure(image("images/confusion_matrix.png", height: 180pt))
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Evaluación")
#sstitle("Sensibilidad, especificidad y precisión")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      #ssstitle[Sensibilidad (Recall / TPR)]
      #v(2pt)
      #text(fill: gry, size: 12pt)[Proporción de positivos reales detectados:]
      $ "TPR" = frac(T P, T P + F N) $

      #v(4pt)
      #ssstitle[Especificidad (TNR)]
      #v(2pt)
      #text(fill: gry, size: 12pt)[Proporción de negativos reales correctamente identificados:]
      $ "TNR" = frac(T N, T N + F P) $

      #v(4pt)
      #text(fill: gry, size: 12pt)[
        Sensibilidad y especificidad son *complementarias*:
        aumentar una generalmente reduce la otra.
        La *FPR = 1 − Especificidad* se grafica en la curva ROC.
      ]
    ],
    [
      #ssstitle[Precisión (PPV)]
      #v(2pt)
      #text(fill: gry, size: 12pt)[De los predichos positivos, ¿cuántos son realmente positivos?]
      $ "PPV" = frac(T P, T P + F P) $

      #v(4pt)
      #ssstitle[Valor predictivo negativo (NPV)]
      #v(2pt)
      #text(fill: gry, size: 12pt)[De los predichos negativos, ¿cuántos son realmente negativos?]
      $ "NPV" = frac(T N, T N + F N) $

      #v(4pt)
      #block(stroke: 1.5pt + cm1, inset: 7pt, radius: 4pt, width: 100%)[
        #text(size: 11pt)[
          PPV y NPV dependen de la *prevalencia* de la clase positiva.
          Con clases desbalanceadas pueden ser engañosos aunque TPR y TNR
          sean altos.
        ]
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Evaluación")
#sstitle("Métricas compuestas")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      #ssstitle[Accuracy]
      #v(2pt)
      #text(fill: gry, size: 12pt)[Proporción total de aciertos — útil solo con clases balanceadas:]
      $ "Acc" = frac(T P + T N, T P + T N + F P + F N) $

      #v(4pt)
      #ssstitle[F1-Score]
      #v(2pt)
      #text(fill: gry, size: 12pt)[Media armónica de sensibilidad y precisión:]
      $ F_1 = frac(2 T P, 2 T P + F P + F N) = frac(2 dot "TPR" dot "PPV", "TPR" + "PPV") $

      #v(3pt)
      #text(fill: gry, size: 12pt)[
        Penaliza por igual los FP y FN. Preferible a accuracy con desbalance.
      ]
    ],
    [
      #ssstitle[MCC (Matthews Correlation Coefficient)]
      #v(2pt)
      $ "MCC" = frac(T P dot T N - F P dot F N, sqrt((T P+F P)(T P+F N)(T N+F P)(T N+F N))) $
      #v(2pt)
      #text(fill: gry, size: 12pt)[
        Tiene en cuenta los cuatro elementos de la matriz. Rango $[-1, 1]$:
        - $+1$: predicción perfecta
        - $0$: equivalente al azar
        - $-1$: predicción perfectamente inversa
        #v(3pt)
        Es la métrica más robusta para clases *muy desbalanceadas*: no
        puede inflarse prediciendo siempre la clase mayoritaria.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Evaluación")
#sstitle("Efecto del umbral de decisión")
#slide[
  #grid(
    columns: (1fr, 1.4fr),
    gutter: 16pt,
    [
      #text(size: 13pt)[
        El umbral $tau$ controla el balance entre *sensibilidad* y
        *especificidad* (TPR y TNR).
      ]
      #v(5pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Umbral],     th[Consecuencia],
        td[Bajo $tau$], tdg[↑ TPR (más positivos detectados), ↓ TNR (más FP)],
        td[Alto $tau$], tdg[↓ TPR (más FN), ↑ TNR (más negativos correctos)],
      )
      #v(6pt)
      #text(fill: gry, size: 12pt)[
        La elección del umbral depende del *costo relativo* de cada tipo de error:
        - Diagnóstico de cáncer → umbral *bajo* (priorizar no perder casos)
        - Detección de spam → umbral *alto* (no bloquear correo legítimo)
        #v(4pt)
        $tau = 0.5$ maximiza accuracy solo cuando los costos son iguales
        y las clases están balanceadas.
      ]
    ],
    align(center + horizon)[
      #figure(image("images/threshold_effect.png", height: 195pt))
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 7. CURVA ROC Y AUC
// ════════════════════════════════════════════════════════════════════════════
#section-divider("6", "Curva ROC y AUC", subtitle: "Construcción · Interpretación · Calibración")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Curva ROC y AUC")
#sstitle("Construcción de la curva ROC")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      #text(size: 13pt)[
        La curva *ROC* resume el desempeño del clasificador a
        *todos los umbrales posibles*, graficando FPR vs TPR.
      ]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        *Procedimiento:*
        + Ordenar las predicciones de mayor a menor probabilidad.
        + Para cada umbral calcular TPR $= T P/(T P + F N)$ y FPR $= F P/(F P + T N)$.
        + Graficar FPR (eje X) vs TPR (eje Y).
      ]
      #v(5pt)
      #styled-table(
        columns: (auto, auto, auto, auto),
        th[Pred], th[Etiq.], th[TPR],  th[FPR],
        tdg[0.9], td[TRUE],  tdg[0.25], tdg[0.00],
        tdg[0.8], td[FALSE], tdg[0.25], tdg[0.25],
        tdg[0.7], td[TRUE],  tdg[0.50], tdg[0.25],
        tdg[0.6], td[FALSE], tdg[0.50], tdg[0.50],
        tdg[0.5], td[TRUE],  tdg[0.75], tdg[0.50],
        tdg[0.4], td[TRUE],  tdg[1.00], tdg[0.50],
      )
    ],
    align(center + horizon)[
      #figure(image("images/cell_15.png", height: 210pt))
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Curva ROC y AUC")
#sstitle("AUC — Área bajo la curva")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(size: 13pt)[
        El *AUC* resume la capacidad *discriminatoria* del modelo en un único
        número, independiente del umbral elegido.
      ]
      #v(3pt)
      #text(fill: gry, size: 12pt)[
        *Interpretación:* probabilidad de que el modelo asigne mayor probabilidad
        a una observación positiva que a una negativa aleatoria.
        $ "AUC" = P(hat(p)_+ > hat(p)_-) $
      ]
      #v(3pt)
      #styled-table(
        columns: (auto, 1fr),
        th[AUC],       th[Interpretación],
        td[$= 1.0$],   tdg[Discriminación perfecta],
        td[$> 0.9$],   tdg[Excelente],
        td[$0.7–0.9$], tdg[Bueno],
        td[$0.5–0.7$], tdg[Moderado],
        td[$= 0.5$],   tdg[Sin capacidad discriminatoria (azar)],
        td[$< 0.5$],   tdg[Peor que el azar],
      )
      #v(2pt)
      #text(fill: gry, size: 12pt)[Para el modelo *survey*: AUC $approx 0.903$.]
    ],
    align(center + horizon)[
      #figure(image("images/cell_17.png", height: 205pt))
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Curva ROC y AUC")
#sstitle("Comparación de curvas ROC")
#slide[
  #grid(
    columns: (1.1fr, 1fr),
    gutter: 16pt,
    [
      #text(size: 13pt)[
        Comparar curvas ROC permite evaluar distintos modelos sobre el mismo
        conjunto de datos sin fijar un umbral.
      ]
      #v(5pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Curva],                 th[Descripción],
        td[Clasificador perfecto], tdg[Sube a (0,1) y luego a (1,1). AUC = 1],
        td[Modelo ejemplo],        tdg[Curva suave por encima de la diagonal. AUC ≈ 0.90],
        td[Azar],                  tdg[Diagonal — TPR = FPR para todo umbral. AUC = 0.5],
      )
      #v(5pt)
      #block(stroke: 1.5pt + cm3, inset: 8pt, radius: 4pt, width: 100%)[
        #text(size: 12pt)[
          El AUC es *robusto al desbalance* entre clases y no requiere
          fijar un umbral, a diferencia de accuracy, F1 o MCC.
          Es ideal para comparar modelos en la etapa de selección.
        ]
      ]
    ],
    align(center + horizon)[
      #figure(image("images/roc_comparison.png", height: 210pt))
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Curva ROC y AUC")
#sstitle("Calibración del modelo")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 14pt,
    [
      #text(size: 13pt)[
        Un modelo puede tener buen AUC pero *probabilidades mal calibradas*:
        predice $hat(p) = 0.9$ cuando la probabilidad real es $0.6$.
      ]
      #v(3pt)
      #ssstitle[¿Qué es la calibración?]
      #v(2pt)
      #text(fill: gry, size: 12pt)[
        Un modelo está bien calibrado si, entre las observaciones a
        las que asigna probabilidad $hat(p) = q$, aproximadamente una
        fracción $q$ son realmente positivas.
      ]
      #v(3pt)
      #ssstitle[Curva de calibración (reliability diagram)]
      #v(2pt)
      #text(fill: gry, size: 12pt)[
        Grafica $hat(p)$ promedio (eje X) vs fracción de positivos observados
        (eje Y). Calibración perfecta cae sobre la diagonal.
      ]
    ],
    [
      #block(stroke: 2pt + cm1, inset: 8pt, radius: 5pt, width: 100%)[
        #text(size: 13pt, fill: cm2, weight: "bold")[Discriminación ≠ Calibración]
        #v(3pt)
        #text(fill: gry, size: 12pt)[
          - *Discriminación* (AUC): ¿el modelo distingue positivos de negativos?
          - *Calibración*: ¿las probabilidades son numéricamente correctas?
          #v(3pt)
          Ambas son necesarias. En medicina, la calibración es crítica
          porque las probabilidades se usan para decisiones clínicas,
          no solo para ordenar pacientes.
          #v(3pt)
          *Prueba de Hosmer-Lemeshow:* test formal de calibración.
          Divide observaciones en deciles de riesgo predicho y compara
          con la frecuencia observada mediante $chi^2$.
        ]
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 8. COMPARACIÓN DE MÉTRICAS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("7", "Comparación", subtitle: "¿Cuándo usar cada métrica?")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Comparación de métricas")
#sstitle("Resumen de métricas")
#slide[
  #set text(size: 11pt)
  #styled-table(
    columns: (0.8fr, 0.8fr, 1.5fr, 1.5fr),
    rows: 35pt,
    th[Métrica], th[Definición], th[Ventajas], th[Desventajas],
    td[Accuracy],
      tdg[#align(horizon+center)[$(T P+T N)/"total"$]],
      tdg[Fácil de interpretar],
      tdg[Engañosa con clases desbalanceadas],
    td[Sensibilidad (TPR)],
      tdg[#align(horizon+center)[$(T P)/(T P+F N)$]],
      tdg[Ideal si no se quieren omitir positivos],
      tdg[No refleja falsos positivos],
    td[Especificidad (TNR)],
      tdg[#align(horizon+center)[$(T N)/(T N+F P)$]],
      tdg[Cuantifica correcta identificación de negativos],
      tdg[No informa sobre la clase positiva],
    td[Precisión (PPV)],
      tdg[#align(horizon+center)[$(T P)/(T P+F P)$]],
      tdg[Útil si FP son muy costosos],
      tdg[Depende de la prevalencia],
    td[F1-Score],
      tdg[#align(horizon+center)[$(2 T P)/(2 T P+F P+F N)$]],
      tdg[Equilibra FP y FN; funciona en desbalance],
      tdg[Ignora verdaderos negativos],
    td[AUC-ROC],
      tdg[#align(horizon+center)[$P(hat(p)_+ > hat(p)_-)$]],
      tdg[Independiente del umbral; robusto],
      tdg[No mide calibración],
    td[MCC],
      tdg[#align(horizon+center)[$(T P dot T N - F P dot F N)/sqrt(dots)$]],
      tdg[Muy robusto con desbalance; usa toda la matriz],
      tdg[Menos intuitivo],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Comparación de métricas")
#sstitle("¿Cuándo usar cada métrica?")
#slide[
  #set text(size: 13pt)
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      #styled-table(
        columns: (auto, 1fr),
        rows: 25pt,
        th[Contexto],               th[Métrica recomendada],
        td[Clases balanceadas],     tdg[Accuracy o F1],
        td[Clases desbalanceadas],  tdg[MCC o AUC],
        td[FP muy costosos],        tdg[Especificidad o Precisión (PPV)],
        td[FN muy costosos],        tdg[Sensibilidad (TPR)],
        td[Comparar modelos],       tdg[AUC],
        td[Umbral no fijado],       tdg[AUC o MCC],
        td[Probabilidades clínicas], tdg[Calibración + AUC],
      )
    ],
    [
      #block(stroke: 2pt + cm3, inset: 10pt, radius: 5pt, width: 100%)[
        #text(size: 13pt, fill: cm2, weight: "bold")[Regla práctica]
        #v(5pt)
        #text(fill: gry, size: 12pt)[
          - Nunca reportar una sola métrica.
          - Incluir siempre la *matriz de confusión*.
          - El *AUC* es el punto de partida más robusto para comparar.
          - El *MCC* es preferible con clases muy desbalanceadas.
          - Verificar la *calibración* si las probabilidades serán usadas
            para tomar decisiones, no solo para ranking.
          - El umbral $tau = 0.5$ es una convención: *ajustarlo* según
            el costo relativo de FP y FN en el problema específico.
        ]
      ]
    ],
  )
]

#pagebreak()
#align(center + horizon)[
  #text(fill: cm2, weight: "bold", size: 36pt)[Muchas Gracias]
  #v(16pt)
  #line(length: 30%, stroke: 2pt + cm1)
  #v(24pt)
  #text(fill: gry, size: 16pt)[
    Análisis de Datos Cualitativos \
    Regresión Logística · Clasificación binaria · Curva ROC
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
