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
    text(fill: cm2, weight: "light", size: 12pt, tracking: 5pt)[#upper(main)]
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
    rect(fill: cm2, width: 28%, height: 100%))
  place(left + top, dx: 0pt, dy: 0pt,
    rect(fill: cm1, width: 28%, height: 4pt))
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
  bottom + right, dx: 15pt, dy: 15pt,
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
        #text(fill: cm2, size: 20pt, tracking: 2pt, weight: "thin")[#upper(comment_line)]
      ]
      #place(bottom + center)[#block(width: 100%, height: 18%, fill: white)]
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
  "Naive Bayes y k-Nearest Neighbors",
  "Análisis de Datos Cualitativos",
  "2026",
)

// ════════════════════════════════════════════════════════════════════════════
// ÍNDICE
// ════════════════════════════════════════════════════════════════════════════
#counter-display
#stitle("Unidad III", sub: "Contenidos")
#sstitle("Índice")
#slide[
  #set text(size: 17pt)
  #set par(leading: 1.1em)
  + Marco general — dos enfoques complementarios
  + *Naive Bayes* — fundamento y teorema de Bayes
  + Naive Bayes Gaussiano — predictores continuos
  + Naive Bayes Categórico — variables nominales
  + Suavizado de Laplace
  + *k-Nearest Neighbors* — idea y efecto de $k$
  + Selección de $k$ por validación cruzada
  + Normalización en kNN
  + Comparación de clasificadores
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 1 — MARCO GENERAL
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Marco general", subtitle: "Naive Bayes · kNN · dos enfoques")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Marco general")
#sstitle("Dos enfoques complementarios")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Naive Bayes]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        *Enfoque probabilístico generativo.*

        Modela $P(bold(x) | C_k)$ — cómo se distribuyen los datos
        dentro de cada clase — y aplica Bayes para clasificar.

        #v(8pt)
        - Muy eficiente con datos escasos. \
        - Natural para variables *categóricas*. \
        - Asume independencia entre predictores.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[k-Nearest Neighbors]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        *Enfoque no paramétrico por similitud.*

        No asume ninguna distribución. Clasifica por votación
        entre los $k$ puntos más cercanos en el espacio de features.

        #v(8pt)
        - No hay fase de "entrenamiento". \
        - Muy flexible, captura formas complejas. \
        - Sensible a la escala de los predictores.
      ]
    ],
  )
  #v(12pt)
  #text(fill: gry, size: 14pt)[
    Ambos son complementarios a LDA/QDA: Naive Bayes extiende
    la lógica probabilística a predictores *categóricos* y *mixtos*;
    kNN ofrece una alternativa *libre de supuestos distribucionales*.
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 2 — NAIVE BAYES FUNDAMENTO
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Naive Bayes", subtitle: "Teorema de Bayes · supuesto de independencia")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Naive Bayes")
#sstitle("Fundamento — teorema de Bayes")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 18pt,
    [
      El clasificador parte del teorema de Bayes:

      $ P(C_k | bold(x)) = frac(P(bold(x) | C_k), P(bold(x))) P(C_k) $

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Como $P(bold(x))$ es igual para todas las clases,
        basta comparar el numerador:
      ]

      $ P(C_k | bold(x)) prop P(bold(x) | C_k) dot P(C_k) $

      #v(10pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Término], th[Nombre y rol],
        td[$P(C_k | bold(x))$], tdg[*Posterior* — lo que queremos maximizar],
        td[$P(bold(x) | C_k)$], tdg[*Verosimilitud* — qué tan probable es $bold(x)$ en la clase $k$],
        td[$P(C_k)$],           tdg[*Prior* — proporción de la clase en los datos],
      )
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[El supuesto "naive"]
      #v(8pt)
      #text(size: 15pt)[
        Naive Bayes asume que los predictores son
        *condicionalmente independientes* dada la clase:
      ]

      $ P(bold(x) | C_k) = product_(j=1)^p P(x_j | C_k) $

      #v(10pt)
      #text(fill: gry, size: 14pt)[
        Esto permite estimar cada $P(x_j | C_k)$ por separado,
        con muy pocos datos — incluso si $p$ es grande.

        #v(8pt)
        El supuesto es "ingenuo" porque en la práctica los
        predictores suelen correlacionar. Sin embargo, el
        clasificador funciona bien incluso cuando se viola.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Naive Bayes")
