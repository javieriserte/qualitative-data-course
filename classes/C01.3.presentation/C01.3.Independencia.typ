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

// ─── Tabla con estilo base ────────────────────────────────────────────────────
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
  "Unidad I",
  "Independencia de variables",
  "Distribución conjunta, independencia y medidas de asociación",
  "Análisis de Datos Cualitativos",
  "2026",
)

// ════════════════════════════════════════════════════════════════════════════
// CONTENIDOS
// ════════════════════════════════════════════════════════════════════════════
#counter-display
#stitle("Unidad I", sub: "Contenidos")
#sstitle("Índice")
#slide[
  #set text(size: 17pt)
  #set par(leading: 1.1em)
  + Independencia de variables aleatorias
  + Distribución conjunta
  + Probabilidad condicional y marginal
  + Tablas de contingencia
  + Medidas de asociación \
    #text(fill: gry, size: 14pt)[Pearson · Chi-cuadrado · Cramér · Spearman · Kendall · Eta cuadrado]
]

// ════════════════════════════════════════════════════════════════════════════
// INDEPENDENCIA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Independencia", subtitle: "Variables aleatorias independientes")
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Independencia")
#sstitle("Concepto")
#slide[
  Dos *variables aleatorias* son *independientes* cuando el valor de una
  *no aporta información* sobre la otra.

  #v(10pt)
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Ejemplo independiente]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        Lanzar *dos monedas*. \
        Saber que la primera salió cara *no cambia* la probabilidad
        de que la segunda también lo sea.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Ejemplo dependiente]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        Extraer *dos cartas sin reemplazo* de una baraja. \
        Saber que la primera fue un as *sí cambia* la probabilidad
        de que la segunda también lo sea.
      ]
    ],
  )
  #v(10pt)
  #text(fill: gry, size: 14pt)[
    En un *diagrama de dispersión*, si $X$ e $Y$ son independientes los puntos
    no muestran ningún patrón. Si se agrupan o siguen una forma definida, existe
    *dependencia* entre las variables.
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Independencia")
#sstitle("Condición formal")
#slide[
  Si $X$ e $Y$ son variables *independientes*, se cumple:

  $ P(X = x,\, Y = y) = P(X = x) dot P(Y = y) $

  #v(10pt)
  Lo que implica:

  #v(6pt)
  #styled-table(
    columns: (1fr, 1fr),
    th[Probabilidad condicional], th[Interpretación],
    td[$P(X = x | Y = y) = P(X = x)$],
    tdg[Conocer $Y$ no cambia la distribución de $X$],
    td[$P(Y = y | X = x) = P(Y = y)$],
    tdg[Conocer $X$ no cambia la distribución de $Y$],
  )

  #v(12pt)
  #text(fill: gry, size: 14pt)[
    La independencia es una *hipótesis clave* en muchos métodos estadísticos.
    Cuando no se cumple, es necesario modelar la *correlación* o
    *dependencia conjunta* entre las variables.
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// DISTRIBUCIÓN CONJUNTA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Distribución conjunta", subtitle: "Caso bivariado")
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Distribución conjunta")
#sstitle("Definición")
#slide[
  La *distribución conjunta* describe cómo se comportan *dos o más variables
  aleatorias al mismo tiempo*. Permite analizar la probabilidad de que
  *ocurran simultáneamente* ciertos valores de cada variable.

  #v(8pt)
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Caso discreto]
      #v(4pt)
      $ P(X = x,\, Y = y) $
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Debe cumplirse:
      ]
      $ sum_i sum_j P(X = x_i, Y = y_j) = 1 $
    ],
    [
      #ssstitle[Caso continuo]
      #v(4pt)
      $ f_(X,Y)(x, y) $
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        El área total bajo la superficie es 1:
      ]
      $ integral integral f_(X,Y)(x, y) dif x dif y = 1 $
    ],
  )

  #v(10pt)
  #text(fill: gry, size: 14pt)[
    La distribución conjunta es la base para definir
    *independencia*, *covarianza* y *correlación*.
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// PROBABILIDAD CONDICIONAL Y MARGINAL
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Prob. condicional y marginal", subtitle: "Herramientas para analizar la dependencia")
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Probabilidad condicional")
#sstitle("Definición")
#slide[
  Mide la *probabilidad de que ocurra un evento dado que otro ya ocurrió*.

  $ P(X = x | Y = y) = frac(P(X = x, Y = y), P(Y = y)) $

  #v(8pt)
  #text(fill: gry, size: 14pt)[Se lee: "probabilidad de $X = x$ *dado que* $Y = y$".]

  #v(10pt)
  La probabilidad conjunta puede descomponerse como:

  $ P(X = x, Y = y) = P(X = x | Y = y) dot P(Y = y) $
  $ P(X = x, Y = y) = P(Y = y | X = x) dot P(X = x) $

  #v(10pt)
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    block(stroke: 2pt + cm3, inset: 12pt, radius: 5pt)[
      #text(size:14pt)[$P("fiebre")$: probabilidad general de fiebre.]
    ],
    block(stroke: 2pt + cm1, inset: 12pt, radius: 5pt)[
      #text(size:14pt)[$P("fiebre" | "infectado")$: probabilidad de fiebre *solo entre infectados*.]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Probabilidades marginales")
#sstitle("Definición")
#slide[
  #text(size:14pt)[
    Las *probabilidades marginales* describen la *distribución individual*
    de una variable dentro de una distribución conjunta. Se obtienen
    *sumando* (o integrando) sobre los valores de la otra variable.
  ]

  #v(10pt)
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Caso discreto]
      #v(6pt)
      $ P(X = x) = sum_y P(X = x, Y = y) $
      #v(4pt)
      $ P(Y = y) = sum_x P(X = x, Y = y) $
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        El término *"marginal"* proviene de las tablas de probabilidad,
        donde estas sumas aparecen en los *márgenes*.
      ]
    ],
    [
      #ssstitle[Caso continuo]
      #v(6pt)
      $ f_X (x) = integral_(-oo)^(oo) f_(X,Y)(x, y) dif y $
      #v(4pt)
      $ f_Y (y) = integral_(-oo)^(oo) f_(X,Y)(x, y) dif x $
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        Las marginales son la base para calcular probabilidades
        condicionales mediante:
        $ P(X = x | Y = y) = frac(P(X = x, Y = y), P(Y = y)) $
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// TABLAS DE CONTINGENCIA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "Tablas de contingencia", subtitle: "Distribución conjunta de variables categóricas")
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Tablas de contingencia")
#sstitle("Concepto")
#slide[
  Representan todas las combinaciones de valores posibles de *variables
  categóricas*. Lo más frecuente es cruzar *dos variables*, aunque se pueden
  representar más.

  #v(10pt)
  #styled-table(
    columns: (auto, auto, auto, auto, auto),
    th[$Y backslash X$], th[$x_1$], th[$x_2$], th[$x_3$], th[$P(Y=y)$],
    td[$y_1$], td[$a$], td[$b$], td[$c$], td[$a+b+c$],
    td[$y_2$], td[$d$], td[$e$], td[$f$], td[$d+e+f$],
    td[$P(X=x)$], td[$a+d$], td[$b+e$], td[$c+f$], td[Total],
  )

  #v(10pt)
  #text(fill: gry, size: 14pt)[
    Las celdas pueden contener *frecuencias absolutas* o *probabilidades*.
    Las sumas de filas y columnas dan las distribuciones *marginales*.
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Tablas de contingencia")
#sstitle("Construcción en Python")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Frecuencias con pandas]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          import pandas as pd

          contin_df = pd.crosstab(
              df["Organism"],
              df["Fully Disordered"]
          )
          # Organism          No  Si
          # E. coli           17   3
          # Homo sapiens      12   8
          ```
        ]
      )
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          # Convertir a probabilidades
          prob_df = contin_df / contin_df.sum().sum()

          # Marginales
          margin_disorder = prob_df.sum()
          margin_org      = prob_df.sum(axis=1)
          ```
        ]
      )
    ],
    [
      #ssstitle[Con scipy.stats]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          import scipy.stats as st

          result = st.contingency.crosstab(
              df["Organism"],
              df["Fully Disordered"]
          )

          # result.elements  → etiquetas
          # result.count     → matriz de frecuencias
          # array([[17, 3],
          #        [12, 8]])
          ```
        ]
      )
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        Ambas funciones producen la misma tabla de frecuencias.
        `pd.crosstab` es más conveniente para exploración;
        `scipy` integra directamente con pruebas estadísticas.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// MEDIDAS DE ASOCIACIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Medidas de asociación", subtitle: "Fuerza y dirección de la relación")
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Medidas de asociación")
#sstitle("Resumen por tipo de variable")
#slide[
  #styled-table(
    columns: (1fr, 1fr, auto, auto, auto),
    th[Tipo de variables], th[Medida], th[Rango], th[Pequeño], th[Grande],
    td[*Cuantitativa — Cuantitativa*],
    tdg[Correlación de Pearson],
    tdg[$[-1, +1]$], tdg[$|r| = .10$], tdg[$|r| = .50$],
    td[*Categórica — Categórica*],
    tdg[V de Cramér],
    tdg[$[0, 1]$], tdg[$V = .10$], tdg[$V = .50$],
    td[*Ordinal — Ordinal*],
    tdg[Spearman / Kendall],
    tdg[$[-1, +1]$], tdg[$|rho| = .10$], tdg[$|rho| = .50$],
    td[*Numérica — Categórica*],
    tdg[Eta cuadrado ($eta^2$)],
    tdg[$[0, 1]$], tdg[$eta^2 = .01$], tdg[$eta^2 = .14$],
  )
  #v(4pt)
  #text(fill: gry, size: 12pt)[Umbrales de Cohen: pequeño / mediano ($times 3$) / grande. Son orientativos; el contexto disciplinar siempre prevalece.]
  #v(12pt)
  #text(fill: gry, size: 14pt)[
    - *Asociación positiva:* valores altos de una variable tienden a acompañarse de valores altos de la otra. \
    - *Asociación negativa:* valores altos de una tienden a acompañarse de valores bajos de la otra. \
    - *Sin asociación:* los valores de una variable no dependen de la otra.
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// PEARSON
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5.1", "Correlación de Pearson", subtitle: "Variables cuantitativas · Relación lineal")
#pagebreak()
#counter-display
#stitle("Medidas de asociación", sub: "Pearson")
#sstitle("Coeficiente de correlación de Pearson")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
        Mide la *relación lineal* entre dos variables cuantitativas.
      ]

      $ r_(X Y) = frac(sum (X_i - overline(X))(Y_i - overline(Y)), sqrt(sum (X_i - overline(X))^2 dot sum (Y_i - overline(Y))^2)) $

      #v(2pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Valor de $r$], th[Interpretación],
        td[$r = +1$],   tdg[Relación lineal positiva perfecta],
        td[$r = -1$],   tdg[Relación lineal negativa perfecta],
        td[$r = 0$],    tdg[Sin relación *lineal* (no implica independencia)],
        td[$r > 0$],    tdg[A mayor $X$, mayor $Y$],
        td[$r < 0$],    tdg[A mayor $X$, menor $Y$],
      )
    ],
    [
      #ssstitle[Uso en Python]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          import scipy.stats as st
          import numpy as np

          x = np.array([0.02, 0.27, 0.29,
                        0.49, 0.50, 0.58,
                        0.60, 0.64, 0.65, 0.87])
          y = np.array([0.02, 0.03, 0.03,
                        0.06, 0.20, 0.38,
                        0.40, 0.53, 0.63, 0.64])

          result = st.pearsonr(x, y)
          print(result.statistic)   # → 0.9476
          print(result.pvalue)      # p-valor
          ```
        ]
      )
    ],
  )
  #block(stroke: 1.5pt + cm1, inset: 10pt, radius: 4pt, width: 100%)[
    #text(fill: cm1, size: 10pt, weight: "bold")[Atención: ] #text(fill: cm2, size: 12pt)[$r = 0$ solo descarta relación *lineal*. Variables dependientes con relación no lineal pueden tener $r approx 0$.]
  ]
]
#pagebreak()
#counter-display
#stitle("Medidas de asociación", sub: "Pearson")
#sstitle("Coeficiente de correlación de Pearson")
#align(center)[
  #figure(image("images/pearson_scatter.png", height: 75%))
]

