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
  "Unidad II",
  "Reducción de dimensiones",
  "PCA · t-SNE · UMAP · MCA",
  "Análisis de Datos Cualitativos",
  "2026",
)

// ════════════════════════════════════════════════════════════════════════════
// ÍNDICE
// ════════════════════════════════════════════════════════════════════════════
#counter-display
#stitle("Unidad II", sub: "Contenidos")
#sstitle("Índice")
#slide[
  #set text(size: 17pt)
  #set par(leading: 1.1em)
  + El problema de la alta dimensionalidad
  + Análisis de Componentes Principales (PCA)
  + t-SNE — Visualización no lineal
  + UMAP — Reducción topológica
  + MDS — Escalamiento Multidimensional
  + Análisis de Correspondencias Múltiples (MCA)
  + Comparación entre métodos
]

// ════════════════════════════════════════════════════════════════════════════
// 1. EL PROBLEMA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Alta dimensionalidad", subtitle: "El problema que intentamos resolver")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Alta dimensionalidad")
#sstitle("Muchas variables")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      En muchos conjuntos de datos tenemos *muchas variables*:

      #v(8pt)
      #text(fill: gry, size: 15pt)[
        - *Datos biomédicos:* cientos de biomarcadores \
        - *Imagen:* miles de píxeles \
        - *Texto:* miles de palabras \
        - *Datos sociales o financieros:* decenas o cientos de indicadores
      ]
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Esto genera dificultades]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Modelos lentos o inestables \
        - Variables redundantes \
        - Mucho ruido \
        - Dificultad para *visualizar* \
        - Riesgo de *sobreajuste* (overfitting)
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Alta dimensionalidad")
#sstitle("¿Qué es la reducción de dimensiones?")
#slide[
  #v(10pt)
  #align(center)[
    #block(stroke: 2pt + cm3, inset: 20pt, radius: 6pt, width: 85%)[
      #text(size: 20pt)[
        "Resumir un conjunto grande de variables en un conjunto más pequeño,
        conservando la mayor parte de la *información relevante*."
      ]
    ]
  ]
  #v(2pt)
  #slide[
    #text(fill: gry, size: 15pt)[
      No eliminan datos sin más, sino que los *comprimen*. Permiten encontrar
      la estructura subyacente de los datos con menos variables.
    ]
    #v(2pt)
    #styled-table(
      columns: (auto, 1fr),
      th[Método],
      th[Tipo de datos],
      td[*PCA*],
      tdg[Numéricos continuos — maximiza varianza],
      td[*t-SNE*],
      tdg[Continuos — preserva estructura local],
      td[*UMAP*],
      tdg[Continuos — preserva estructura local y global],
      td[*MCA*],
      tdg[Categóricos — extiende PCA a variables nominales],
    )
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// 2. PCA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "PCA", subtitle: "Análisis de Componentes Principales")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "PCA")
#sstitle("Concepto")
#slide[
  PCA es un método de *reducción de dimensiones* que transforma muchas variables
  correlacionadas en un conjunto más pequeño de *componentes principales*.

  #v(12pt)
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 12pt,
    block(stroke: 2pt + cm3, inset: 12pt, radius: 5pt)[
      #ssstitle[Nuevas variables]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Combinaciones lineales de las originales.
      ]
    ],
    block(stroke: 2pt + cm2, inset: 12pt, radius: 5pt)[
      #ssstitle[No correlacionadas]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Ortogonales entre sí — sin redundancia.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 12pt, radius: 5pt)[
      #ssstitle[Ordenadas]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Por importancia: cuánta variación explica cada una.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "PCA")
#sstitle("Motivación — variables correlacionadas")
#slide[
  #grid(
    columns: (1fr, 1.8fr),
    gutter: 16pt,
    [
      #text(size: 12pt)[
        Imaginemos datos de personas con estas variables:
      ]

      #v(6pt)
      #text(fill: gry, size: 12pt)[
        - *altura*
        - *peso*
        - *tamaño de ropa*
      ]
      #text(size: 12pt)[
        Estas tres variables están *correlacionadas*. \
        Una combinación de ellas resume la información importante
        — por ejemplo: *"tamaño corporal"*.
      ]

      #text(fill: gry, size: 14pt)[
        Mucha variación = mucha información. \
        Poca variación = ruido o redundancia.
      ]
    ],
    align(center + horizon)[
      #image("images/pca_scatter_corr.png", height: 135pt)
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "PCA")
#sstitle("Proyección en dimensiones individuales")
#slide[
  #text(fill: gry, size: 15pt)[
    Supongamos datos en 2D donde queremos detectar grupos,
    pero solo podemos observar *una dimensión a la vez*.
  ]
  #v(10pt)
  #figure(image("images/pca_1d_projection.png", height: 185pt))
  #v(6pt)
  #text(fill: gry, size: 14pt)[
    Observando X o Y por separado, los grupos se superponen y son difíciles de separar.
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "PCA")
#sstitle("Visión completa en 2D")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      Al ver los datos en *ambas dimensiones simultáneamente*,
      los grupos aparecen claramente.

      #v(10pt)
      #text(fill: gry, size: 14pt)[
        PCA encuentra *nuevas direcciones* que maximizan la separación.
        Las líneas punteadas muestran los dos nuevos ejes.
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Nueva dimensión 1: captura *la mayor variación* \
        - Nueva dimensión 2: captura el *residuo ortogonal*
      ]
    ],
    figure(image("images/pca_2d_directions.png", height: 300pt)),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "PCA")