#sstitle("Variantes según el tipo de predictor")
#slide[
  #styled-table(
    columns: (auto, 1fr, 1fr, 1fr),
    th[Variante], th[Distribución asumida para $P(x_j | C_k)$], th[Tipo de predictor], th[Uso típico],
    td[`GaussianNB`],     tdg[Normal — $cal(N)(mu_(k j), sigma_(k j)^2)$], tdg[Continuo],  tdg[Medidas biométricas, sensores],
    td[`CategoricalNB`],  tdg[Frecuencias relativas por categoría],         tdg[Nominal],   tdg[Encuestas, variables cualitativas],
    td[`MultinomialNB`],  tdg[Multinomial — proporciones de conteos],       tdg[Conteos],   tdg[Frecuencias de palabras (texto)],
    td[`BernoulliNB`],    tdg[Bernoulli — presencia / ausencia],            tdg[Binario],   tdg[Variables 0/1, texto (bag of words)],
  )
  #v(14pt)
  #text(fill: gry, size: 14pt)[
    La elección de la variante depende exclusivamente del *tipo de predictor*,
    no de la variable respuesta (que siempre es categórica en clasificación).
    En la práctica, un dataset puede mezclar tipos — se aplica la variante
    correspondiente a cada columna y se multiplican las verosimilitudes.
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 3 — GAUSSIANNB
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "GaussianNB", subtitle: "Predictores continuos · fronteras curvas")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "GaussianNB")
#sstitle("Modelo y regiones de decisión")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      Para cada predictor $j$ y clase $k$, GaussianNB estima:

      $ P(x_j | C_k) = frac(1, sigma_(k j) sqrt(2 pi))
          exp lr((-frac((x_j - mu_(k j))^2, 2 sigma_(k j)^2))) $

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        A diferencia de LDA:
        - Cada clase tiene su *propia* $sigma_(k j)$ por predictor. \
        - La matriz de covarianza implícita es *diagonal* (independencia). \
        - Las fronteras resultantes son *cuadráticas* — similares a QDA
          pero con menos parámetros (sin covarianzas cruzadas).
      ]
      #v(8pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from sklearn.naive_bayes import GaussianNB

          gnb = GaussianNB()
          gnb.fit(X, y)

          gnb.theta_    # μ_kj — media por clase y feature
          gnb.var_      # σ²_kj — varianza por clase y feature
          ```
        ]
      )
    ],
    [
      #align(center+horizon)[
        #figure(image("images/c034_gnb_regions.png", height: 285pt))
      ]
      #text(fill: gry, size: 13pt)[
        Las cruces marcan las medias $bold(mu)_k$.
        Las regiones reflejan la forma gaussiana de cada clase.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "GaussianNB")
#sstitle("GaussianNB vs. LDA vs. QDA")
#slide[
  #align(center)[
    #figure(image("images/c034_comparison_frontiers.png", height: 240pt))
  ]
  #v(6pt)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 12pt,
    block(stroke: 1pt + cm2, inset: 10pt, radius: 4pt)[
      #text(fill: cm2, weight: "bold", size: 13pt)[LDA]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        $bold(Sigma)$ compartida. \
        Frontera *lineal*. \
        Menos parámetros.
      ]
    ],
    block(stroke: 1pt + grn, inset: 10pt, radius: 4pt)[
      #text(fill: grn, weight: "bold", size: 13pt)[GaussianNB]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        $bold(Sigma)_k$ diagonal. \
        Frontera *cuadrática*. \
        Ignora covarianzas cruzadas.
      ]
    ],
    block(stroke: 1pt + cm3, inset: 10pt, radius: 4pt)[
      #text(fill: cm3, weight: "bold", size: 13pt)[QDA]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        $bold(Sigma)_k$ completa. \
        Frontera *cuadrática*. \
        Modela correlaciones.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 4 — CATEGORICALNB
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "CategoricalNB", subtitle: "Variables nominales · tablas de frecuencia")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "CategoricalNB")
#sstitle("Modelo para variables categóricas")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      Para cada valor $v$ de la variable $j$, CategoricalNB estima
      la probabilidad condicional como *frecuencia relativa*:

      $ P(x_j = v | C_k) = frac(n_(k,j,v), n_k) $

      #v(8pt)
      #text(fill: gry, size: 14pt)[donde $n_(k,j,v)$ = observaciones de clase $k$ con $x_j = v$.]
      #v(10pt)
      #text(size: 15pt)[
        *Ejemplo — ¿jugar al tenis?*
      ]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Dataset clásico con 4 predictores categóricos \
        (Tiempo, Temperatura, Humedad, Viento) \
        y clase binaria (Jugar: Sí / No).
      ]
      #v(8pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from sklearn.naive_bayes import CategoricalNB
          from sklearn.preprocessing import OrdinalEncoder

          enc = OrdinalEncoder()
          X_enc = enc.fit_transform(df.iloc[:, :-1])

          cnb = CategoricalNB(alpha=1.0)
          cnb.fit(X_enc, y)
          ```
        ]
      )
    ],
    [
      #align(center+horizon)[
        #figure(image("images/c034_categorical_nb_probs.png", height: 270pt))
      ]
      #text(fill: gry, size: 13pt)[
        Cada barra es $P(x_j = v | C_k)$.
        Por ejemplo: $P("Tiempo"="Soleado" | "Jugar=No") approx 0.6$
        — cuando no se juega, suele hacer sol.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "CategoricalNB")
