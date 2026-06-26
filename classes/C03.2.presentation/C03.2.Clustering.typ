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
  "Clustering",
  "Técnicas de agrupamiento jerárquico y no jerárquico",
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
  + Introducción al clustering
  + Clustering jerárquico
  + Métricas de enlace (*linkage*)
  + K-means
  + Elección del número de clusters — método del codo
  + DBSCAN
  + Elección del parámetro ε
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 1 — INTRODUCCIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Introducción", subtitle: "Grupos jerárquicos y no jerárquicos")

#pagebreak()
#counter-display
#stitle("Clustering", sub: "Introducción")
#sstitle("Dos familias de técnicas")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    block(stroke: 2pt + cm3, inset: 16pt, radius: 5pt)[
      #ssstitle[Jerárquicas]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Generan una estructura de *árbol* (dendrograma).
        #v(6pt)
        - En la *raíz*: un único grupo con todos los elementos.
        - Cada nodo se divide en *subgrupos* sucesivamente.
        - En las *hojas*: grupos terminales de un solo individuo.
        #v(6pt)
        No es necesario fijar el número de clusters de antemano.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 16pt, radius: 5pt)[
      #ssstitle[No jerárquicas]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Parten de los elementos *separados* y en pasos iterativos:
        #v(6pt)
        - Se toman elementos y se genera un nuevo grupo, o
        - se une el elemento a un grupo existente.
        #v(6pt)
        Requieren especificar el número de grupos de antemano
        (en la mayoría de los métodos).
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 2 — CLUSTERING JERÁRQUICO
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Clustering jerárquico", subtitle: "Aglomerativo · Divisivo · Dendrograma")

#pagebreak()
#counter-display
#stitle("Clustering", sub: "Jerárquico")
#sstitle("Concepto y estructura")
#slide[
  El *clustering jerárquico* construye un árbol llamado *dendrograma* que
  muestra cómo se organizan los datos en grupos a distintos niveles de detalle.

  #v(12pt)
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Ventajas principales]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - *No necesita fijar el número de clusters* de antemano.
        - Representa una *jerarquía completa*: grupos dentro de grupos.
        - El dendrograma permite elegir el corte después de ajustar el modelo.
      ]
    ],
    [
      #ssstitle[Aglomerativo vs. Divisivo]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Tipo], th[Estrategia],
        td[*Aglomerativo*], tdg[Bottom-up: cada punto empieza solo; se fusionan los más cercanos],
        td[*Divisivo*], tdg[Top-down: empieza con un cluster único y lo divide],
      )
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        El *aglomerativo* es mucho más popular por su eficiencia computacional.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Clustering", sub: "Jerárquico")
#sstitle("Algoritmo aglomerativo")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size: 12pt)[
        El proceso *bottom-up* es iterativo:
      ]
      #v(0pt)
      #set enum(numbering: "1.")
      #text(fill: gry, size: 10pt)[
        + Cada punto comienza en su *propio cluster*.
        + Se identifican los *dos clusters más cercanos* y se fusionan.
        + Se repite hasta formar *un único cluster*.
      ]
    ],
    [
      #text(fill: gry, size: 10pt)[
        El dendrograma crece *desde abajo hacia arriba*. \
        El *umbral de corte* (distancia) determina cuántos clusters
        se obtienen al final.
      ]
    ]
  )
  #ssstitle[Ejemplo — iris dataset]
  #v(0pt)
  #text(fill: gry, size: 10pt)[
    Dendrograma con método de Ward, umbral = 60:
  ]
  #v(0pt)
  #align(center)[
    #figure(image("images/cell_07.png", height: 150pt))
  ]
]

#pagebreak()
#counter-display
#stitle("Clustering", sub: "Jerárquico")
#sstitle("Resultado sobre Iris")
#slide[
  #grid(columns: (1fr, 1.8fr), gutter: 20pt,
    [
      #text(fill: gry, size: 12pt)[
        Los *marcadores* indican la especie real; el *color* el cluster asignado.
        #v(0pt)
        Con umbral = 60 y método Ward se obtienen *3 clusters*, que
        corresponden aproximadamente a las tres especies del dataset.
        #v(0pt)
        *setosa* queda perfectamente separada. \
        *versicolor* y *virginica* muestran cierta superposición en el
        espacio de características.
      ]
    ],
    [
      #align(center + horizon)[
        #figure(image("images/cell_08.png", height: 290pt))
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 3 — LINKAGE
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Métricas de enlace", subtitle: "Linkage — cómo medir distancia entre clusters")

#pagebreak()
#counter-display
#stitle("Clustering", sub: "Linkage")
#sstitle("Estrategias de enlace")
#slide[
  #text(size:12pt)[
    Para decidir qué clusters unir hay que definir la *distancia entre clusters*,
    no solo entre puntos.
  ]

  #scale(80%, reflow:true)[
  #styled-table(
    columns: (auto, 1fr, 1fr),
    th[Método], th[Definición], th[Característica],
    td[*Single linkage*],
    tdg[$ d(A,B) = min_(x in A, y in B) d(x,y) $],
    tdg[Par de puntos más cercanos. Tiende a clusters alargados ("efecto cadena")],
    td[*Complete linkage*],
    tdg[$ d(A,B) = max_(x in A, y in B) d(x,y) $],
    tdg[Par de puntos más lejanos. Clusters más compactos],
    td[*Average linkage*],
    tdg[Promedio de todas las distancias entre pares $(x in A, y in B)$],
    tdg[Equilibra single y complete],
    td[*Ward*],
    tdg[Minimiza el aumento en *varianza interna* al unir],
    tdg[Clusters esféricos y bien definidos. El más utilizado],
  )
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 4 — K-MEANS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "K-means", subtitle: "Clustering no supervisado · Centroides")