#sstitle("Rotación y proyección")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      Al *rotar* los datos al nuevo sistema de coordenadas,
      la proyección sobre la primera dimensión *separa claramente los grupos*.

      #v(10pt)
      #text(fill: gry, size: 14pt)[
        La proyección en rojo sobre la nueva dimensión 1
        muestra dos grupos bien separados.
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Se pasó de 2 dimensiones a 1 sin perder
        la información de agrupamiento.
      ]
    ],
    figure(image("images/pca_rotated.png", height: 300pt)),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "PCA")
#sstitle("Componentes principales — definición formal")
#slide[
  PCA busca *nuevas direcciones (vectores)* — componentes principales — tales que:

  #v(8pt)
  #styled-table(
    columns: (auto, 1fr),
    th[Propiedad],
    th[Descripción],
    td[*Combinaciones lineales*],
    tdg[De las variables originales con pesos (cargas)],
    td[*Ortogonales*],
    tdg[Perpendiculares entre sí — sin correlación],
    td[*Máxima varianza*],
    tdg[Ordenadas de mayor a menor varianza explicada],
    td[*Autovectores*],
    tdg[De la matriz de covarianza de los datos centrados],
  )
  #v(10pt)
  #text(fill: gry, size: 14pt)[
    Si $A$ es la matriz de covarianza, un *autovector* $v$ satisface:
  ]
  $ A v = lambda v $
  #text(fill: gry, size: 14pt)[
    donde $lambda$ (autovalor) indica cuánta varianza se captura en esa dirección.
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "PCA")
#sstitle("PCA en Python — datos sintéticos")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      #block(
        width: 100%,
        fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3,
        inset: (x: 12pt, y: 8pt),
        radius: 4pt,
        text(size: 13pt)[
          ```python
          from sklearn import decomposition, preprocessing

          pca = decomposition.PCA(n_components=2)

          scale = preprocessing.StandardScaler()
          scale = scale.fit(data)
          data_scaled = scale.transform(data)

          fitted = pca.fit(data_scaled)
          transformed = fitted.transform(data_scaled)

          # Varianza explicada por cada componente
          fitted.explained_variance_ratio_
          ```
        ],
      )
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        Siempre estandarizar antes de aplicar PCA:
        variables con distintas unidades dominarían los componentes.
      ]
    ],
    figure(image("images/pca_2d_result.png", height: 240pt)),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "PCA")