#sstitle("Clasificar un nuevo caso")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 18pt,
    [
      #ssstitle[Caso nuevo a clasificar]
      #v(6pt)
      #styled-table(
        columns: (auto, auto),
        th[Variable], th[Valor],
        td[Tiempo],      tdg[Soleado],
        td[Temperatura], tdg[Fría],
        td[Humedad],     tdg[Alta],
        td[Viento],      tdg[Fuerte],
      )
      #v(12pt)
      #text(size: 15pt)[Aplicando Naive Bayes:]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        $ P("Sí" | bold(x)) prop P("Sol"|"Sí") dot P("Fría"|"Sí") $
        $ times P("Alta"|"Sí") dot P("Fuerte"|"Sí") dot P("Sí") $
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Se calcula el mismo producto para la clase "No"
        y se asigna la clase con mayor valor.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Resultado con sklearn]
      #v(8pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          new_case = enc.transform(
              [["Soleado","Fría","Alta","Fuerte"]])

          cnb.predict(new_case)
          # → [0]  (No jugar)

          cnb.predict_proba(new_case)
          # → [[0.657, 0.343]]
          #   P(No)=65.7%  P(Sí)=34.3%
          ```
        ]
      )
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        El modelo predice *No jugar*: la combinación
        de sol intenso con viento fuerte y alta humedad
        tiene baja probabilidad en la clase "Sí".
      ]
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        `predict_proba` devuelve probabilidades normalizadas
        para ambas clases — suma a 1.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 5 — LAPLACE
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Suavizado de Laplace", subtitle: "Evitar probabilidades cero")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Suavizado de Laplace")
#sstitle("El problema de las frecuencias cero")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 18pt,
    [
      Si una combinación (valor, clase) *no aparece* en los datos
      de entrenamiento, su frecuencia estimada es 0:

      $ P(x_j = v | C_k) = 0 $

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Al multiplicar las verosimilitudes, *un solo cero
        hace colapsar toda la probabilidad posterior* de esa clase
        — sin importar los demás predictores.
      ]

      #v(10pt)
      #text(size: 15pt)[*Solución: suavizado de Laplace*]
      #v(4pt)

      $ P(x_j = v | C_k) = frac(n_(k,j,v) + alpha, n_k + alpha dot |V_j|) $

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Símbolo], th[Significado],
        td[$alpha$],   tdg[Pseudo-conteo añadido a cada combinación (default = 1)],
        td[$|V_j|$],   tdg[Número de categorías distintas del predictor $j$],
      )
    ],
    [
      #align(center+horizon)[
        #figure(image("images/c034_laplace_effect.png", height: 220pt))
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Con $alpha$ muy pequeño, la estimación es más "fiel" a los datos
        pero frágil ante combinaciones no vistas. Con $alpha$ grande,
        la probabilidad se aplana hacia la uniforme.
        #v(6pt)
        En la práctica, $alpha = 1$ (suavizado de Laplace clásico)
        es un buen punto de partida.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 6 — kNN IDEA Y EFECTO DE K
// ════════════════════════════════════════════════════════════════════════════
#section-divider("6", "k-Nearest Neighbors", subtitle: "Clasificación por similitud · efecto de k")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "kNN")
#sstitle("Idea central")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 18pt,
    [
      kNN es *no paramétrico*: no ajusta ningún modelo.
      Para clasificar un punto nuevo $bold(x)$:

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Paso], th[Acción],
        td[1], tdg[Calcular la distancia de $bold(x)$ a *todos* los puntos de entrenamiento],
        td[2], tdg[Seleccionar los $k$ puntos más cercanos (*vecinos*)],
        td[3], tdg[Asignar la *clase mayoritaria* entre esos $k$ vecinos],
      )
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        No hay fase de entrenamiento propiamente dicha —
        el modelo *es* el conjunto de datos.
        La distancia más común es la *euclídea*:
      ]
      $ d(bold(x), bold(x)') = sqrt(sum_(j=1)^p (x_j - x'_j)^2) $
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Otras distancias: Manhattan, Minkowski, Hamming (para variables categóricas).
      ]
    ],
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Implementación]
      #v(8pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from sklearn.neighbors import (
              KNeighborsClassifier)

          knn = KNeighborsClassifier(
              n_neighbors=5,
              metric="euclidean"  # default
          )
          knn.fit(X_train, y_train)

          knn.predict(X_new)
          knn.predict_proba(X_new)
          # fracción de vecinos de cada clase
          ```
        ]
      )
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        `predict_proba` devuelve la *proporción* de vecinos
        de cada clase — no una probabilidad probabilística
        como en Naive Bayes.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "kNN")
