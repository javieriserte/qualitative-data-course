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
  "Árboles de decisión",
  "Decision Trees · Random Forest · CHAID",
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
  + Árboles de decisión — concepto
  + Criterios de división: Gini, entropía y error de clasificación
  + Árbol en Python — ejemplo con datos sintéticos
  + Árbol sobre el dataset Iris
  + Sobreajuste y poda — pre-poda, post-poda, hiperparámetros
  + Random Forest
  + Importancia de variables
  + Árbol CHAID
  + Métodos modernos — Gradient Boosting, XGBoost, LightGBM, CatBoost
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 1 — ÁRBOLES DE DECISIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Árboles de decisión", subtitle: "Concepto y estructura")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Árboles de decisión")
#sstitle("Concepto")
#slide[
  #grid(columns: (1fr, 1.5fr), gutter: 20pt,
    [
      #text(size:12pt)[
        Un *árbol de decisión* divide el espacio n-dimensional de las variables
        en regiones, asignando una categoría a cada región.
      ]
      #v(0pt)
      #text(fill: gry, size: 12pt)[
        - Cada división parte el espacio en *dos subregiones*.
        - La división se da por el valor de *una única variable*.
        - Cada subregión puede volver a subdividirse.
        - Luego de una serie de divisiones quedan definidos espacios
          que se asignan a una categoría.
      ]

      #v(0pt)
      #text(fill: gry, size: 12pt)[
        Durante el entrenamiento se eligen las *variables* y los
        *valores de corte* de cada división que maximizan la
        reducción de impureza.
      ]
    ],
    [
      #align(center + horizon)[
        #figure(image("images/cell_04.png", height: 280pt))
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Árboles de decisión")
#sstitle("Divisiones sucesivas")
#slide[
  #grid(columns: (1fr, 1.5fr), gutter: 20pt,
    [
      #text(fill: gry, size: 14pt)[
        Cada corte divide el espacio en dos regiones. Las divisiones
        sucesivas acotan regiones cada vez más puras hasta que cada hoja
        contiene predominantemente una sola clase.
        #v(8pt)
        El gráfico muestra las *fronteras de decisión* aprendidas por
        el árbol sobre un dataset de dos clases.
      ]
    ],
    [
      #align(center + horizon)[
        #figure(image("images/cell_05.png", height: 280pt))
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 2 — CRITERIOS DE DIVISIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Criterios de división", subtitle: "Gini · Entropía · Error de clasificación")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Criterios")
#sstitle("Reducción de impureza")
#slide[
  En cada subdivisión se maximiza la *reducción de impureza*
  (también llamada *ganancia de información*).
  #text(fill: gry, size: 12pt)[
    Notación: $p_k$ es la *proporción de muestras de la clase $k$* en el nodo.
  ]

  #v(6pt)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 12pt,
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Índice Gini]
      #v(6pt)
      $ G = 1 - sum_k p_k^2 $
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Se minimiza el Gini de los hijos, o se maximiza la *reducción de Gini*:
      ]
      $ Delta G = G_"padre" - sum_h frac(N_h, N) G_h $
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Entropía]
      #v(6pt)
      $ H = -sum_k p_k log_2 p_k $
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        El split óptimo maximiza la *ganancia de información*:
      ]
      $ I G = H_"padre" - sum_h frac(N_h, N) H_h $
    ],
    block(stroke: 2pt + grn, inset: 14pt, radius: 5pt)[
      #ssstitle[Error de clasificación]
      #v(6pt)
      $ E = 1 - max_k p_k $
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Se minimiza el error, pero casi nunca se usa para decidir splits porque
        es menos sensible que Gini o entropía.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Criterios")
#sstitle("Comparación de impurezas")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #styled-table(
        columns: (auto, 1fr, 1fr),
        th[Criterio], th[Uso habitual], th[Característica],
        td[*Gini*],     tdg[Clasificación binaria y multiclase], tdg[Más rápido de calcular; por defecto en sklearn],
        td[*Entropía*], tdg[Clasificación con clases desbalanceadas], tdg[Más sensible a distribuciones asimétricas],
        td[*Error*],    tdg[Poda de árbol], tdg[Menos sensible; no recomendado para splits],
      )
      #v(12pt)
      #text(fill: gry, size: 14pt)[
        En la práctica *Gini y Entropía dan resultados muy similares*.
        La diferencia principal es el costo computacional: Gini evita
        el cálculo de logaritmos.
      ]
    ],
    [
      #ssstitle[Intuición de Gini]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        $G = 0$ → nodo *puro*: todos los elementos son de la misma clase. \
        $G = 1 - 1/k$ → nodo completamente *impuro*: clases equiprobables.
        #v(8pt)
        Para dos clases con $p$ y $1-p$:
      ]
      $ G = 2 p (1-p) $
      #text(fill: gry, size: 14pt)[
        Máximo en $p = 0.5$ donde $G = 0.5$.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 3 — EJEMPLO PYTHON
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Árbol en Python", subtitle: "Ejemplo con datos sintéticos")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Python")
#sstitle("Fronteras de decisión")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from sklearn.tree import DecisionTreeClassifier
          from sklearn.inspection import DecisionBoundaryDisplay

          dt = DecisionTreeClassifier()
          fitted = dt.fit(X, y)

          DecisionBoundaryDisplay.from_estimator(
            dt, X,
            response_method="predict",
            alpha=0.3
          )
          plt.scatter(*X.T, c=y)
          ```
        ]
      )
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        El árbol aprendido divide el espacio en regiones rectangulares
        paralelas a los ejes — una consecuencia directa de que cada
        corte usa *una sola variable*.
      ]
    ],
    [
      #align(center + horizon)[
        #figure(image("images/cell_10.png", height: 290pt))
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Python")
#sstitle("Visualización del árbol")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(fill: gry, size: 11pt)[
        `plot_tree` muestra la estructura completa del árbol:
        cada nodo indica la *variable de corte*, el *umbral*,
        el *Gini* y el *número de muestras*.
        Los nodos hoja muestran la distribución de clases y
        el valor de la predicción.
      ]
    ],
    [
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
        text(size: 10pt)[
          ```python
          from sklearn.tree import plot_tree

          fig, ax = plt.subplots(figsize=(20, 8))
          plot_tree(fitted, filled=True, ax=ax)
          ```
        ]
      )
    ],
  )
  #align(center + horizon)[
    #figure(image("images/cell_11.png", height: 240pt))
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 4 — IRIS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "Árbol sobre Iris", subtitle: "Entrenamiento y visualización")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Iris")
#sstitle("Árbol ajustado sobre Iris")
#slide[
  #grid(columns: (1fr, 1.6fr), gutter: 20pt,
    [
      #text(fill: gry, size: 12pt)[
        Se divide el dataset Iris en entrenamiento y test con `train_test_split`,
        se ajusta un `DecisionTreeClassifier` y se visualiza el árbol resultante.
        #v(0pt)
        Las variables más importantes quedan en los nodos superiores del árbol.
        El árbol sin poda tiende a sobreajustar al crecer hasta clasificar
        perfectamente el conjunto de entrenamiento.
      ]
      #v(0pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
        text(size: 10pt)[
          ```python
          from sklearn.tree import DecisionTreeClassifier
          from sklearn.model_selection import train_test_split

          train, test = train_test_split(df)
          tree = DecisionTreeClassifier()
          fitted = tree.fit(
            train[feature_cols], train["target"]
          )
          plot_tree(fitted, filled=True)
          ```
        ]
      )
    ],
    [
      #align(center + horizon)[
        #figure(image("images/cell_14.png", height: 290pt))
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 5 — SOBREAJUSTE Y PODA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Sobreajuste y poda", subtitle: "Overfitting · Pruning · Hiperparámetros")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Sobreajuste")
#sstitle("El problema del sobreajuste")
#slide[
  Un árbol sin restricciones crece hasta clasificar *perfectamente* el conjunto
  de entrenamiento — pero generaliza mal a datos nuevos.

  #v(10pt)
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    block(stroke: 2pt + cm1, inset: 16pt, radius: 5pt)[
      #ssstitle[Árbol sobreajustado]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - Profundidad ilimitada: cada hoja puede contener *una sola muestra*.
        - Error de entrenamiento = 0, pero el error de test es alto.
        - Las fronteras de decisión son muy *irregulares*: captura ruido del
          entrenamiento en lugar de patrones reales.
        - Añadir una nueva observación puede cambiar radicalmente el árbol.
      ]
    ],
    block(stroke: 2pt + cm3, inset: 16pt, radius: 5pt)[
      #ssstitle[Árbol bien regulado]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - Profundidad limitada: las hojas agrupan varias muestras.
        - Puede cometer errores en entrenamiento, pero *generaliza mejor*.
        - Las fronteras de decisión son más suaves y capturan estructura real.
        - Más robusto ante variaciones en los datos de entrada.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Sobreajuste")
#sstitle("Pre-poda — hiperparámetros de control")
#slide[
  La *pre-poda* detiene el crecimiento del árbol antes de que memorice el
  conjunto de entrenamiento, mediante restricciones definidas de antemano.

  #v(10pt)
  #styled-table(
    columns: (auto, 1fr, auto),
    th[Hiperparámetro], th[Efecto], th[Valor típico],
    td[`max_depth`],
    tdg[Profundidad máxima del árbol. El control más directo del sobreajuste],
    td[3 – 10],
    td[`min_samples_split`],
    tdg[Mínimo de muestras que debe tener un nodo para poder dividirse],
    td[2 – 20],
    td[`min_samples_leaf`],
    tdg[Mínimo de muestras que debe contener cada hoja. Suaviza las hojas extremas],
    td[1 – 10],
    td[`max_features`],
    tdg[Número de variables candidatas evaluadas en cada split],
    tdg[`sqrt(p)`, `log2(p)`],
    td[`max_leaf_nodes`],
    tdg[Límite total de hojas en el árbol],
    td[sin límite],
  )
  #v(8pt)
  #text(fill: gry, size: 13pt)[
    Estos hiperparámetros se ajustan con *validación cruzada* o una curva de
    validación: se entrena el modelo para varios valores y se elige el que
    minimiza el error en el conjunto de validación.
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Poda")
#sstitle("Post-poda — Cost-Complexity Pruning")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:12pt)[
        La *post-poda* deja crecer el árbol completamente y luego
        *elimina ramas* que no aportan suficiente reducción de error.
      ]
      #v(0pt)
      #text(fill: gry, size: 14pt)[
        El criterio de poda penaliza la complejidad del árbol:
      ]

      $ R_alpha (T) = R(T) + alpha dot |T| $

      #text(fill: gry, size: 12pt)[
        donde $R(T)$ es el error del árbol, $|T|$ el número de hojas y
        $alpha >= 0$ controla el equilibrio entre *ajuste y simplicidad*.
        #v(6pt)
        - $alpha = 0$ → árbol completo sin poda.
        - $alpha$ grande → árbol muy podado (pocos nodos).
        #v(6pt)
        El valor óptimo de $alpha$ se elige con *validación cruzada*.
      ]
    ],
    [
      #ssstitle[Código en Python]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 11pt)[
          ```python
          from sklearn.tree import DecisionTreeClassifier
          from sklearn.model_selection import cross_val_score

          # Obtener valores candidatos de alpha
          path = dt.cost_complexity_pruning_path(X_train, y_train)
          alphas = path.ccp_alphas

          # Evaluar cada alpha con validación cruzada
          scores = []
          for a in alphas:
              dt = DecisionTreeClassifier(ccp_alpha=a)
              cv = cross_val_score(dt, X_train, y_train, cv=5)
              scores.append(cv.mean())

          # Elegir el alpha con mayor score
          best_alpha = alphas[scores.index(max(scores))]
          ```
        ]
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 6 — RANDOM FOREST
// ════════════════════════════════════════════════════════════════════════════
#section-divider("6", "Random Forest", subtitle: "Ensemble de árboles · Bagging — motivado por el sobreajuste")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Random Forest")
#sstitle("Fuentes de aleatoriedad")
#slide[
  En un *Random Forest* los árboles son diferentes gracias a
  *dos fuentes de aleatoriedad* introducidas intencionalmente.
  Esa diversidad es clave para tener alto rendimiento y bajo sobreajuste.

  #v(10pt)
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    block(stroke: 2pt + cm3, inset: 16pt, radius: 5pt)[
      #ssstitle[Bootstrap sampling]
      #v(6pt)
      #text(fill: gry, size: 12pt)[
        Cada árbol se entrena con una muestra del dataset tomada
        *con reemplazo*.
        #v(4pt)
        Si el dataset tiene $N$ filas, cada árbol se entrena con $N$ filas
        pero *algunas se repiten y otras quedan fuera* (out-of-bag).
        #v(4pt)
        Esto hace que cada árbol vea una versión *ligeramente distinta*
        del dataset.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 16pt, radius: 5pt)[
      #ssstitle[Random feature selection]
      #v(6pt)
      #text(fill: gry, size: 12pt)[
        En cada partición de cada árbol, *no se consideran todas las variables*,
        sino un subconjunto aleatorio de tamaño `max_features`.
        #v(4pt)
        Esto evita que todas las variables dominantes aparezcan siempre en el
        nodo raíz, forzando diversidad entre árboles.
        #v(4pt)
        Valor típico: `max_features = sqrt(p)` para clasificación.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Random Forest")
#sstitle("Predicción y evaluación")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Agregación de predicciones]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Tarea], th[Método de agregación],
        td[*Clasificación*], tdg[Votación mayoritaria entre todos los árboles],
        td[*Regresión*],    tdg[Promedio de las predicciones de cada árbol],
      )
      #v(10pt)
      #ssstitle[Código en Python]
      #v(0pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
        text(size: 11pt)[
          ```python
          from sklearn.ensemble import RandomForestClassifier
          from sklearn.model_selection import cross_val_score

          rf = RandomForestClassifier(
            n_estimators=100,
            criterion='gini',
            bootstrap=True,
            max_features='sqrt'
          )
          scores = cross_val_score(rf, X, y, cv=5)
          print(scores.mean())
          ```
        ]
      )
    ],
    [
      #ssstitle[Ventajas vs. árbol único]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - *Reducción de varianza*: promediar muchos árboles ruidosos produce
          una predicción estable.
        - *Menos sobreajuste*: la diversidad entre árboles limita el overfitting.
        - *Estimación out-of-bag*: las filas excluidas de cada árbol sirven como
          conjunto de validación sin necesidad de split adicional.
        - *Importancia de variables* como subproducto natural del ajuste.
      ]
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        El precio es la *pérdida de interpretabilidad*: un bosque de 100 árboles
        no puede visualizarse como un árbol único.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 6 — IMPORTANCIAS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("7", "Importancia de variables", subtitle: "Gini Importance · Permutation Importance")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Importancias")
#sstitle("Dos formas de medir importancia")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    block(stroke: 2pt + cm3, inset: 16pt, radius: 5pt)[
      #ssstitle[Gini Importance]
      #text(fill: gry, size: 12pt)[
        Es la *reducción promedio de impureza* que produce cada variable
        a lo largo de todos los árboles del bosque.
        #v(6pt)
        - Fácil de obtener: viene integrada en `feature_importances_`.
        - Puede estar *sesgada* hacia variables con más categorías o
          más valores únicos (cardinalidad alta).
      ]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 6pt), radius: 4pt,
        text(size: 12pt)[
          ```python
          importances = fitted.feature_importances_
          ```
        ]
      )
    ],
    block(stroke: 2pt + cm1, inset: 16pt, radius: 5pt)[
      #ssstitle[Permutation Importance (recomendada)]
      #text(fill: gry, size: 12pt)[
        Mide cuánto *empeora la predicción* cuando se permuta una columna
        (rompiendo su relación con el target).
        #v(0pt)
        - Más *confiable y menos sesgada*.
        - Requiere más cómputo: evalúa el modelo varias veces.
        - Funciona con cualquier modelo, no solo árboles.
      ]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 6pt), radius: 4pt,
        text(size: 12pt)[
          ```python
          from sklearn.inspection import permutation_importance
          r = permutation_importance(
            fitted, X, y, n_repeats=30
          )
          ```
        ]
      )
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Importancias")
#sstitle("Resultados sobre Iris")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Gini Importance]
      #v(6pt)
      #styled-table(
        columns: (1fr, auto),
        th[Variable], th[Importancia],
        td[petal length (cm)], tdg[≈ 0.44],
        td[petal width (cm)],  tdg[≈ 0.43],
        td[sepal length (cm)], tdg[≈ 0.10],
        td[sepal width (cm)],  tdg[≈ 0.02],
      )
    ],
    [
      #ssstitle[Permutation Importance]
      #v(6pt)
      #styled-table(
        columns: (1fr, auto),
        th[Variable], th[Importancia],
        td[petal length (cm)], tdg[≈ 0.36],
        td[petal width (cm)],  tdg[≈ 0.31],
        td[sepal length (cm)], tdg[≈ 0.05],
        td[sepal width (cm)],  tdg[≈ 0.01],
      )
    ],
  )
  #v(14pt)
  #text(fill: gry, size: 14pt)[
    Ambos métodos coinciden: *petal length* y *petal width* son las variables
    más informativas para clasificar las especies de Iris.
    Las variables del sépalo aportan relativamente poco.
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 7 — CHAID
// ════════════════════════════════════════════════════════════════════════════
#section-divider("8", "CHAID", subtitle: "Chi-square Automatic Interaction Detection")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "CHAID")
#sstitle("¿Qué es CHAID?")
#slide[
  #grid(columns: (1fr, 1.8fr), gutter: 5pt,
    [
      #text(size: 12pt)[
        *CHAID* (Chi-square Automatic Interaction Detection) es un método
        de árbol de decisión que usa *pruebas estadísticas* para decidir
        cada división, en lugar de medidas de impureza como Gini o entropía.
      ]
      #v(0pt)
      #text(fill: gry, size: 12pt)[
        Su objetivo: encontrar *segmentos de la población* que sean
        estadísticamente distintos respecto a la variable objetivo.
      ]
      #v(0pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Variable objetivo], th[Prueba estadística],
        td[*Categórica*],  tdg[Chi-cuadrado (χ²)],
        td[*Continua*],    tdg[ANOVA / prueba F],
      )
      #v(0pt)
      #text(fill: cm1, size: 12pt, weight: "bold")[
        Diferencia clave:
      ]
      #text(fill: gry, size: 12pt)[
        una división CHAID puede producir
        *dos o más ramas*
      ]
    ],
    [
      #align(center + horizon)[
        #figure(image("images/chaid_tree.png", height: 190pt))
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "CHAID")
#sstitle("Paso clave: fusión de categorías")
#slide[
  #text(fill: gry, size: 13pt)[
    Antes de dividir, CHAID *fusiona las categorías de un predictor* que no
    muestran diferencias significativas en la variable objetivo.
    Solo las categorías estadísticamente distintas forman ramas separadas.
  ]
  #v(10pt)
  #align(center)[
    #figure(image("images/chaid_merge.png", height: 255pt))
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "CHAID")
#sstitle("Algoritmo — tres pasos por nodo")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 24pt,
    [
      #set enum(numbering: "1.")
      #text(fill: gry, size: 14pt)[
        + *Fusionar categorías* similares. \
          Para cada predictor candidato, se fusionan las categorías cuyas
          distribuciones de respuesta no difieren significativamente
          (p > umbral, típicamente 0.05).

        + *Elegir el mejor predictor*: el que tenga el p-valor más pequeño
          tras la fusión — es decir, el que más explica la variación
          en la variable objetivo.

        + *Dividir el nodo* usando ese predictor.
          Cada grupo resultante del paso 1 se convierte en una rama.
      ]
      #v(8pt)
      #text(fill: gry, size: 12pt)[
        El proceso se detiene cuando ningún predictor supera el umbral de
        significancia, se alcanza la profundidad máxima o las particiones
        son demasiado pequeñas.
      ]
    ],
    [
      #block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
        #ssstitle[Ejemplo: variable "Estado civil"]
        #v(6pt)
        #text(fill: gry, size: 13pt)[
          Categorías originales: Soltero, Casado, Divorciado, Viudo, Unión libre.
          #v(6pt)
          CHAID evalúa si las tasas de respuesta difieren:
          - Divorciado ≈ Viudo → *se fusionan*
          - Unión libre ≈ Soltero → *se fusionan*
          #v(6pt)
          Resultado: *3 ramas* en lugar de 5, con mayor potencia estadística
          en cada grupo al tener más observaciones.
        ]
      ]
      // #v(10pt)
      // #align(center)[
      //   #figure(image("images/chaid_vs_cart.png", height: 185pt))
      // ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "CHAID")
#sstitle("CHAID vs. CART — comparación")
#slide[
  #styled-table(
    columns: (auto, 1fr, 1fr),
    th[Aspecto], th[CART (Gini / Entropía)], th[CHAID],
    td[*Tipo de split*],        tdg[Siempre binario (2 ramas)],            tdg[Multi-vía (2 o más ramas)],
    td[*Criterio de división*], tdg[Reducción de impureza],                tdg[Significancia estadística (p-valor)],
    td[*Variables*],            tdg[Numéricas y categóricas],              tdg[Principalmente categóricas],
    td[*Fusión de categorías*], tdg[No — cada categoría es una rama],      tdg[Sí — fusiona categorías similares],
    td[*Poda*],                 tdg[Post-poda (cost-complexity pruning)],  tdg[Implícita vía umbral de p-valor],
    td[*Interpretación*],       tdg[Fronteras de decisión geométricas],    tdg[Segmentos estadísticamente válidos],
  )
  #v(10pt)
  #text(fill: gry, size: 13pt)[
    CHAID es especialmente útil en *análisis de encuestas y segmentación de mercado*:
    las variables son categóricas, los segmentos resultantes tienen respaldo estadístico
    y el árbol es directamente interpretable por equipos no técnicos.
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 9 — MÉTODOS MODERNOS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("9", "Métodos modernos", subtitle: "Gradient Boosting · XGBoost · LightGBM · CatBoost")

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Métodos modernos")
#sstitle("Bagging vs. Boosting")
#slide[
  #align(center)[
    #figure(image("images/gb_sequential.png", height: 275pt))
  ]
  #text(fill: gry, size: 10pt)[
    En *bagging* (Random Forest) los árboles se entrenan en *paralelo* sobre muestras bootstrap independientes
    y se combinan por votación. En *boosting* cada árbol se entrena *en secuencia* ajustando los errores
    que cometió el ensemble anterior.
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Métodos modernos")
#sstitle("Gradient Boosting — cómo aprende")
#slide[
  #text(fill: gry, size: 10pt)[
    El ensemble parte de una predicción inicial $F_0$ (la media de $y$).
    En cada iteración se ajusta un árbol *sobre los residuos* $epsilon_t = y - hat(y)_t$
    y se suma a la predicción con paso $eta$ (learning rate):
  ]
  #align(center)[
    #scale(75%, reflow:true)[$ F_(t+1) = F_t + eta dot h_t(x) $]
  ]
  #v(0pt)
  #align(center)[
    #figure(image("images/gb_residuals.png", height: 235pt))
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Métodos modernos")
#sstitle("Hiperparámetros clave")
#slide[
  #grid(columns: (1fr, 2.7fr), gutter: 0pt,
    [
      #scale(80%, reflow:true)[
      #styled-table(
        columns: (0.50fr, 1fr),
        th[Hiperparám.], th[Efecto],
        td[`n_estimators`],   tdg[Número de árboles. Más árboles → más capacidad, más riesgo de sobreajuste],
        td[`learning_rate`],  tdg[Peso de cada árbol. Valores pequeños requieren más árboles],
        td[`max_depth`],      tdg[Profundidad de cada árbol. Típicamente 3–5],
        td[`subsample`],      tdg[Fracción del dataset por árbol. Añade estocasticidad],
      )
      ]
      #text(fill: gry, size: 10pt)[
        Regla práctica: *learning rate bajo + muchos árboles* (con early stopping)
        suele dar el mejor resultado.
      ]
    ],
    [
      #align(center + horizon)[
        #figure(image("images/gb_learning_rate.png", height: 205pt))
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Métodos modernos")
#sstitle("Implementaciones modernas")
#slide[
  #set text(size: 12pt)
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
        #ssstitle[XGBoost]
        #v(4pt)
        #text(fill: gry, size: 12pt)[
          Gradient Boosting con regularización L1/L2, manejo nativo de
          valores faltantes y soporte GPU.
          Dominó competencias Kaggle durante años.
          #v(4pt)
          - Hiperparámetros clave: `n_estimators`, `learning_rate`,
            `max_depth`, `subsample`, `reg_alpha`, `reg_lambda`.
        ]
      ]
    ],
    [
      #block(stroke: 2pt + grn, inset: 14pt, radius: 5pt)[
        #ssstitle[CatBoost]
        #v(4pt)
        #text(fill: gry, size: 12pt)[
          Desarrollado por Yandex. Especializado en variables *categóricas de alta
          cardinalidad* sin necesidad de encoding previo.
          #v(4pt)
          - Usa *ordered boosting* para reducir el sesgo de predicción.
          - Resultados competitivos con mínima configuración.
          - Muy usado en datos tabulares con muchas categorías.
        ]
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Métodos modernos")
#sstitle("Más allá del Random Forest")
#slide[
  #set text(size: 12pt)
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
        #ssstitle[LightGBM]
        #v(4pt)
        #text(fill: gry, size: 12pt)[
          Desarrollado por Microsoft. Crece los árboles *leaf-wise* en vez de
          level-wise, lo que permite mayor precisión con menos iteraciones.
          #v(4pt)
          - Muy rápido en datasets grandes (millones de filas).
          - Soporta variables categóricas de forma nativa.
          - Consume menos memoria que XGBoost para datasets anchos.
        ]
      ]
    ],
    [
      #block(stroke: 2pt + cm2, inset: 14pt, radius: 5pt)[
        #ssstitle[¿Cuándo usar cada uno?]
        #v(4pt)
        #scale(80%, reflow:true)[
          #styled-table(
            columns: (1fr, 1fr),
            th[Situación], th[Recomendación],
            td[Dataset pequeño / interpretabilidad], tdg[Árbol único o Random Forest],
            td[Rendimiento máximo — datos numéricos], tdg[XGBoost / LightGBM],
            td[Datos con muchas variables categóricas], tdg[CatBoost],
            td[Dataset muy grande (>10M filas)], tdg[LightGBM],
          )
        ]
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
    Árboles de decisión · Random Forest · CHAID
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