#sstitle("PCA sobre el dataset Iris")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    figure(image("images/pca_iris.png", height: 220pt)), figure(image("images/pca_iris_loadings.png", height: 190pt)),
  )
  #v(4pt)
  #text(fill: gry, size: 13pt)[
    Izquierda: proyección en los dos primeros componentes — los grupos se separan bien.
    Derecha: cargas de cada variable en PC1 y PC2.
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// 3. t-SNE
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "t-SNE", subtitle: "t-Distributed Stochastic Neighbor Embedding")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "t-SNE")
#sstitle("Concepto")
#slide[
  t-SNE es un *método no lineal* diseñado para:

  #v(8pt)
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 10pt,
    block(stroke: 2pt + cm3, inset: 12pt, radius: 5pt)[
      #ssstitle[Visualización]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Proyecta datos de alta dimensión en *2D o 3D*.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 12pt, radius: 5pt)[
      #ssstitle[Estructura local]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Mantiene *vecinos cercanos juntos* en la proyección.
      ]
    ],
    block(stroke: 2pt + cm2, inset: 12pt, radius: 5pt)[
      #ssstitle[Clusters nítidos]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Separa claramente *grupos* que PCA puede no revelar.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "t-SNE")
#sstitle("Cómo funciona")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      #ssstitle[Paso 1 — Probabilidades en alta dimensión]
      #v(0pt)
      #text(fill: gry, size: 12pt)[
        Para cada par de puntos, calcula la probabilidad de ser vecinos
        mediante una gaussiana centrada en cada punto:
      ]
      $ p_(j|i) prop exp lr(( -frac(||x_i - x_j||^2, 2 sigma_i^2) )) $

      #v(0pt)
      #ssstitle[Paso 2 — Probabilidades en baja dimensión]
      #v(0pt)
      #text(fill: gry, size: 12pt)[
        En el espacio 2D usa una *distribución t-Student* (colas largas):
      ]
      $ q_(i j) prop frac(1, 1 + ||y_i - y_j||^2) $
    ],
    [
      #ssstitle[Paso 3 — Minimización KL]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Minimiza la *divergencia de Kullback–Leibler* entre ambas distribuciones:
      ]
      $ "KL"(P || Q) = sum_(i eq.not j) p_(i j) log frac(p_(i j), q_(i j)) $
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        ¿Por qué t-Student? Sus *colas largas* permiten separar clusters sin
        amontonar puntos distantes.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "t-SNE")
#sstitle("Resultado sobre Iris y características")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    figure(image("images/tsne_iris.png", height: 230pt)),
    [
      #v(10pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Aspecto],
        th[Descripción],
        td[*Fortaleza*],
        tdg[Excelente separación de clusters],
        td[*Fidelidad local*],
        tdg[Preserva muy bien la vecindad],
        td[*Estructura global*],
        tdg[Las distancias entre clusters NO son significativas],
        td[*Reproducibilidad*],
        tdg[Cada ejecución puede dar resultados distintos],
        td[*Velocidad*],
        tdg[Lento en datasets grandes],
      )
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        Hiperparámetro clave: *perplexity* (típicamente 5–50). \
        Usar `random_state` para reproducibilidad.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "t-SNE")