#sstitle("Efecto del hiperparámetro k")
#slide[
  #align(center)[
    #figure(image("images/c034_knn_k_effect.png", height: 265pt))
  ]
  #v(4pt)
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    block(stroke: 2pt + cm3, inset: 10pt, radius: 4pt)[
      #text(weight: "bold", fill: cm3)[k pequeño (k = 1)]
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Frontera muy irregular. Cada punto de entrenamiento
        define su propia región → *sobreajuste* (high variance).
        El modelo memoriza el ruido.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 10pt, radius: 4pt)[
      #text(weight: "bold", fill: cm1)[k grande (k = 50)]
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Frontera muy suave. Promedia demasiado →
        *subajuste* (high bias). Ignora patrones locales
        reales en los datos.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 7 — SELECCIÓN DE K
// ════════════════════════════════════════════════════════════════════════════
#section-divider("7", "Selección de k", subtitle: "Validación cruzada · sesgo–varianza")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Selección de k")
#sstitle("Validación cruzada para elegir k")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size: 15pt)[
        La elección óptima de $k$ se hace midiendo el rendimiento
        sobre datos *no vistos* durante el entrenamiento.
        La *validación cruzada k-fold* divide el conjunto de
        entrenamiento en $f$ partes iguales:
      ]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Paso], th[Acción],
        td[1], tdg[Dividir los datos de entrenamiento en $f$ folds],
        td[2], tdg[Entrenar con $f-1$ folds, evaluar en el fold restante],
        td[3], tdg[Repetir $f$ veces rotando el fold de validación],
        td[4], tdg[Promediar las $f$ accuracies → CV accuracy],
        td[5], tdg[Elegir el $k$ que maximiza el CV accuracy],
      )
      #v(8pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from sklearn.model_selection import cross_val_score

          cv = cross_val_score(
              KNeighborsClassifier(n_neighbors=k),
              X_train, y_train, cv=5
          ).mean()
          ```
        ]
      )
    ],
    [
      #align(center+horizon)[
        #figure(image("images/c034_knn_cv.png", height: 255pt))
      ]
      #text(fill: gry, size: 13pt)[
        La curva de train accuracy (azul) decrece con $k$ —
        el modelo se simplifica. La CV accuracy (naranja) tiene
        un máximo: ese es el $k$ óptimo.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 8 — NORMALIZACIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("8", "Normalización en kNN", subtitle: "Escala de predictores · z-score")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Normalización en kNN")
#sstitle("Por qué la escala importa")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      kNN clasifica por *distancia*. Si dos predictores tienen
      escalas muy distintas, el de mayor escala domina el cálculo
      y los demás se vuelven irrelevantes.

      #v(10pt)
      #text(fill: gry, size: 14pt)[
        *Ejemplo:* $X_1$ en centímetros (rango 0–200),
        $X_2$ en kilogramos (rango 0–100). \
        Una diferencia de 1 cm equivale a 1 unidad de distancia,
        igual que 1 kg — aunque 1 cm es mucho menos significativo.
      ]

      #v(10pt)
      #text(size: 15pt)[*Solución: estandarización z-score*]

      $ z_j = frac(x_j - mu_j, sigma_j) $

      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from sklearn.preprocessing import StandardScaler
          from sklearn.pipeline import Pipeline

          pipe = Pipeline([
              ("scaler", StandardScaler()),
              ("knn",    KNeighborsClassifier(k))
          ])
          pipe.fit(X_train, y_train)
          ```
        ]
      )
    ],
    [
      #align(center+horizon)[
        #figure(image("images/c034_knn_normalization.png", height: 260pt))
      ]
      #text(fill: gry, size: 13pt)[
        Sin normalizar (izquierda), $X_1$ domina la distancia
        y las fronteras son casi horizontales. Con normalización
        (derecha), ambos predictores contribuyen por igual.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 9 — COMPARACIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("9", "Comparación de clasificadores", subtitle: "LDA · QDA · Naive Bayes · kNN")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Comparación")
