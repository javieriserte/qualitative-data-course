// ─── Configuración global ────────────────────────────────────────────────────
#set page(
  paper: "presentation-16-9",
  background: rect(fill: rgb("#f9f8f5"), width: 100%, height: 100%),
  margin: (x: 32pt, y: 26pt),
)
#set text(font: "Arial", size: 18pt, lang: "es", fill: rgb("#032e35"))
#set par(justify: false, leading: 0.7em)
#show math.equation: set text(size: 16pt)

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
  place(top + left,
    block(width: 100%, fill: rgb("#00000000"),
      inset: (x: 20pt, y: 9pt))[#content])
  v(50pt)
}

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

#let ssstitle(body) = text(fill: cm3, weight: "light", size: 18pt)[#body]

#let slide(body) = pad(left: 10%, body)

#let section-divider(number, title, subtitle: none) = {
  pagebreak()
  place(left + top, dx: 0pt, dy: 0pt,
    rect(fill: cm2, width: 28%, height: 100%)
  )
  place(left + top, dx: 0pt, dy: 0pt,
    rect(fill: cm1, width: 28%, height: 4pt)
  )
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
  ]
)

#let cover(main_title, second_title, comment_line, footer_left, footer_right) = {
  page(margin: (x: 0pt, y: 0pt),
    background: rect(fill: rgb("#f9f8f5"), width: 100%, height: 100%),
    [
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
  inset: 6pt,
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
  "Unidad III",
  "Métodos de clasificación",
  "Análisis Discriminante Lineal y Cuadrático",
  "Análisis de Datos Cualitativos",
  "2026",
)

// ════════════════════════════════════════════════════════════════════════════
// CONTENIDOS
// ════════════════════════════════════════════════════════════════════════════
#counter-display
#stitle("Unidad III", sub: "Contenidos")
#sstitle("Índice")
#slide[
  #set text(size: 17pt)
  #set par(leading: 1.1em)
  + Marco general: LDA y QDA
  + Modelo probabilístico y supuestos
  + Criterio de Fisher — intuición geométrica
  + LDA con dos clases · LDA con $K$ clases
  + Análisis Discriminante Cuadrático (QDA)
  + Variables categóricas — codificación dummy
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 1 — MARCO GENERAL
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Marco general", subtitle: "LDA · QDA · clasificación supervisada")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Marco general")
#sstitle("Clasificación supervisada")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[¿Qué queremos hacer?]
      #v(2pt)
      #text(size: 14pt)[
        Dado un conjunto de observaciones con *etiquetas de clase conocidas*,
        construir una regla que asigne nuevas observaciones a una clase.
      ]
      #v(2pt)
      #text(fill: gry, size: 14pt)[
        LDA y QDA son métodos *probabilísticos*: modelan cómo se
        distribuyen los datos dentro de cada clase y luego aplican
        el teorema de Bayes para clasificar.
      ]
      #v(2pt)
      #text(fill: gry, size: 14pt)[
        A diferencia de *PCA* (no supervisado, ignora etiquetas),
        LDA *usa las etiquetas* para orientar la proyección hacia la
        mejor separación entre clases.
      ]
    ],
    [
      #ssstitle[LDA vs. QDA — mapa de ruta]
      #v(8pt)
      #styled-table(
        columns: (1fr, 1fr, 1fr),
        th[Aspecto], th[LDA], th[QDA],
        td[Covarianza],
        tdg[Igual para todas las clases],
        tdg[Propia por clase],
        td[Frontera],
        tdg[Lineal],
        tdg[Cuadrática],
        td[Parámetros],
        tdg[Menos — más estable],
        tdg[Más — más flexible],
        td[Preferible cuando],
        tdg[$n$ pequeño o clases bien separadas],
        tdg[Varianzas muy distintas entre clases],
      )
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        Ambos métodos admiten predictores numéricos o categóricos
        (estos últimos requieren codificación previa).
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 2 — MODELO PROBABILÍSTICO
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Modelo probabilístico", subtitle: "Supuestos · Distribución normal multivariante")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Modelo probabilístico")
#sstitle("Supuestos de LDA")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size: 15pt)[
        LDA asume que los datos de *cada clase* provienen de una
        *distribución normal multivariante*:
      ]

      $ bold(x) | C_k tilde cal(N)(bold(mu)_k, bold(Sigma)) $

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Símbolo], th[Significado],
        td[$bold(mu)_k$],  tdg[Vector de medias de la clase $k$],
        td[$bold(Sigma)$], tdg[Matriz de covarianza *compartida* — igual para todas las clases],
        td[$bold(x)$],     tdg[Vector de observación a clasificar],
      )
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        El supuesto de $bold(Sigma)$ compartida es lo que hace que
        la frontera de decisión resulte *lineal*. Si cada clase
        tuviera su propia $bold(Sigma)_k$, la frontera sería
        cuadrática (→ QDA).
      ]
    ],
    [
      #ssstitle[Intuición: "campanas" por clase]
      #align(center)[
        #figure(image("images/cell_02.png", height: 220pt))
      ]
      #text(fill: gry, size: 10pt)[
        Cada clase es una campana gaussiana centrada en $bold(mu)_k$.
        Con la misma forma ($bold(Sigma)$ igual), la frontera entre
        ellas cae exactamente a la mitad — una recta.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Modelo probabilístico")