#sstitle("t-SNE en Python")
#slide[
  #block(
    width: 88%,
    fill: rgb("#f0fdf4"),
    stroke: 0.5pt + cm3,
    inset: (x: 12pt, y: 8pt),
    radius: 4pt,
    text(size: 14pt)[
      ```python
      from sklearn.manifold import TSNE
      from sklearn.preprocessing import StandardScaler

      scaler = StandardScaler()
      X_scaled = scaler.fit_transform(X)

      tsne = TSNE(
        n_components=2,
        perplexity=30,       # controla la noción de vecindad
        learning_rate=200,
        n_iter_without_progress=1000,
        random_state=42
      )
      X_tsne = tsne.fit_transform(X_scaled)
      ```
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 4. UMAP
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "UMAP", subtitle: "Uniform Manifold Approximation and Projection")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "UMAP")
#sstitle("Concepto")
#slide[
  UMAP es un método *topológico* que transforma datos de alta dimensión
  manteniendo tanto la *estructura local* como *parte de la global*.

  #v(12pt)
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 12pt,
    block(stroke: 2pt + cm3, inset: 12pt, radius: 5pt)[
      #ssstitle[Paso 1]
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Para cada punto, identificar sus *k vecinos más cercanos*
        y construir un grafo de proximidad local.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 12pt, radius: 5pt)[
      #ssstitle[Paso 2]
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Unir los grafos locales en una representación global
        que modela la *variedad subyacente*.
      ]
    ],
    block(stroke: 2pt + cm2, inset: 12pt, radius: 5pt)[
      #ssstitle[Paso 3]
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        *Optimización estocástica*: minimiza la diferencia entre
        el grafo original y el grafo en baja dimensión.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "UMAP")
#sstitle("Resultado sobre Iris y características")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    figure(image("images/umap_iris.png", height: 230pt)),
    [
      #v(10pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Aspecto],
        th[Descripción],
        td[*Velocidad*],
        tdg[Más rápido que t-SNE en datasets grandes],
        td[*Estructura global*],
        tdg[Preserva mejor que t-SNE],
        td[*Estabilidad*],
        tdg[Embeddings reproducibles con `random_state`],
        td[*Métricas*],
        tdg[Soporta distancias personalizadas],
        td[*Clustering*],
        tdg[Buen preprocesamiento para HDBSCAN],
      )
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        Hiperparámetros clave: `n_neighbors` (estructura local/global) \
        y `min_dist` (compacidad de los clusters).
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "UMAP")
#sstitle("Trustworthiness — confiabilidad")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      *Trustworthiness* mide qué tan confiable es el embedding:
      ¿los vecinos cercanos en 2D también eran cercanos en alta dimensión?

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Si el punto X tiene vecinos B, C, D… en alta dimensión,
        pero en la proyección aparece cerca de Y y Z que *no eran* sus vecinos,
        el embedding *introduce relaciones falsas*.
      ]
      #v(8pt)
      $ "Trustworthiness" in [0, 1] $
    ],
    [
      #v(10pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Valor],
        th[Interpretación],
        td[0.95–0.99],
        tdg[Excelente],
        td[0.90–0.95],
        tdg[Muy bueno],
        td[0.80–0.90],
        tdg[Aceptable — revisar parámetros],
        td[< 0.80],
        tdg[Distorsión excesiva],
      )
      #v(10pt)
      #block(
        width: 100%,
        fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3,
        inset: (x: 12pt, y: 8pt),
        radius: 4pt,
        text(size: 14pt)[
          ```python
          from sklearn.manifold import trustworthiness
          trust = trustworthiness(X_scaled, X_umap,
                                  n_neighbors=15)
          # Iris → 0.9716
          ```
        ],
      )
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "UMAP")
#sstitle("UMAP en Python")
#slide[
  #block(
    width: 88%,
    fill: rgb("#f0fdf4"),
    stroke: 0.5pt + cm3,
    inset: (x: 12pt, y: 8pt),
    radius: 4pt,
    text(size: 14pt)[
      ```python
      import umap
      from sklearn.preprocessing import StandardScaler

      scaler = StandardScaler()
      X_scaled = scaler.fit_transform(X)

      umap_model = umap.UMAP(
        n_neighbors=15,      # controla estructura local/global
        min_dist=0.1,        # controla compacidad de clusters
        n_components=2,      # proyectar a 2D
        metric="euclidean",
        random_state=42,
        n_jobs=1
      )
      X_umap = umap_model.fit_transform(X_scaled)
      ```
    ],
  )
  #v(6pt)
  #text(fill: gry, size: 13pt)[Instalar con: `pip install umap-learn`]
]