#sstitle("Accuracy en el mismo dataset")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #align(center)[
        #figure(image("images/c034_comparison_accuracy.png", height: 220pt))
      ]
      #text(fill: gry, size: 13pt)[
        Resultados sobre datos gaussianos con covarianzas distintas.
        Los resultados varían con el dataset — ningún método gana siempre.
      ]
    ],
    [
      #styled-table(
        columns: (auto, 1fr),
        th[Método], th[Característica principal],
        td[*LDA*],          tdg[Lineal, paramétrico, eficiente con $n$ pequeño],
        td[*QDA*],          tdg[Cuadrático, más flexible que LDA],
        td[*GaussianNB*],   tdg[Cuadrático, diagonal — rápido, asume independencia],
        td[*kNN (k=5)*],    tdg[No paramétrico, flexible pero lento en predicción],
        td[*kNN (k=15)*],   tdg[No paramétrico, más suavizado que k=5],
      )
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        *Regla práctica:* probar LDA primero como baseline.
        Si las fronteras no son lineales → QDA o GaussianNB.
        Si hay patrones muy locales o no gaussianos → kNN.
        Siempre usar validación cruzada para comparar.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Resumen")
#sstitle("Cuándo usar cada método")
#slide[
  #styled-table(
    columns: (1fr, 1fr, 1fr, 1fr),
    th[Situación], th[Naive Bayes], th[kNN], th[LDA / QDA],
    td[Variables categóricas],
    tdg[`CategoricalNB` — directo],
    tdg[Con distancia de Hamming],
    tdg[Requiere codificación dummy],
    td[Dataset pequeño],
    tdg[Muy eficiente — pocos parámetros],
    tdg[Funciona bien],
    tdg[LDA es el más estable],
    td[Fronteras no lineales],
    tdg[GaussianNB — cuadrático],
    tdg[Muy flexible con k pequeño],
    tdg[QDA],
    td[Alta dimensionalidad],
    tdg[Eficiente — independencia],
    tdg[Lento ($O(n dot p)$ por predicción)],
    tdg[LDA reduce dimensión],
    td[Interpretabilidad],
    tdg[Alta — tablas de probabilidad],
    tdg[Baja — "caja negra" local],
    tdg[Alta — coeficientes lineales],
  )
  #v(10pt)
  #text(fill: gry, size: 14pt)[
    *Nota:* estos métodos no son excluyentes — en la práctica
    se prueban varios y se elige por validación cruzada.
    La elección final depende del dataset, no de preferencias teóricas.
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
    Métodos de clasificación — Naive Bayes y kNN
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