// ════════════════════════════════════════════════════════════════════════════
// CHI-CUADRADO
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5.2", "Chi-cuadrado", subtitle: [Independencia para variables categóricas])
#pagebreak()
#counter-display
#stitle("Medidas de asociación", sub: "Chi-cuadrado")
#sstitle("Prueba de independencia χ²")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:12pt)[
        Contrasta si dos variables categóricas son *independientes* comparando
        las frecuencias *observadas* con las *esperadas bajo independencia*.
      ]
      #align(center)[
        #scale(80%)[
          $ chi^2 = sum_(i,j) frac((O_(i j) - E_(i j))^2, E_(i j)) $
        ]
      ]

      #v(2pt)
      #text(fill: gry, size: 10pt)[
        donde $E_(i j) = frac(n_(i dot) dot n_(dot j), n)$ es la frecuencia esperada
        en la celda $(i,j)$ si las variables fueran independientes.
      ]
      #v(2pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Resultado], th[Interpretación],
        td[$p > 0.05$], tdg[No se rechaza independencia],
        td[$p <= 0.05$], tdg[Evidencia de asociación],
      )
      #v(6pt)
      #text(fill: gry, size: 10pt)[
        *Limitación:* χ² crece con $n$. Una muestra grande puede dar $p < 0.05$
        incluso para asociaciones triviales. Usar *V de Cramér* para medir magnitud.
      ]
    ],
    [
      #ssstitle[Uso en Python]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          import scipy.stats as st
          import pandas as pd

          df = pd.DataFrame({
            "droga":     ["C","B","C","A","A",
                          "B","C","A","B","C"],
            "resultado": ["Pos","Neg","Pos","Neg",
                          "Pos","Neg","Pos","Pos",
                          "Neg","Neg"]
          })
          tab = pd.crosstab(df["droga"],
                            df["resultado"])

          chi2, p, dof, expected = st.chi2_contingency(tab)
          print(f"χ² = {chi2:.3f}")
          print(f"p  = {p:.4f}")
          print(f"gl = {dof}")
          ```
        ]
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// CRAMÉR
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5.3", "V de Cramér", subtitle: "Variables categóricas · Tablas de contingencia")
#pagebreak()
#counter-display
#stitle("Medidas de asociación", sub: "V de Cramér")
#sstitle("Coeficiente de asociación de Cramér")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
        Medida de asociación entre *dos variables categóricas* en una tabla
        de contingencia. Generalización del coeficiente de Pearson para
        variables categóricas.
      ]

      $ V = sqrt(frac(chi^2, n dot min(r-1, c-1))) $

      #v(4pt)
      #text(fill: gry, size: 13pt)[donde $chi^2$ es el estadístico chi-cuadrado, $n$ el tamaño muestral,
      $r$ el número de filas y $c$ el de columnas.]

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Valor de $V$], th[Interpretación],
        td[$V = 0$], tdg[Sin asociación],
        td[$V = 1$], tdg[Asociación perfecta],
        td[$V in (0, 1)$], tdg[Asociación parcial],
      )
    ],
    [
      #ssstitle[Uso en Python]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from scipy.stats.contingency import (
              association, crosstab
          )
          import pandas as pd
          df = pd.DataFrame({
            "droga":     ["C","B","C","A","A",...],
            "resultado": ["Pos","Neg","Pos",...]
          })
          tab = crosstab(df.droga, df.resultado)
          V = association(tab[1], method="cramer")
          print(V)  # → 0.626
          ```
        ]
      )
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        `tab[1]` contiene la matriz de frecuencias (el `[0]` son las etiquetas).
        `association` también soporta `method="tschuprow"` y `method="pearson"`.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SPEARMAN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5.4", "Correlación de Spearman", subtitle: "Variables ordinales · Rankings")