// ════════════════════════════════════════════════════════════════════════════
// 5. MDS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "MDS", subtitle: "Escalamiento Multidimensional")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "MDS")
#sstitle("Concepto")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      MDS busca ubicar los puntos en baja dimensión de manera que las
      *distancias entre ellos reflejen las distancias originales*.

      #v(10pt)
      #text(fill: gry, size: 14pt)[
        A diferencia de PCA, MDS opera directamente sobre una
        *matriz de distancias o disimilitudes* — no necesita las
        variables originales.
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Minimiza el *stress*: discrepancia entre distancias originales
        y distancias en el embedding.
      ]
      $ "Stress" = sqrt(frac(sum_(i<j)(d_(i j) - hat(d)_(i j))^2, sum_(i<j) d_(i j)^2)) $
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Dos variantes]
      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Variante], th[Qué preserva],
        td[*Métrico*],     tdg[Las distancias reales — equivalente a PCA con distancia euclidiana],
        td[*No métrico*],  tdg[Solo el *orden* de las distancias — útil para datos ordinales],
      )
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        El MDS no métrico es especialmente relevante cuando las
        disimilitudes son ordinales: no importa *cuánto* más lejos,
        sino *cuál es más lejos*.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "MDS")
#sstitle("Analogía geográfica")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      Si tenemos solo una *tabla de distancias entre ciudades*,
      MDS reconstruye un mapa aproximado.

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        No se necesitan las coordenadas originales —
        solo las distancias entre pares de puntos.
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        El mismo principio aplica a:
        - Similitud entre especies (matrices filogenéticas) \
        - Distancias entre proteínas (RMSD) \
        - Disimilitudes entre respuestas de encuesta \
        - Cualquier métrica de diferencia entre observaciones
      ]
    ],
    figure(image("images/mds_cities.png", height: 210pt)),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "MDS")
#sstitle("Resultado sobre Iris — métrico vs. no métrico")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Métrico]
      #v(4pt)
      #figure(image("images/mds_metric_iris.png", height: 220pt))
      #text(fill: gry, size: 12pt)[
        Preserva las distancias reales. \
        Con distancia euclidiana produce el mismo resultado que PCA.
      ]
    ],
    [
      #ssstitle[No métrico]
      #v(4pt)
      #figure(image("images/mds_nonmetric_iris.png", height: 220pt))
      #text(fill: gry, size: 12pt)[
        Solo preserva el *orden* de las distancias. \
        Más robusto con disimilitudes ordinales o no euclidianas.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "MDS")