#pagebreak()
#counter-display
#stitle("Clustering", sub: "K-means")
#sstitle("Definición y objetivo")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      *K-means* divide los datos en *K clusters*, donde cada punto
      pertenece al cluster cuyo *centroide* está más cercano.

      #v(8pt)
      #text(fill: gry, size: 14pt)[Minimiza la suma de distancias al cuadrado dentro de cada cluster:]

      $ sum_(k=1)^(K) sum_(x_i in C_k) |x_i - mu_k|^2 $

      #text(fill: gry, size: 14pt)[
        donde $C_k$ es el cluster $k$ y $mu_k$ es su centroide.
      ]

      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Busca clusters *compactos y esféricos*. El resultado
        depende de la inicialización — K-means++ lo mejora significativamente.
      ]
    ],
    [
      #ssstitle[Ventajas]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        - Muy *rápido* y escalable.
        - Fácil de implementar e interpretar.
        - Ideal para datasets grandes con clusters esféricos.
      ]
      #v(10pt)
      #ssstitle[Desventajas]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        - Hay que elegir *K* de antemano.
        - No maneja bien *outliers*.
        - Asume clusters esféricos → falla con formas complejas.
        - Sensible a la inicialización.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Clustering", sub: "K-means")
#sstitle("Algoritmo — pasos")
#slide[
  #grid(columns: (1fr, 1.5fr), gutter: 20pt,
    [
      #text(size: 11pt)[*1. Inicializar*]
      #v(0pt)
      #text(fill: gry, size: 10pt)[Elegir *K centroides iniciales* (aleatorios o K-means++).]

      #v(0pt)
      #text(size: 11pt)[*2. Asignación*]
      #v(0pt)
      #text(fill: gry, size: 10pt)[Cada punto se asigna al centroide *más cercano*:]

      #align(center)[
        #scale(80%, reflow:true)[
          $ "cluster"(x_i) = arg min_k |x_i - mu_k| $
        ]
      ]
      #v(0pt)
      #text(size: 11pt)[*3. Actualización*]
      #v(0pt)
      #text(fill: gry, size: 10pt)[Recalcular cada centroide como el *promedio* de los puntos asignados:]
      #align(center)[
        #scale(80%, reflow:true)[
          $ mu_k = frac(1, |C_k|) sum_(x_i in C_k) x_i $
        ]
      ]
      #v(0pt)
      #text(size: 11pt)[*4. Repetir*]
      #v(0pt)
      #text(fill: gry, size: 10pt)[
        Volver a los pasos 2 y 3 hasta que:
        - los centroides ya no cambian, o
        - se alcanza el máximo de iteraciones.
      ]
    ],
    [
      #v(1pt)
      #ssstitle[Resultado sobre Iris]
      #v(0pt)
      #align(center)[
        #figure(image("images/cell_13.png", height: 270pt))
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 5 — MÉTODO DEL CODO
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Elección de K", subtitle: "Método del codo — Elbow method")

#pagebreak()
#counter-display
#stitle("Clustering", sub: "Elección de K")
#sstitle("Método del codo (Elbow Method)")
#slide[
  #grid(columns: (1fr, 1.6fr), gutter: 20pt,
    [
      #text(size:12pt)[
        Uno de los métodos más usados para elegir el valor óptimo de *K*:
      ]
      #v(0pt)
      #text(fill: gry, size: 10pt)[
        + Entrenar K-means para varios valores de $K$.
        + Calcular el *WCSS* (Within-Cluster Sum of Squares), también llamado *inertia*.
        + Graficar $K$ vs. WCSS.
        + Buscar el *punto donde la curva cambia de pendiente* abruptamente.
      ]

      #v(0pt)
      #text(fill: gry, size: 10pt)[
        El *codo* señala el valor de $K$ a partir del cual agregar más
        clusters ya no reduce significativamente la varianza interna.
      ]

      #v(6pt)
      #block(
        width: 88%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
        text(size: 11pt)[
          ```python
          wcss = []
          for k in range(1, 11):
              km = KMeans(
                n_clusters=k,
                random_state=42)
              km.fit(data)
              wcss.append(km.inertia_)
          ```
        ]
      )
    ],
    [
      #align(center + horizon)[
        #figure(image("images/cell_15.png", height: 290pt))
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 6 — DBSCAN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("6", "DBSCAN", subtitle: "Clustering basado en densidad")

#pagebreak()
#counter-display
#stitle("Clustering", sub: "DBSCAN")
#sstitle("Definición y parámetros")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:12pt)[
        *DBSCAN* (*Density-Based Spatial Clustering of Applications with Noise*)
        identifica clusters como *regiones densas* separadas por zonas de baja densidad.
      ]

      #v(0pt)
      #ssstitle[Dos parámetros]
      #v(0pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Parámetro], th[Descripción],
        td[*ε (epsilon)*], tdg[Radio para considerar si un punto está *cerca* de otro],
        td[*minPts*], tdg[Puntos mínimos en el vecindario de radio ε para considerar densidad],
      )
      #v(0pt)
      #text(fill: gry, size: 12pt)[
        Configuración típica: `minPts = 2 × dimensión + 1`; \
        ε se elige con el *gráfico k-distance*.
      ]
    ],
    [
      #ssstitle[Ventajas]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        - *No requiere especificar* el número de clusters.
        - Detecta clusters de *formas arbitrarias*.
        - Identifica automáticamente *ruido y outliers*.
        - Funciona bien en datos espaciales.
      ]
      #v(8pt)
      #ssstitle[Desventajas]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        - Sensible a la elección de ε.
        - Mal desempeño si la *densidad varía* mucho entre clusters.
        - Escala mal en *alta dimensión* (maldición de la dimensionalidad).
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Clustering", sub: "DBSCAN")
#sstitle("Tipos de puntos")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      Cada punto se clasifica en uno de tres tipos:

      #v(10pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Tipo], th[Definición],
        td[*Core (núcleo)*], tdg[Tiene al menos *minPts* vecinos dentro del radio ε. Zona densa],
        td[*Border (frontera)*], tdg[No cumple minPts, pero está dentro de ε de algún punto core],
        td[*Noise (ruido)*], tdg[No cumple ninguna condición. Es un *outlier*],
      )
    ],
    [
      #ssstitle[Algoritmo]
      #v(6pt)
      #set enum(numbering: "1.")
      #text(fill: gry, size: 14pt)[
        + Escoger un punto no visitado.
        + Buscar todos los vecinos a distancia ≤ ε.
        + Si tiene ≥ minPts → *punto core*, iniciar nuevo cluster.
        + *Expandir* el cluster: agregar vecinos; si alguno también es core, incluir sus vecinos.
        + Si tiene < minPts → marcar como *ruido* (puede entrar luego como borde).
        + Repetir hasta clasificar todos los puntos.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Clustering", sub: "DBSCAN")
#sstitle("Resultado sobre Iris")
#slide[
  #grid(columns: (1fr, 1.7fr), gutter: 20pt,
    [
      #text(fill: gry, size: 12pt)[
        Parámetros usados: `eps=1`, `min_samples=7`.
        #v(0pt)
        Los *marcadores* indican la especie real; el *color* el cluster asignado
        por DBSCAN. Pueden quedar puntos "grises" clasificados como *ruido*.
        #v(6pt)
        DBSCAN logra separar las regiones densas sin necesitar el número
        de clusters como entrada.
      ]
      #v(10pt)
      #block(
        width: 88%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
        text(size: 11pt)[
          ```python
          from sklearn.cluster import DBSCAN
          dbscan = DBSCAN(eps=1, min_samples=7)
          labels = dbscan.fit_predict(data)
          ```
        ]
      )
    ],
    [
      #align(center + horizon)[
        #figure(image("images/cell_17.png", height: 290pt))
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 7 — ELECCIÓN DE ε
// ════════════════════════════════════════════════════════════════════════════
#section-divider("7", "Elección de ε", subtitle: "Gráfico k-distance")

#pagebreak()
#counter-display
#stitle("Clustering", sub: "Elección de ε")
#sstitle("Gráfico k-distance")
#slide[
  #grid(columns: (1fr, 1.9fr), gutter: 20pt,
    [
      #text(size: 12pt)[Se usa el *gráfico k-distance* para elegir ε:]

      #v(0pt)
      #text(fill: gry, size: 12pt)[
        + Para cada punto, calcular su distancia al *vecino número k = minPts*.
        + *Ordenar* esas distancias de menor a mayor.
        + Buscar el *punto de inflexión* ("codo") donde la curva sube repentinamente.
        + Ese valor es un buen candidato para ε.
      ]

      #v(0pt)
      #text(fill: gry, size: 12pt)[
        Un ε demasiado pequeño clasifica muchos puntos como ruido. \
        Un ε demasiado grande fusiona clusters distintos.
      ]
    ],
    [
      #align(center + horizon)[
        #figure(image("images/cell_19.png", height: 245pt))
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// CIERRE
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#align(center + horizon)[
  #text(fill: cm2, weight: "bold", size: 36pt)[Muchas Gracias]
  #v(16pt)
  #line(length: 30%, stroke: 2pt + cm1)
  #v(24pt)
  #text(fill: gry, size: 16pt)[
    Análisis de Datos Cualitativos \
    Técnicas de agrupamiento
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