#pagebreak()
#counter-display
#stitle("Medidas de asociación", sub: "Spearman")
#sstitle("Correlación de rankings de Spearman")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
        Medida de asociación basada en los *rankings* de los datos en lugar
        de los valores brutos. Adecuada para datos *ordinales* o cuando los
        datos no siguen una distribución normal.
      ]
      #align(center)[
      #scale(80%)[
        $ rho = 1 - frac(6 sum d^2, n(n^2 - 1)) $
      ]
      ]

      #v(4pt)
      #text(fill: gry, size: 11pt)[
        donde $d$ es la diferencia entre los rankings de las dos variables para cada observación.
        *Válido solo sin empates*; con empates se aplica la fórmula general de Pearson sobre los rangos.
      ]

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Valor de $rho$], th[Interpretación],
        td[$rho approx +1$], tdg[Relación monótona creciente],
        td[$rho approx -1$], tdg[Relación monótona decreciente],
        td[$rho approx 0$],  tdg[Sin relación monotónica],
      )
    ],
    [
      #ssstitle[Uso en Python]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from scipy.stats import spearmanr

          # Categorías con orden: A > B > C
          variable1 = ["A","B","A","C","B","A",
                       "B","B","C","C","A","A"]
          # Categorías con orden: Z > Y > X
          variable2 = ["Z","Y","Y","X","Z","Z",
                       "Y","Y","X","X","Z","Y"]

          # Asignar rangos numéricos
          map1 = {"A":0, "B":1, "C":2}
          map2 = {"Z":0, "Y":1, "X":2}
          r1 = [map1[v] for v in variable1]
          r2 = [map2[v] for v in variable2]

          rho, p = spearmanr(r1, r2)
          print(rho)   # → correlación
          ```
        ]
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// KENDALL
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5.5", "Tau de Kendall", subtitle: "Variables ordinales · Pares concordantes")
#pagebreak()
#counter-display
#stitle("Medidas de asociación", sub: "Kendall")
#sstitle("Coeficiente de correlación de Kendall")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
        Medida de asociación *no paramétrica* que evalúa la *concordancia de
        rankings* entre dos variables. Útil con datos ordinales o de rankings.
      ]

      $ tau = frac(P - Q, sqrt((P + Q + T) dot (P + Q + U))) $

      #styled-table(
        columns: (auto, 1fr),
        th[Símbolo], th[Significado],
        td[$P$], tdg[Número de pares *concordantes*],
        td[$Q$], tdg[Número de pares *discordantes*],
        td[$T$], tdg[Empates solo en la primera variable],
        td[$U$], tdg[Empates solo en la segunda variable],
      )

      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Un par es *concordante* si el orden relativo en $X$ coincide
        con el orden relativo en $Y$; *discordante* si es opuesto.
      ]
    ],
    [
      #ssstitle[Uso en Python]
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from scipy.stats import kendalltau
          # Mismas variables del ejemplo Spearman
          r1 = [map1[v] for v in variable1]
          r2 = [map2[v] for v in variable2]
          tau, p = kendalltau(r1, r2)
          print(tau)   # → correlación Kendall
          print(p)     # → p-valor
          ```
        ]
      )
      #ssstitle[Spearman vs. Kendall]
      #text(fill: gry, size: 13pt)[
        - Ambas miden *corr. monótona* y tienen rango $[-1, +1]$. \
        - Kendall suele producir valores *más conservadores*. \
        - Kendall es *más robusto* ante errores en los rankings. \
        - Spearman es más común y comput. más simple.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// ETA CUADRADO
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5.6", "Eta cuadrado", subtitle: "Variable numérica y variable categórica")
#pagebreak()
#counter-display
#stitle("Medidas de asociación", sub: "Eta cuadrado")
#sstitle("Coeficiente eta cuadrado (η²)")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      Mide *qué proporción de la variabilidad total* de una variable
      numérica $Y$ se explica por la pertenencia a grupos definidos
      por una variable categórica $X$.

      #v(6pt)
      La variabilidad total se descompone:
      $ S S_"total" = S S_"entre" + S S_"dentro" $

      $ eta^2 = frac(S S_"entre", S S_"total") $

      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Valor de $eta^2$], th[Interpretación],
        td[$eta^2 = 0$], tdg[Sin diferencia entre grupos],
        td[$eta^2 = 1$], tdg[La categórica explica toda la variación de $Y$],
      )

    ],
    [
      #text(fill: gry, size: 13pt)[
        $ S S_"total"  = sum_(i=1)^n (y_i - overline(y))^2 $
        $ S S_"entre"  = sum_(g=1)^G n_g (overline(y)_g - overline(y))^2 $
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Medidas de asociación", sub: "Eta cuadrado")
#sstitle("Coeficiente eta cuadrado (η²)")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
  [
    #ssstitle[Cálculo con ANOVA en Python]
    #block(
      width: 100%, fill: rgb("#f0fdf4"),
      stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
      text(size: 13pt)[
        ```python
        import pandas as pd
        import statsmodels.api as sm
        import statsmodels.formula.api as smf
        df = pd.DataFrame({
          "tratamiento": ["control","A","B",
                          "control","A","B",
                          "A","control","B","A"],
          "expresion":   [4.8, 6.2, 7.1,
                          4.9, 6.4, 6.9,
                          6.1, 5.0, 7.3, 6.5]
        })
        modelo = smf.ols("expresion ~ C(tratamiento)", data=df).fit()
        anova = sm.stats.anova_lm(modelo, typ=2)
        eta2  = (anova["sum_sq"]["C(tratamiento)"]
                  / anova["sum_sq"].sum())
        print(f"η² = {eta2:.3f}")
        ```
      ]
    )
  ],
  [
  #align(center+horizon)[
    #figure(image("images/eta2_barplot.png", height: 65%))
  ]
  ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// CIERRE
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#align(center+horizon)[
  #text(fill: cm2, weight: "bold", size: 36pt)[Muchas Gracias]
  #v(16pt)
  #line(length: 30%, stroke: 2pt + cm1)
  #v(24pt)
  #text(fill: gry, size: 16pt)[
    Análisis de Datos Cualitativos \
    Independencia de variables y medidas de asociación
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