#sstitle("Diagrama de Shepard — evaluar la calidad")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    figure(image("images/mds_shepard.png", height: 270pt)),
    [
      El *diagrama de Shepard* grafica distancias originales
      vs. distancias en el embedding.

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Puntos sobre la diagonal → distancias perfectamente preservadas. \
        - Dispersión elevada → el embedding distorsiona las relaciones.
      ]
      #v(10pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Stress], th[Interpretación],
        td[< 0.05], tdg[Excelente],
        td[0.05–0.10], tdg[Bueno],
        td[0.10–0.20], tdg[Aceptable],
        td[> 0.20], tdg[Representación pobre],
      )
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "MDS")
#sstitle("MDS en Python")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Desde datos crudos]
      #v(4pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from sklearn.manifold import MDS
          from sklearn.preprocessing import StandardScaler

          X_scaled = StandardScaler().fit_transform(X)

          # MDS métrico
          mds = MDS(n_components=2, metric=True,
                    random_state=42,
                    normalized_stress="auto")
          X_mds = mds.fit_transform(X_scaled)

          print("Stress:", mds.stress_)
          ```
        ]
      )
    ],
    [
      #ssstitle[Desde matriz de distancias]
      #v(4pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from sklearn.manifold import MDS
          import numpy as np

          # Matriz de distancias precalculada
          dist_matrix = np.array([...])

          mds = MDS(
            n_components=2,
            dissimilarity="precomputed",
            metric=False,   # no métrico
            random_state=42,
            normalized_stress="auto"
          )
          coords = mds.fit_transform(dist_matrix)
          ```
        ]
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 6. MCA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("6", "MCA", subtitle: "Análisis de Correspondencias Múltiples")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "MCA")
#sstitle("Concepto")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      *MCA* es el análogo de PCA para *variables categóricas*:

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Reduce dimensiones de *encuestas y tablas nominales*. \
        - Visualiza *asociaciones entre categorías*. \
        - Proyecta individuos y categorías en el *mismo plano*. \
        - Maximiza *inercia* (análogo categórico de varianza).
      ]
      #v(10pt)
      #ssstitle[Ejemplo de datos]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Variables como: Edad (joven/adulto/mayor), \
        Preferencia (A/B/C), Nivel educativo (bajo/medio/alto).
      ]
    ],
    [
      #ssstitle[Cómo funciona]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Paso],
        th[Descripción],
        td[*1. One-hot*],
        tdg[Cada categoría → columna binaria],
        td[*2. Co-ocurrencias*],
        tdg[$B = X^top X$ — qué categorías coinciden],
        td[*3. SVD*],
        tdg[Descomposición en valores singulares de la matriz normalizada],
        td[*4. Proyección*],
        tdg[Puntos para individuos Y categorías en el mismo plano],
      )
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "MCA")
#sstitle("Ejemplo — datos sintéticos")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      Simulamos 1000 proteínas con variables categóricas:

      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - *organism:* 4 categorías \
        - *disorder:* 4 niveles de desorden \
        - *localization:* 5 compartimentos celulares \
        - *llps:* rol en separación de fases \
        - *haslcregion* / *hasrnabindingdomain*
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Tres grupos con distribuciones diferentes.
        MCA recupera los grupos a partir de patrones de categorías.
      ]
    ],
    figure(image("images/mca_scatter.png", height: 280pt)),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "MCA")
#sstitle("Coordenadas de categorías")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      MCA asigna coordenadas a *cada categoría*, no solo a los individuos.

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Categorías que aparecen juntas en los mismos individuos
        quedan *cerca en el plano*.

        Categorías opuestas quedan *separadas*.

        Esto permite interpretar qué *contraste biológico o sociológico*
        captura cada dimensión.
      ]
    ],
    align(center + horizon)[
      #image("images/mca_col_coords.png", height: 280pt),
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "MCA")
#sstitle("MCA en Python")
#slide[
  #block(
    width: 88%,
    fill: rgb("#f0fdf4"),
    stroke: 0.5pt + cm3,
    inset: (x: 12pt, y: 8pt),
    radius: 4pt,
    text(size: 14pt)[
      ```python
      import prince

      mca = prince.MCA(n_components=6)
      fitted = mca.fit(df.iloc[:, 1:])       # solo variables categóricas
      transformed = mca.transform(df.iloc[:, 1:])

      # Varianza explicada por cada dimensión
      print(fitted.eigenvalues_summary)

      # Coordenadas de las categorías
      col_coords = fitted.column_coordinates(df.iloc[:, 1:])
      ```
    ],
  )
  #v(6pt)
  #text(fill: gry, size: 13pt)[Instalar con: `pip install prince`]
]