#sstitle("Por qué la frontera es lineal")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 18pt,
    [
      #text(size: 12pt)[
        LDA clasifica comparando el *log-ratio de verosimilitudes*
        entre las dos clases:
      ]
      $ log frac(P(C_1 | bold(x)), P(C_2 | bold(x))) = bold(w)^T bold(x) + c $

      #v(0pt)
      #text(fill: gry, size: 12pt)[
        Al expandir las densidades gaussianas con $bold(Sigma)$ igual,
        el término cuadrático $bold(x)^T bold(Sigma)^(-1) bold(x)$
        aparece en *ambas* y se *cancela* — queda solo un término
        lineal en $bold(x)$.
      ]
      #v(0pt)
      #text(size: 12pt)[La frontera es donde el log-ratio vale 0:]
      $ bold(w)^T bold(x) + c = 0 $
      #text(fill: gry, size: 12pt)[
        $bold(w) = bold(Sigma)^(-1)(bold(mu)_1 - bold(mu)_2)$ ·
        $c$ absorbe medias y priors.
      ]
      #v(0pt)
      #block(stroke: 2pt + cm1, inset: 10pt, radius: 4pt)[
        #text(fill: gry, size: 12pt)[
          *Si* $bold(Sigma)_1 eq.not bold(Sigma)_2$ (QDA):
          el término cuadrático *no se cancela*
          → frontera cuadrática (ver panel derecho, abajo).
        ]
      ]
    ],
    [
      #align(center)[
        #figure(image("images/lda_linear_boundary.png", width: 100%))
      ]
      #text(fill: gry, size: 12pt)[
        *Izquierda:* con $bold(Sigma)$ igual las elipses de nivel
        tienen la misma forma — el log-ratio cambia *linealmente*
        y la frontera (línea negra) es una recta. \
        *Derecha:* con $bold(Sigma)_k$ distintas las elipses difieren
        — el log-ratio es cuadrático y la frontera es una curva.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 3 — CRITERIO DE FISHER
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Criterio de Fisher", subtitle: "Intuición geométrica de la separación")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Criterio de Fisher")
#sstitle("Maximizar separación, minimizar dispersión")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 18pt,
    [
      #text(size: 15pt)[
        LDA busca la *dirección* $bold(w)$ que, al proyectar los datos,
        maximiza la distancia entre las medias de clase relativa
        a la dispersión interna:
      ]

      $ J(bold(w)) = frac(
          (bold(w)^T (bold(mu)_1 - bold(mu)_2))^2,
          bold(w)^T bold(S)_W bold(w)
        ) $

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Término], th[Significado],
        td[Numerador],   tdg[Distancia al cuadrado entre medias *proyectadas*],
        td[Denominador], tdg[Varianza interna de las clases tras proyectar],
        td[$bold(S)_W$], tdg[Matriz de dispersión intra-clase (*within-class*)],
      )
    ],
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Analogía intuitiva]
      #v(0pt)
      #text(fill: gry, size: 12pt)[
        Imaginar dos grupos de personas en una sala.
        Queremos encontrar la dirección en la que proyectar sus
        sombras tal que:

        #v(6pt)
        - Las sombras de *grupos distintos* queden *lo más separadas posible*. \
        - Las sombras de *un mismo grupo* queden *lo más juntas posible*.

        #v(8pt)
        Eso es exactamente lo que maximiza $J(bold(w))$.
      ]
      #v(10pt)
      #text(size: 12pt)[
        La solución óptima es:
        $ bold(w) prop bold(S)_W^(-1) (bold(mu)_1 - bold(mu)_2) $
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 4 — LDA DOS CLASES
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "LDA — Dos clases", subtitle: "Frontera lineal · sklearn")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "LDA — Dos clases")
#sstitle("Frontera de decisión")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:12pt)[
        En 2D, la frontera separadora es una *recta*:
      ]

      $ 0 = a + b_1 X_1 + b_2 X_2 $

      #text(size:12pt)[ Despejando $X_2$: ]

      $ X_2 = -frac(b_1, b_2) X_1 - frac(a, b_2) $

      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
        text(size: 10pt)[
          ```python
          from sklearn.discriminant_analysis import (
              LinearDiscriminantAnalysis)

          lda = LinearDiscriminantAnalysis()
          fitted = lda.fit(X, y)
          fitted.intercept_  # a
          fitted.coef_       # [b1, b2, ...]
          fitted.means_      # μ_k por clase
          ```
        ]
      )
      #text(fill: gry, size: 10pt)[
        Con dos clases en los datos de ejemplo:
        - a = 0.697 / b = [-16.66, -18.03]
        - mu1 = [0.99, 1.03] / mu2 = [-1.00, -0.94]
      ]
    ],
    [
      #align(center+horizon)[
        #figure(image("images/cell_13.png", height: 240pt))
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "LDA — Dos clases")
#sstitle("Predicción de nuevas observaciones")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Clasificar nuevos puntos]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          # Predecir etiquetas para nuevas obs.
          fitted.predict(X_new)
          # → array([1, 1, ..., 2, 2, ...])

          # Probabilidades a posteriori
          fitted.predict_proba(X_new)
          # → array([[0.99, 0.01], ...])
          ```
        ]
      )
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        El modelo asigna cada punto a la clase cuya distribución
        normal multivariante tiene mayor probabilidad *a posteriori*
        evaluada en ese punto.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Atributos del modelo ajustado]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Atributo], th[Contenido],
        td[`intercept_`], tdg[Ordenada al origen $a$],
        td[`coef_`],      tdg[Coeficientes $b_1, b_2, ...$ del hiperplano],
        td[`means_`],     tdg[Vector de medias $bold(mu)_k$ por clase],
        td[`priors_`],    tdg[Probabilidad a priori de cada clase],
        td[`scalings_`],  tdg[Vectores discriminantes (proyección de Fisher)],
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// LDA K CLASES
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4.1", "LDA — Más de dos clases", subtitle: "K fronteras · K hiperplanos")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "LDA — Más de dos clases")
#sstitle("K clases — K hiperplanos")
#slide[
  #grid(columns: (1fr, 1.9fr), gutter: 16pt,
    [
      #text(12pt)[
        Con $K$ clases, LDA ajusta *un hiperplano por clase*.
        Para la clase $k$:
      ]

      $ 0 = a_k + b_(k 1) X_1 + b_(k 2) X_2 $

      #v(0pt)
      #text(fill: gry, size: 10pt)[
        - Cada hiperplano separa la clase $k$ del *resto* (one-vs-rest). \
        - La región de decisión final surge de la *intersección*
          de los $K$ hiperplanos. \
        - Con 3 clases → 3 rectas separadoras; la cuarta figura
          muestra las tres superpuestas sobre todos los datos.
      ]
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 10pt)[
          ```python
          lda = LinearDiscriminantAnalysis()
          fitted = lda.fit(X, y)
          # coef_      → forma (K, n_features)
          # intercept_ → forma (K,)
          ```
        ]
      )
    ],
    [
      #align(center+horizon)[
        #figure(image("images/cell_14.png", height: 290pt))
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 5 — QDA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Análisis Discriminante Cuadrático", subtitle: "QDA — Fronteras curvas")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "QDA")
#sstitle("Generalización de LDA")
#slide[
  #grid(columns: (1fr, 1.4fr), gutter: 16pt,
    [
      #text(size:14pt)[
        QDA relaja el supuesto central de LDA: cada clase tiene
        su *propia* matriz de covarianza $bold(Sigma)_k$.
      ]

      $ bold(x) | C_k tilde cal(N)(bold(mu)_k, bold(Sigma)_k) $
      #v(0pt)
      #text(fill: gry, size: 10pt)[
        Al calcular el log-ratio de verosimilitudes, los términos
        cuadráticos $bold(x)^T bold(Sigma)_k^(-1) bold(x)$ *ya no se cancelan*
        → la frontera de decisión es una *cónica* (elipse, parábola,
        hipérbola según la geometría de las clases).
      ]
      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Parámetros extra], th[Consecuencia],
        td[Una $bold(Sigma)_k$ por clase], tdg[Modelo más flexible, necesita más datos],
        td[Frontera cuadrática],           tdg[Captura formas de separación no lineales],
      )
    ],
    [
      #ssstitle[Datos de ejemplo]
      #v(0pt)
      #align(center)[
        #figure(image("images/cell_17.png", height: 240pt))
      ]
      #text(fill: gry, size: 10pt)[
        Clase A (roja): $bold(Sigma) = 0.1 bold(I)$ · Clases B y C (azul): $bold(Sigma) = 0.2 bold(I)$.
        La clase A está rodeada → ninguna recta puede separarla correctamente.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "QDA")
#sstitle("Área de decisión y evaluación")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Implementación en Python]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 11pt)[
          ```python
          from sklearn.discriminant_analysis import (
              QuadraticDiscriminantAnalysis)
          from sklearn.model_selection import train_test_split

          train, test = train_test_split(data)

          qda = QuadraticDiscriminantAnalysis()
          fitted = qda.fit(train[:, [0,1]], train[:, 2])

          predicted = fitted.predict(test[:, [0,1]])

          accuracy = (predicted == test[:,2]).mean()
          # → 0.947  (94.7 %)
          ```
        ]
      )
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        `decision_function()` devuelve los *scores* por clase,
        útiles para visualizar el área de decisión punto a punto.
      ]
    ],
    [
      #ssstitle[Área de decisión visualizada]
      #v(6pt)
      #align(center)[
        #figure(image("images/cell_21.png", height: 250pt))
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 7 — VARIABLES CATEGÓRICAS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("6", "Variables categóricas", subtitle: "Codificación dummy · One-hot encoding")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Variables categóricas")
#sstitle("¿Y si los predictores son categóricos?")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
        LDA y QDA requieren predictores *numéricos*: internamente
        calculan medias, covarianzas y distancias. Las categorías
        como `"A1"` o `"B2"` no tienen un valor numérico intrínseco.
      ]

      #v(00pt)
      #text(fill: gry, size: 12pt)[
        La solución es la *codificación dummy* (one-hot encoding):
        por cada categoría se crea una columna booleana.
      ]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 10pt)[
          ```python
          import pandas as pd

          df_encoded = pd.get_dummies(df)

          lda = LinearDiscriminantAnalysis()
          lda.fit(df_encoded.iloc[:, 1:],
                  df_encoded["Group"])

          accuracy = (
              lda.predict(df_encoded.iloc[:, 1:])
              == df_encoded["Group"]
          ).mean()
          # → 85.71 %
          ```
        ]
      )
    ],
    [
      #ssstitle[Tabla original]
      #v(4pt)
      #align(center)[
        #scale(80%, reflow:true)[
          #styled-table(
            columns: (auto, auto, auto, auto),
            th[Group], th[VarA], th[VarB], th[VarC],
            td[0], tdg[A1], tdg[B1], tdg[C1],
            td[0], tdg[A1], tdg[B1], tdg[C2],
            td[0], tdg[A2], tdg[B1], tdg[C2],
            td[1], tdg[A1], tdg[B2], tdg[C1],
            td[1], tdg[A2], tdg[B1], tdg[C2],
            td[1], tdg[A2], tdg[B2], tdg[C1],
          )
        ]
      ]
      #v(10pt)
      #ssstitle[Tras codificación dummy]
      #v(4pt)
      #align(center)[
        #scale(80%, reflow:true)[
          #styled-table(
            columns: (auto, auto, auto, auto, auto, auto, auto),
            th[Grp], th[A1], th[A2], th[B1], th[B2], th[C1], th[C2],
            td[0], tdg[✓], tdg[✗], tdg[✓], tdg[✗], tdg[✓], tdg[✗],
            td[0], tdg[✓], tdg[✗], tdg[✓], tdg[✗], tdg[✗], tdg[✓],
            td[1], tdg[✓], tdg[✗], tdg[✗], tdg[✓], tdg[✓], tdg[✗],
            td[1], tdg[✗], tdg[✓], tdg[✗], tdg[✓], tdg[✗], tdg[✓],
          )
        ]
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// LIMITACIONES
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Resumen y limitaciones")
#sstitle("Cuándo usar cada método")
#slide[
  #styled-table(
    columns: (1fr, 1fr, 1fr),
    th[Situación], th[LDA], th[QDA],
    td[Muestra pequeña ($n$ bajo)],
    tdg[Preferible — menos parámetros, más estable],
    tdg[Riesgoso — puede sobreajustar],
    td[Clases con varianzas similares],
    tdg[Apropiado — supuesto se cumple],
    tdg[Funciona pero es innecesariamente complejo],
    td[Clases con varianzas muy distintas],
    tdg[Frontera incorrecta — supuesto violado],
    tdg[Preferible — modela cada clase por separado],
    td[Datos muy no gaussianos],
    tdg[Resultados poco confiables],
    tdg[Resultados poco confiables],
    td[Variables categóricas],
    tdg[Requiere codificación dummy previa],
    tdg[Requiere codificación dummy previa],
  )
  #v(10pt)
  #text(fill: gry, size: 14pt)[
    Cuando los supuestos gaussianos no se cumplen, considerar alternativas
    como *árboles de decisión*, *random forest* o *SVM*, que no asumen
    ninguna forma distribucional.
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// FIN
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#align(center+horizon)[
  #text(fill: cm2, weight: "bold", size: 36pt)[Muchas Gracias]
  #v(16pt)
  #line(length: 30%, stroke: 2pt + cm1)
  #v(24pt)
  #text(fill: gry, size: 16pt)[
    Análisis de Datos Cualitativos \
    Métodos de clasificación — LDA y QDA
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