// ════════════════════════════════════════════════════════════════════════════
// 7. COMPARACIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("7", "Comparación", subtitle: "PCA · MCA · t-SNE · UMAP · MDS")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Comparación")
#sstitle("Tabla comparativa")
#slide[
  #set text(size: 10pt)
  #styled-table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
    th[Característica],
    th[PCA],
    th[MCA],
    th[t-SNE],
    th[UMAP],
    th[MDS],
    td[*Tipo*],
    tdg[Lineal],
    tdg[Lineal],
    tdg[No lineal, probabilístico],
    tdg[No lineal, topológico],
    tdg[Lineal / no lineal],
    td[*Datos de entrada*],
    tdg[Numéricos continuos],
    tdg[Categóricos (one-hot)],
    tdg[Continuos o embeddings],
    tdg[Continuos o embeddings],
    tdg[*Matriz de distancias*],
    td[*Objetivo*],
    tdg[Maximizar varianza],
    tdg[Patrones entre categorías],
    tdg[Preservar estructura local],
    tdg[Local y parcialmente global],
    tdg[Preservar distancias],
    td[*Preserv. local*],
    tdg[Baja–media],
    tdg[Baja],
    tdg[Excelente],
    tdg[Muy buena],
    tdg[Buena],
    td[*Preserv. global*],
    tdg[Alta],
    tdg[Media],
    tdg[Muy baja],
    tdg[Moderada],
    tdg[Alta],
    td[*Velocidad*],
    tdg[Muy rápida],
    tdg[Rápida],
    tdg[Lenta],
    tdg[Rápida],
    tdg[Media],
    td[*Interpretabilidad*],
    tdg[Alta],
    tdg[Alta],
    tdg[Nula],
    tdg[Baja],
    tdg[Media],
    td[*Optimiza*],
    tdg[Varianza explicada],
    tdg[Inercia],
    tdg[KL Divergence],
    tdg[Preservación grafo k-NN],
    tdg[Stress],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Comparación")
#sstitle("¿Cuándo usar cada método?")
#slide[
  #set text(size: 11pt)
  #grid(columns: (1fr, 1fr, 1fr), rows: (150pt, 150pt), gutter: 8pt,
    block(stroke: 2pt + cm2, inset: 6pt, radius: 5pt, width: 100%, height: 100%)[
      #ssstitle[PCA]
      #v(2pt)
      #text(fill: gry)[
        - Preprocesamiento antes de modelado \
        - Eliminar redundancias en datos numéricos \
        - Explicar la contribución de cada variable \
        - Datos con estructura *lineal*
      ]
    ],
    block(stroke: 2pt + cm3, inset: 6pt, radius: 5pt, width: 100%, height: 100%)[
      #ssstitle[t-SNE]
      #v(2pt)
      #text(fill: gry)[
        - Visualización exploratoria de clusters \
        - Datos con estructura *no lineal* compleja \
        - Cuando la separación de grupos es la prioridad
      ]
    ],
    block(stroke: 2pt + grn, inset: 6pt, radius: 5pt, width: 100%, height: 100%)[
      #ssstitle[UMAP]
      #v(2pt)
      #text(fill: gry)[
        - Visualización + preprocesamiento para clustering \
        - Datasets grandes donde t-SNE es muy lento \
        - Cuando importa preservar *estructura global*
      ]
    ],
    block(stroke: 2pt + cm1, inset: 6pt, radius: 5pt, width: 100%, height: 100%)[
      #ssstitle[MCA]
      #v(2pt)
      #text(fill: gry)[
        - Análisis de encuestas y variables nominales \
        - Visualizar co-ocurrencias de categorías \
        - Clustering de datos categóricos
      ]
    ],
    block(stroke: 2pt + rgb("#7c3aed"), inset: 6pt, radius: 5pt, width: 100%, height: 100%)[
      #ssstitle[MDS]
      #v(2pt)
      #text(fill: gry)[
        - Solo se dispone de una *matriz de distancias* \
        - Datos ordinales → MDS no métrico \
        - Validar con diagrama de Shepard y stress
      ]
    ],
    block(fill: rgb("#00000000"), width: 100%, height: 100%)[],
  )
]

// ─── Fin ────────────────────────────────────────────────────────────────────
#pagebreak()
#align(center + horizon)[
  #text(fill: cm2, weight: "bold", size: 36pt)[Muchas Gracias]
  #v(16pt)
  #line(length: 30%, stroke: 2pt + cm1)
  #v(24pt)
  #text(fill: gry, size: 16pt)[
    Análisis de Datos Cualitativos \
    Reducción de dimensiones
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
