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
  "Unidad I",
  "Pruebas de hipótesis",
  "Variables, distribuciones y pruebas de hipótesis",
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
  #set text(size: 16pt)
  #set par(leading: 1.0em)
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      + Estadística inferencial y pruebas de hipótesis
      + Tipos de errores y valor p
      + Test T de Student (una muestra)
      + Intervalos de confianza
      + Bondad de ajuste
        #text(fill: gry, size: 13pt)[χ² · KS · Shapiro-Wilk · Anderson-Darling]
      + Igualdad de varianza
        #text(fill: gry, size: 13pt)[F · Bartlett · Levene]
    ],
    [
      #v(4pt)
      + Igualdad de medias
        #text(fill: gry, size: 13pt)[Student · Welch · Mann-Whitney · Wilcoxon · ANOVA · Kruskal-Wallis]
      + Comparación de distribuciones
        #text(fill: gry, size: 13pt)[KS · χ² dos muestras]
      + Variables categóricas
        #text(fill: gry, size: 13pt)[Fisher · McNemar · Mantel-Haenszel]
      + Bootstrap
        #text(fill: gry, size: 13pt)[Inferencia no paramétrica por remuestreo]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// ESTADÍSTICA INFERENCIAL
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Estadística inferencial", subtitle: "Hipótesis · Errores · Valor P")

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Estadística inferencial")
#sstitle("Concepto")
#slide[
  La *estadística inferencial* permite *extraer conclusiones* sobre una *población* a partir del análisis de una *muestra*.

  #v(10pt)
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Objetivo]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - *Inferir* características de una población (media, proporción, varianza) sin observarla completamente.
        - *Cuantificar la incertidumbre* asociada a esas inferencias.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Herramientas]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - Estimación puntual e intervalos de confianza.
        - Pruebas de hipótesis.
        - Métodos no paramétricos (bootstrap, rangos).
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Estadística inferencial")
#sstitle("Pruebas de hipótesis — Etapas")
#slide[
  #styled-table(
    columns: (auto, 1fr),
    th[Etapa], th[Descripción],
    td[*1. Formulación*],
    tdg[Definir $H_0$ (no efecto) y $H_1$ (efecto)],
    td[*2. Estadístico de prueba*],
    tdg[Calcular un valor numérico que resume la evidencia],
    td[*3. Distribución bajo $H_0$*],
    tdg[Conocer la distribución del estadístico si $H_0$ fuera verdadera],
    td[*4. Valor p*],
    tdg[$P("resultado igual o más extremo" | H_0)$],
    td[*5. Decisión*],
    tdg[Rechazar o no rechazar $H_0$ comparando $p$ con el nivel $alpha$],
  )
  #v(8pt)
  #text(fill: gry, size: 13pt)[
    El objetivo no es "probar que algo es cierto", sino evaluar si la evidencia observada
    *contradice suficientemente* la hipótesis de partida.
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Estadística inferencial")
#sstitle("Tipos de errores")
#slide[
  #styled-table(
    columns: (auto, 1fr, 1fr),
    th[Decisión], th[$H_0$ es verdadera], th[$H_1$ es verdadera],
    td[*Rechazar $H_0$*],
    td[#text(fill: rgb("#dc2626"))[*Error Tipo I* ($alpha$)]],
    tdg[Decisión correcta (potencia)],
    td[*No rechazar $H_0$*],
    tdg[Decisión correcta],
    td[#text(fill: rgb("#dc2626"))[*Error Tipo II* ($beta$)]],
  )
  #v(12pt)
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    block(stroke: 2pt + cm3, inset: 12pt, radius: 5pt)[
      #text(fill: cm3, weight: "light", size: 16pt, tracking: 3pt)[#upper[Error Tipo I]]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Rechazar $H_0$ cuando es verdadera.
        Su probabilidad es el *nivel de significancia* $alpha$ (típicamente $0.05$).
      ]
    ],
    block(stroke: 2pt + cm1, inset: 12pt, radius: 5pt)[
      #text(fill: cm1, weight: "light", size: 16pt, tracking: 3pt)[#upper[Error Tipo II]]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        No rechazar $H_0$ cuando es falsa.
        Su probabilidad es $beta$; la *potencia* de la prueba es $1 - beta$.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Estadística inferencial")
#sstitle("Valor P")
#slide[
  #grid(columns: (0.7fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
      El *valor p* es la probabilidad de obtener un resultado igual o más extremo que el observado, *suponiendo que $H_0$ es verdadera*:
      ]

      $ p = P("resultado" >= "observado" | H_0) $

      #v(8pt)
      #scale(90%)[
      #styled-table(
        columns: (auto, 1fr),
        th[Valor p], th[Interpretación],
        td[$p < 0.05$],   tdg[Evidencia significativa contra $H_0$],
        td[$p < 0.01$],   tdg[Evidencia muy significativa],
        td[$p >= 0.05$],  tdg[No hay evidencia suficiente para rechazar $H_0$],
      )
      ]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        El valor p *no* es la probabilidad de que $H_0$ sea verdadera.
        Es una medida de sorpresa de los datos bajo $H_0$.
      ]
    ],
    align(center + horizon,
      figure(image("images/pvalue_visualization.png", height: 250pt))
    ),
  )
]

// ════════════════════════════════════════════════════════════════════════════
// TEST T DE STUDENT — UNA MUESTRA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Test T — una muestra", subtitle: "Contraste sobre la media poblacional")

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Test T — una muestra")
#sstitle("Objetivo")
#slide[
  Permite responder: *¿es compatible la media de mi muestra con un valor de referencia poblacional $mu_0$?*

  #v(12pt)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 14pt,
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Situación típica]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        Una sola muestra. \
        Un valor de referencia conocido ($mu_0$). \
        Variable continua.
      ]
    ],
    block(stroke: 2pt + cm2, inset: 14pt, radius: 5pt)[
      #ssstitle[Pregunta]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        ¿Podría esta muestra provenir de una población con media $mu_0$?
      ]
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Ejemplos]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        ¿La temperatura media de los pacientes es distinta de 37 °C? \
        ¿El pH medio de las muestras difiere de 7?
      ]
    ],
  )
  #v(12pt)
  #text(fill: gry, size: 13pt)[
    *Prerequisito:* la variable debe ser aproximadamente normal o el tamaño muestral suficientemente grande ($n > 30$).
    Si no se cumple, usar el *test de Wilcoxon de una muestra* como alternativa no paramétrica.
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Test T — una muestra")
#sstitle("Definición y supuestos")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
        Permite evaluar si la *media de una muestra* es diferente de una media de referencia $mu_0$.
      ]
      $ t = frac(overline(x) - mu_0, frac(s, sqrt(n))) $
      #v(2pt)
      #text(fill: gry, size: 12pt)[
        Donde $s$ es la desviación estándar muestral y $n$ el tamaño.
        El estadístico $t$ sigue una distribución *T de Student* con $n - 1$ grados de libertad.
      ]
      #v(2pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Supuesto], th[Descripción],
        td[Normalidad], tdg[La variable es continua y normal en la población (robusto para $n > 30$ por TLC)],
        td[Independencia], tdg[Cada observación es independiente],
      )
      // #v(2pt)
      // #block(stroke: 1pt + gry, inset: 10pt, radius: 4pt, width: 100%)[
      //   #text(fill: gry, size: 12pt)[*Alternativa no paramétrica:* si no se cumple normalidad con $n$ pequeño, usar el *test de Wilcoxon de una muestra* (`wilcoxon(data - mu0)`).]
      // ]
    ],
    align(center + horizon,
      figure(image("images/t_test_one_sample.png", height: 240pt))
    ),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Test T — una muestra")
#sstitle("Tipos de hipótesis alternativa")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #styled-table(
        columns: (auto, 1fr),
        th[$H_1$], th[Valor p],
        td[$mu > mu_0$ (cola derecha)],  tdg[$p = 1 - "CDF"_T(t)$],
        td[$mu < mu_0$ (cola izquierda)], tdg[$p = "CDF"_T(t)$],
        td[$mu != mu_0$ (dos colas)],    tdg[$p = 2 times min("CDF"_T(t),\ 1-"CDF"_T(t))$],
      )
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        En distribuciones simétricas el p-value bilateral es simplemente el doble del menor de los p-values unilaterales.
        En distribuciones asimétricas se adopta la misma convención por practicidad.
      ]
    ],
    align(center + horizon,
      figure(image("images/t_test_tails.png", height: 270pt))
    ),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Test T — una muestra")
#sstitle("Uso en Python")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Una cola (mayor)]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from scipy.stats import ttest_1samp
          import numpy as np

          sample = np.random.normal(loc=0.3, scale=1, size=50)

          # H1: mu > 0
          result = ttest_1samp(sample, popmean=0, alternative='greater')
          print(result.statistic, result.pvalue)

          # H1: mu != 0 (dos colas, por defecto)
          result2 = ttest_1samp(sample, popmean=0)
          ```
        ]
      )
    ],
    [
      #ssstitle[Cálculo manual]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from scipy.stats import t
          import numpy as np

          sample = np.random.normal(loc=0.3, scale=1, size=50)
          mu0 = 0
          n   = len(sample)
          df  = n - 1

          t_stat = (sample.mean() - mu0) / (sample.std(ddof=1) / np.sqrt(n))

          # p-value cola derecha
          p_value = 1 - t.cdf(t_stat, df=df)
          ```
        ]
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// INTERVALOS DE CONFIANZA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Intervalos de confianza", subtitle: "Estimación con incertidumbre")

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Intervalos de confianza")
#sstitle("Concepto")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      Un *intervalo de confianza (IC)* es un rango de valores calculado desde una muestra para estimar un parámetro poblacional desconocido.

      $ "IC"_(1-alpha) = overline(x) ± t_(alpha/2, n-1) frac(s, sqrt(n)) $

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Con *nivel de confianza* $1 - alpha$ (ej. 95 %), indica que si repitiéramos el muestreo muchas veces, el intervalo capturaría el verdadero parámetro en el $100(1-alpha)$% de los casos.
        - Un IC más estrecho implica mayor precisión.
        - El ancho depende de $n$, $s$ y del nivel de confianza elegido.
      ]
    ],
    align(center + horizon,
      figure(image("images/confidence_interval.png", height: 270pt))
    ),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Intervalos de confianza")
#sstitle("Variables categóricas — intervalo de proporción")
#slide[
  #v(12pt)
  #text(fill: gry, size: 14pt)[
    Una variable categórica binaria (éxito/fracaso) tiene como parámetro de interés
    la *proporción poblacional* $p$. La proporción muestral $hat(p) = k\/n$ es el estimador puntual;
    el IC cuantifica su incertidumbre.
  ]
  #v(8pt)
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Wald — aproximación normal]
      #v(4pt)
      $ hat(p) ± z_(alpha/2) sqrt(frac(hat(p)(1-hat(p)), n)) $
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Requiere $n hat(p) >= 5$ y $n(1-hat(p)) >= 5$.
        Falla cuando $hat(p)$ está cerca de 0 o 1: el intervalo puede salir del rango $[0,1]$.
      ]
    ],
    [
      #ssstitle[Wilson — score interval]
      #v(4pt)
      $ frac(\
        hat(p) + frac(z^2, 2n) ± z sqrt(frac(hat(p)(1-hat(p)), n) + frac(z^2, 4n^2)),\
        1 + frac(z^2, n)\
      ) $
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Siempre dentro de $[0,1]$. Recomendado cuando $hat(p)$ es extremo o $n$ es pequeño.
        Es el método por defecto en la práctica estadística moderna.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Intervalos de confianza")
#sstitle("Variables categóricas — ejemplo")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Situación]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        Se observan *3 éxitos en 20 ensayos*. \
        $hat(p) = 3\/20 = 0.15$
        #v(10pt)
        ¿Cuál es el IC al 95 % para la proporción poblacional $p$?
      ]
      #v(16pt)
      #styled-table(
        columns: (auto, auto, 1fr),
        th[Método], th[IC 95 %], th[Observación],
        td[*Wald*],   td[$[-0.006,\, 0.306]$], td[#text(fill: rgb("#dc2626"))[Límite inferior negativo]],
        td[*Wilson*], td[$[0.051,\, 0.361]$],  tdg[Siempre dentro de $[0,1]$],
      )
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        Wald falla porque $n hat(p) = 3 < 5$: la aproximación normal no es válida.
        Wilson corrige este problema sin requerir muestras grandes.
      ]
    ],
    [
      #ssstitle[Python]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from statsmodels.stats.proportion \
              import proportion_confint

          # Wald
          lo, hi = proportion_confint(
              count=3, nobs=20,
              alpha=0.05, method='normal')
          print(f"Wald:   [{lo:.3f}, {hi:.3f}]")
          # → [-0.006,  0.306]

          # Wilson
          lo, hi = proportion_confint(
              count=3, nobs=20,
              alpha=0.05, method='wilson')
          print(f"Wilson: [{lo:.3f}, {hi:.3f}]")
          # → [ 0.051,  0.361]
          ```
        ]
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// BONDAD DE AJUSTE
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "Bondad de ajuste", subtitle: "χ² · Kolmogorov-Smirnov · Normalidad")

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Bondad de ajuste")
#sstitle("Objetivo")
#slide[
  Permiten medir *cuán verosímil* es que una muestra haya sido obtenida aleatoriamente de una distribución teórica dada.
  #v(2pt)
  #figure(image("images/goodness_of_fit.png", height: 240pt))
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Bondad de ajuste")
#sstitle("Prueba χ² de bondad de ajuste")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      $ chi^2 = sum_(i=1)^k frac((O_i - E_i)^2, E_i) $

      #text(fill: gry, size: 14pt)[donde $O_i$ son frecuencias *observadas* y $E_i$ las *esperadas* bajo $H_0$.]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Característica], th[Descripción],
        td[Tipo de datos],    tdg[Discreta o continua discretizada (bins)],
        td[Grados de libertad], tdg[$k - 1 -$ (parámetros estimados)],
        td[Tamaño muestral], tdg[Relativamente grande ($E_i >= 5$ por celda)],
        td[Sensibilidad],    tdg[Depende de la elección de los bins],
      )
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Un $chi^2$ grande indica que los datos se alejan del modelo esperado.
      ]
    ],
    [
      // #figure(image("images/chi2_goodness_bins.png", height: 140pt))
      // #v(4pt)
      #figure(image("images/chi2_goodness_cdf.png", height: 240pt))
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Bondad de ajuste")
#sstitle("Prueba de Kolmogorov-Smirnov")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size: 14pt)[
        Compara la *CDF empírica* de la muestra con la CDF teórica bajo $H_0$.
        Su estadístico $D$ es la *máxima diferencia* entre ambas curvas:

        $ D = sup_x |"ECDF"_n(x) - F_0(x)| $
      ]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Aspecto], th[Descripción],
        td[$H_0$],       tdg[La muestra sigue la distribución teórica],
        td[$D = 0$],     tdg[Ambas distribuciones son idénticas],
        td[Ventaja],     tdg[No requiere discretización],
        td[Limitación],  tdg[Menos sensible en las colas que *Anderson-Darling*; sensibilidad uniforme en toda la distribución],
      )
    ],
    align(center + horizon,
      figure(image("images/ks_one_sample.png", height: 270pt))
    ),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Bondad de ajuste")
#sstitle("Pruebas de normalidad")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Shapiro-Wilk]
      #v(2pt)
      #text(fill: gry, size: 12pt)[
        La prueba más potente para verificar normalidad con muestras pequeñas ($n < 50$).
        Compara los cuantiles muestrales con los esperados bajo normalidad.
      ]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Aspecto], th[Descripción],
        td[$H_0$],        tdg[La muestra proviene de una distribución normal],
        td[Potencia],     tdg[Alta para $n$ pequeño],
        td[Limitación],   tdg[Menos fiable para $n > 50$],
      )
      #v(8pt)
      #ssstitle[Anderson-Darling]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        Variante de KS que pondera más las colas.
        Más potente que KS cuando interesan las desviaciones en los extremos.
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
          from scipy.stats import shapiro, anderson
          import numpy as np
          data = np.random.normal(loc=0, scale=1, size=30)
          # Shapiro-Wilk
          stat, p = shapiro(data)
          print(f"W = {stat:.4f}, p = {p:.4f}")
          # p < 0.05 → evidencia contra normalidad
          # Anderson-Darling
          result = anderson(data, dist='norm')
          print(result.statistic)
          # Comparar con result.critical_values
          # según result.significance_level
          ```
        ]
      )
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Para elegir entre pruebas de medias: verificar normalidad con
        Shapiro-Wilk; si se rechaza y $n$ es pequeño, usar alternativa no paramétrica.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// IGUALDAD DE VARIANZAS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Igualdad de varianzas", subtitle: "F · Bartlett · Levene")

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Igualdad de varianzas")
#sstitle("Objetivo")
#slide[
  Verifican si *k grupos tienen la misma variabilidad poblacional*. Son un *prerequisito* para elegir correctamente el test de comparación de medias.

  #v(10pt)
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[¿Por qué importa?]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        El test de *Student* asume varianzas iguales (homocedasticidad). Si las varianzas son distintas, Student puede dar resultados incorrectos — es necesario usar *Welch* en su lugar.
      ]
      #v(10pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Resultado], th[Acción],
        td[$p >= 0.05$], tdg[Varianzas iguales → usar *Student*],
        td[$p < 0.05$],  tdg[Varianzas distintas → usar *Welch*],
      )
    ],
    [
      #ssstitle[Flujo de decisión]
      #v(10pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Condición], th[Test recomendado],
        td[Datos normales, 2 grupos],   tdg[Test F],
        td[Datos normales, k grupos],   tdg[Bartlett],
        td[Sin normalidad o outliers],  tdg[Levene],
      )
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        En la práctica, *Levene* es la opción más segura: no exige normalidad y es válido para cualquier número de grupos.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Igualdad de varianzas")
#sstitle("Test F de igualdad de varianzas")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      Evalúa si *dos poblaciones normales* tienen la *misma varianza*.

      $ F = frac(s_1^2, s_2^2) $

      #v(6pt)
      #text(fill: gry, size: 14pt)[Se coloca la mayor varianza en el numerador para obtener $F >= 1$.]

      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Aspecto], th[Descripción],
        td[$H_0$],          tdg[$sigma_1^2 = sigma_2^2$],
        td[Distribución],   tdg[$F$ con $(n_1-1, n_2-1)$ g.l.],
        td[Supuesto clave], tdg[Normalidad en ambas poblaciones],
        td[Sensibilidad],   tdg[Muy sensible a desviaciones de normalidad],
      )
    ],
    align(center + horizon,
      figure(image("images/f_test_distribution.png", height: 270pt))
    ),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Igualdad de varianzas")
#sstitle("Test de Bartlett")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size: 14pt)[
        Extiende el test F a *k ≥ 2 grupos*. Compara las varianzas muestrales con la varianza combinada ponderada bajo $H_0: sigma_1^2 = sigma_2^2 = dots = sigma_k^2$.
      ]
      #v(2pt)
      #align(center)[
        #scale(80%)[
          $ chi^2 = frac((n - k) ln s_p^2 - sum_(i=1)^k (n_i - 1) ln s_i^2, 1 + frac(1, 3(k-1)) (sum_i frac(1, n_i - 1) - frac(1, n-k))) $
        ]
      ]
      #v(2pt)
      #text(fill: gry, size: 13pt)[donde $s_p^2 = frac(sum (n_i - 1) s_i^2, n - k)$ es la varianza combinada.]
      #v(2pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Aspecto], th[Descripción],
        td[$H_0$],          tdg[$sigma_1^2 = dots = sigma_k^2$],
        td[Distribución],   tdg[$chi^2$ con $k - 1$ g.l.],
        td[Supuesto clave], tdg[*Normalidad* en cada grupo (muy sensible)],
        td[Cuándo usarlo],  tdg[Datos confirmadamente normales (verificar con Shapiro-Wilk)],
      )
    ],
    [
      #ssstitle[Ejemplo — 3 tratamientos]
      #v(2pt)
      #text(fill: gry, size: 12pt)[
        Expresión génica en 3 grupos de tratamiento. \
        ¿Tienen la misma variabilidad?
      ]
      #v(2pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          import numpy as np
          from scipy.stats import bartlett
          rng = np.random.default_rng(42)
          g1 = rng.normal(5.0, 1.0, 20)
          g2 = rng.normal(5.5, 1.0, 20)
          g3 = rng.normal(5.2, 2.5, 20)  # más disperso
          stat, p = bartlett(g1, g2, g3)
          print(f"χ² = {stat:.3f}, p = {p:.4f}")
          # → χ² = 14.2,  p = 0.0008
          # g3 tiene varianza significativamente distinta
          ```
        ]
      )
      #v(2pt)
      #text(fill: gry, size: 11pt)[
        $p < 0.05$ → las varianzas *no son iguales*. \
        Usar *Welch* en lugar de Student para comparar medias,
        o *Levene* si no se puede confirmar normalidad.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Igualdad de varianzas")
#sstitle("Test de Levene")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size: 12pt)[
        Alternativa *robusta* a Bartlett para datos *no normales* o con outliers.
        En lugar de comparar las varianzas directamente, compara las *desviaciones absolutas respecto a la mediana de cada grupo*.
      ]
      #align(center)[
      #scale(80%)[
      $ W = frac((n - k) sum_i n_i (overline(z)_i - overline(z))^2, (k - 1) sum_i sum_j (z_(i j) - overline(z)_i)^2) $
        ]
      ]

      #text(fill: gry, size: 11pt)[donde $z_(i j) = |y_(i j) - tilde(y)_i|$ (desviación absoluta)).]
      #styled-table(
        columns: (0.5fr, 1fr),
        th[Aspecto], th[Descripción],
        td[$H_0$],          tdg[$sigma_1^2 = dots = sigma_k^2$],
        td[Distribución],   tdg[$F$ con $(k-1,\, n-k)$ g.l.],
        td[Supuesto clave], tdg[Ninguno distribucional],
        td[Cuándo usarlo],  tdg[Si no se puede confirmar normalidad],
      )
    ],
    [
      #ssstitle[Ejemplo — mismos datos]
      #v(1pt)
      #text(fill: gry, size: 12pt)[
        Mismos 3 grupos del ejemplo anterior. \
        Levene no asume normalidad: resultado más fiable.
      ]
      #v(1pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 12pt)[
          ```python
          from scipy.stats import levene
          # center='median' usa la mediana (más robusto)
          # center='mean'   reproduce el test de Levene clásico
          stat, p = levene(g1, g2, g3, center='median')
          print(f"W = {stat:.3f}, p = {p:.4f}")
          # → W = 10.1,  p = 0.0002
          # Confirma varianzas distintas, sin asumir normalidad
          ```
        ]
      )
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Test], th[Usar cuando],
        td[*Bartlett*], tdg[Datos normales confirmados],
        td[*Levene*],   tdg[Datos con outliers o asimétricos],
        td[*F*],        tdg[Solo 2 grupos con normalidad estricta],
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// IGUALDAD DE MEDIAS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("6", "Igualdad de medias", subtitle: "Student · Welch · No paramétricos")

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Igualdad de medias")
#sstitle("Objetivo")
#slide[
  Contrastan si *dos o más grupos tienen la misma media poblacional*. La elección del test depende de los supuestos que cumplan los datos.

  #v(10pt)
  #styled-table(
    columns: (auto, auto, auto, 1fr),
    th[Grupos], th[Normalidad], th[Varianzas], th[Test],
    td[2, independientes], td[Sí], td[Iguales],   tdg[*Student*],
    td[2, independientes], td[Sí], td[Distintas],  tdg[*Welch*],
    td[2, apareados],      td[Sí], td[—],          tdg[*Student apareado*],
    td[2, independientes], td[No], td[—],           tdg[*Mann-Whitney U*],
    td[2, apareados],      td[No], td[—],           tdg[*Wilcoxon signed-rank*],
    td[k > 2],             td[Sí], td[Iguales],    tdg[*ANOVA*],
    td[k > 2],             td[No], td[—],           tdg[*Kruskal-Wallis*],
  )
  #v(10pt)
  #text(fill: gry, size: 13pt)[
    *Flujo recomendado:* verificar normalidad (Shapiro-Wilk) → verificar varianzas (Levene) → elegir test.
    Si algún supuesto falla y $n$ es pequeño, preferir siempre la alternativa no paramétrica.
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Igualdad de medias")
#sstitle("Test de Student y Welch — dos muestras")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #figure(image("images/two_samples_comparison.png", height: 200pt))
      #v(4pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from scipy.stats import ttest_ind
          # Student (varianzas iguales)
          ttest_ind(a, b, equal_var=True)
          # Welch (varianzas desiguales)
          ttest_ind(a, b, equal_var=False)
          ```
        ]
      )
    ],
    [
      #styled-table(
        columns: (auto, 1fr),
        th[Test], th[Cuándo usarlo],
        td[*Student*], tdg[Varianzas iguales (verificar con F/Levene)],
        td[*Welch*],   tdg[Varianzas distintas o desconocidas — más robusto],
      )
      #v(10pt)
      #ssstitle[Muestras apareadas]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Si las dos muestras corresponden a los *mismos individuos* en dos condiciones (antes/después), usar el *test de Student apareado*:
      ]
      #v(4pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from scipy.stats import ttest_rel
          ttest_rel(before, after)
          ```
        ]
      )
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Igualdad de medias")
#sstitle("Alternativas no paramétricas")
#slide[
  #styled-table(
    columns: (auto, 1fr, 1fr),
    th[Test], th[Equivalente paramétrico], th[Descripción],
    td[*Mann-Whitney U*],
    tdg[Student (muestras independientes)],
    tdg[Compara rangos de dos muestras independientes. No asume normalidad.],
    td[*Wilcoxon signed-rank*],
    tdg[Student (muestras apareadas)],
    tdg[Analiza el signo de las diferencias en muestras pareadas.],
    td[*Test de la mediana*],
    tdg[Student / Mann-Whitney],
    tdg[Caso especial del $chi^2$: tabla de contingencia sobre la mediana global.],
  )
  #v(10pt)
  #block(
    width: 88%, fill: rgb("#f0fdf4"),
    stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
    text(size: 13pt)[
      ```python
      from scipy.stats import mannwhitneyu, wilcoxon
      mannwhitneyu(x, y, alternative='two-sided')   # Mann-Whitney
      wilcoxon(before - after)                       # Wilcoxon
      ```
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Igualdad de medias")
#sstitle("Más de dos grupos — ANOVA y Kruskal-Wallis")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[ANOVA de un factor]
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        Extiende el T-test a *k > 2 grupos*. Compara variabilidad *entre grupos* vs. *dentro de grupos*:
        $ F = frac(S S_"entre" \/ (k-1), S S_"dentro" \/ (n-k)) $
        *Supuestos:* normalidad en cada grupo, homogeneidad de varianzas, independencia.
      ]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from scipy.stats import f_oneway
          f_oneway(grupo_a, grupo_b, grupo_c)
          ```
        ]
      )
    ],
    [
      #ssstitle[Kruskal-Wallis]
      #v(2pt)
      #text(fill: gry, size: 14pt)[
        Alternativa *no paramétrica* a ANOVA. Compara distribuciones de rangos entre grupos. No asume normalidad.
      ]
      #v(2pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from scipy.stats import kruskal
          kruskal(grupo_a, grupo_b, grupo_c)
          ```
        ]
      )
      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Test], th[Usar cuando],
        td[*ANOVA*],          tdg[Normalidad + homocedasticidad],
        td[*Kruskal-Wallis*], tdg[Sin normalidad o con outliers],
      )
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Un resultado significativo indica que *al menos un grupo difiere*. Para saber cuáles, aplicar pruebas *post-hoc* (Tukey, Dunn).
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// COMPARACIÓN DE DOS MUESTRAS — FORMA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("7", "Comparación — forma", subtitle: "KS · χ² · dos muestras")

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Comparación — forma")
#sstitle("Objetivo")
#slide[
  #text(size:14pt)[
    Contrastan si *dos muestras provienen de la misma distribución*, sin
    especificar cuál. No comparan un parámetro aislado (media, varianza) sino la
    *distribución completa*.
  ]

  #v(10pt)
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Diferencia con igualdad de medias]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        Dos distribuciones pueden tener la *misma media* pero diferir en forma, varianza o colas.
        Estos tests detectan *cualquier diferencia distribucional*, no solo en la media.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Cuándo usarlos]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - Comparar perfiles completos de dos grupos. \
        - Verificar que dos muestras son intercambiables. \
        - Datos continuos (*KS*) o categóricos (*χ²*).
      ]
    ],
  )
  #v(10pt)
  #styled-table(
    columns: (auto, auto, 1fr),
    th[Test], th[Tipo de datos], th[Detecta],
    td[*KS dos muestras*],  tdg[Continuo],   tdg[Diferencias en cualquier punto de la distribución],
    td[*χ² dos muestras*],  tdg[Categórico], tdg[Diferencias en la frecuencia relativa de cada categoría],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Comparación — forma")
#sstitle("KS de dos muestras")
#slide[
  #grid(columns: (0.8fr, 1fr), gutter: 16pt,
    [
      #text(size: 12pt)[
        El *test KS de dos muestras* responde: ¿provienen dos conjuntos de datos de la *misma distribución*?

        $ D = sup_x |"ECDF"_1(x) - "ECDF"_2(x)| $
      ]
      #v(2pt)
      #text(fill: gry, size: 14pt)[
        - No asume ninguna forma distribucional.
        - Compara visualmente las funciones de distribución acumulada.
        - Un $D$ grande indica que las distribuciones son distintas.
        - Es sensible a diferencias en cualquier parte de la distribución (centro, colas, forma).
      ]
      #v(2pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          from scipy.stats import ks_2samp
          stat, pvalue = ks_2samp(sample_a, sample_b)
          ```
        ]
      )
    ],
    align(center + horizon,
      figure(image("images/ks_two_sample.png", height: 160pt))
    ),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Comparación — forma")
#sstitle("χ² de dos muestras")
#slide[
  #text(size: 14pt)[
    Compara la *distribución de categorías* entre dos grupos. Pregunta: ¿la proporción de cada categoría es la misma en ambos grupos?
  ]
  #v(10pt)
  #text(fill: gry, size: 13pt)[Se construye una tabla de contingencia grupo × categoría y se aplica el estadístico χ²:]
  #v(6pt)
  $ chi^2 = sum_(i,j) frac((O_(i j) - E_(i j))^2, E_(i j)), quad E_(i j) = frac(n_(i dot) dot n_(dot j), n) $
  #v(12pt)
  #styled-table(
    columns: (auto, 1fr),
    th[Aspecto], th[Descripción],
    td[$H_0$],              tdg[Ambos grupos tienen la misma distribución de categorías],
    td[Grados de libertad], tdg[$(r - 1)(c - 1)$, donde $r$ = grupos y $c$ = categorías],
    td[Requisito],          tdg[$E_(i j) >= 5$ en cada celda; si no, usar Fisher exacto],
    td[Diferencia con bondad de ajuste], tdg[Aquí la distribución de referencia no es teórica sino la del otro grupo],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Comparación — forma")
#sstitle("χ² de dos muestras — ejemplo")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Situación]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        200 pacientes asignados a dos tratamientos. \
        ¿Difiere la *distribución de respuestas* entre grupos?
      ]
      #v(10pt)
      #styled-table(
        columns: (auto, auto, auto, auto),
        th[Grupo], th[Mejoró], th[Igual], th[Empeoró],
        td[*Trat. A*], td[60], td[25], td[15],
        td[*Trat. B*], td[40], td[35], td[25],
      )
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        $chi^2 = 8.33$, $p = 0.015$, g.l. $= 2$
      ]
      #v(6pt)
      #block(stroke: 1.5pt + cm3, inset: 10pt, radius: 4pt)[
        #text(fill: cm2, size: 13pt)[$p < 0.05$ → las distribuciones de respuesta *difieren significativamente*. El tratamiento A tiene más mejoras; el B, más resultados neutros y negativos.]
      ]
    ],
    [
      #ssstitle[Python]
      #v(2pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          import numpy as np
          from scipy.stats import chi2_contingency

          tabla = np.array([[60, 25, 15],
                            [40, 35, 25]])
          chi2, p, dof, expected = chi2_contingency(tabla)
          print(f"χ²  = {chi2:.2f}")   # → 8.33
          print(f"p   = {p:.3f}")      # → 0.015
          print(f"gl  = {dof}")        # → 2
          print("Frecuencias esperadas:")
          print(expected)
          # [[50. 30. 20.]
          #  [50. 30. 20.]]
          ```
        ]
      )
      #text(fill: gry, size: 11pt)[
        `expected` muestra las frecuencias esperadas bajo $H_0$ (distribución idéntica en ambos grupos).
        Verificar que todas sean $>= 5$ antes de interpretar el resultado.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// MCNEMAR · FISHER · MANTEL-HAENSZEL
// ════════════════════════════════════════════════════════════════════════════
#section-divider("8", "McNemar · Fisher · MH", subtitle: "Tablas de contingencia apareadas y estratificadas")

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Variables categóricas")
#sstitle("Objetivo")
#slide[
  Cuando ambas variables son *categóricas* y el χ² estándar no es aplicable: muestras pequeñas, diseño apareado o presencia de una variable de confusión.

  #v(10pt)
  #styled-table(
    columns: (auto, auto, 1fr),
    th[Test], th[Diseño], th[Pregunta],
    td[*Fisher exacto*],     tdg[Independiente, 2×2 con $n$ pequeño], tdg[¿Las dos variables categóricas son independientes?],
    td[*McNemar*],           tdg[Apareado, 2×2],                      tdg[¿Cambia la distribución binaria entre dos condiciones en los mismos individuos?],
    td[*Mantel-Haenszel*],   tdg[Estratificado, k tablas 2×2],        tdg[¿Hay asociación entre dos variables controlando por una tercera?],
  )
  #v(10pt)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 12pt,
    block(stroke: 2pt + cm3, inset: 10pt, radius: 5pt)[
      #text(fill: cm3, size: 13pt, weight: "bold")[Fisher]
      #v(4pt)
      #text(fill: gry, size: 13pt)[Celdas con frecuencia esperada < 5. Alternativa exacta al χ².]
    ],
    block(stroke: 2pt + cm2, inset: 10pt, radius: 5pt)[
      #text(fill: cm2, size: 13pt, weight: "bold")[McNemar]
      #v(4pt)
      #text(fill: gry, size: 13pt)[Mismo individuo medido dos veces. Análogo categórico del T apareado.]
    ],
    block(stroke: 2pt + cm1, inset: 10pt, radius: 5pt)[
      #text(fill: cm1, size: 13pt, weight: "bold")[Mantel-Haenszel]
      #v(4pt)
      #text(fill: gry, size: 13pt)[Variable de confusión presente. Evita la paradoja de Simpson.]
    ],
  )
]

// ── McNemar ──────────────────────────────────────────────────────────────────
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Test de McNemar")
#sstitle("Concepto y estructura")
#slide[
  #text(size: 14pt)[
    Evalúa si una *variable binaria cambia* entre dos condiciones medidas en los *mismos individuos*.
    Trabaja sobre los *pares discordantes* — los concordantes no aportan información sobre el cambio neto.
  ]
  #v(10pt)
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #styled-table(
        columns: (auto, auto, auto),
        th[], th[Post: Sí], th[Post: No],
        td[*Pre: Sí*], td[$a$ (concordante)], td[$b$ (discordante)],
        td[*Pre: No*], td[$c$ (discordante)], td[$d$ (concordante)],
      )
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        Solo $b$ y $c$ determinan el resultado. \
        $H_0$: $b = c$ (no hay cambio neto en la población).
      ]
    ],
    [
      $ chi^2_"McNemar" = frac((b - c)^2, b + c) $
      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Aspecto], th[Descripción],
        td[Distribución],  tdg[$chi^2$ con 1 g.l.],
        td[Versión exacta], tdg[Binomial cuando $b + c < 25$],
        td[Análogo a],     tdg[T de Student apareado, para variable binaria],
        td[No confundir con], tdg[χ² de independencia: aquí los individuos son los mismos],
      )
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Test de McNemar")
#sstitle("Ejemplo — efectividad de vacuna")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Situación]
      #v(0pt)
      #text(fill: gry, size: 12pt)[
        100 pacientes. Estado (infectado / no infectado) registrado *antes y después* de la vacunación. ¿Produjo la vacuna un cambio significativo?
      ]
      #v(0pt)
      #align(center)[
      #scale(70%, reflow: true)[
        #styled-table(
          columns: (auto, auto, auto),
          th[], th[Post: No inf.], th[Post: Inf.],
          td[*Pre: No inf.*], td[40 ($a$)], td[10 ($b$)],
          td[*Pre: Inf.*],    td[30 ($c$)], td[20 ($d$)],
        )
      ]
      ]
      #v(0pt)
      #text(fill: gry, size: 12pt)[
        b = 10 (estaban infectados y mejoraron) \
        c = 30 (no estaban infectados y empeoraron)
      ]
      #align(center)[
        #scale(70%, reflow: true)[
      $ chi^2 = frac((10 - 30)^2, 10 + 30) = frac(400, 40) = 10.0 $
        ]
      ]
      #block(stroke: 1.5pt + cm3, inset: 6pt, radius: 4pt)[
        #text(fill: cm2, size: 11pt)[$p = 0.0016$ → la vacuna produjo un *cambio significativo*. Más individuos empeoraron ($c = 30$) que mejoraron ($b = 10$), lo que sugiere que la vacuna no fue efectiva.]
      ]
    ],
    [
      #ssstitle[Python]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          import numpy as np
          from statsmodels.stats.contingency_tables \
              import mcnemar
          # Tabla [[a, b], [c, d]]
          tabla = np.array([[40, 10],
                            [30, 20]])
          # exact=False → aproximación chi-cuadrado
          # exact=True  → test binomial exacto
          result = mcnemar(tabla, exact=False)
          print(f"χ² = {result.statistic:.1f}")
          print(f"p  = {result.pvalue:.4f}")
          # → χ² = 10.0
          # → p  = 0.0016
          ```
        ]
      )
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Usar `exact=True` cuando $b + c < 25$ para obtener el p-valor exacto mediante la distribución binomial.
      ]
    ],
  )
]

// ── Fisher ───────────────────────────────────────────────────────────────────
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Test exacto de Fisher")
#sstitle("Concepto y estructura")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size: 12pt)[
        Alternativa exacta al χ² de independencia para tablas *2×2 con frecuencias esperadas pequeñas* (< 5).
        Calcula directamente la probabilidad de observar una tabla *igual o más extrema* bajo $H_0$, usando la distribución *hipergeométrica*.
      ]
      #v(8pt)
      $ P = frac(\(a+b\)! \(c+d\)! \(a+c\)! \(b+d\)!, n!\, a!\, b!\, c!\, d!) $
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        No exige ningún tamaño mínimo de celda. Recomendado siempre que alguna frecuencia esperada sea < 5.
      ]
      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Aspecto], th[Descripción],
        td[$H_0$],       tdg[Las dos variables son independientes],
        td[Salida],      tdg[p-valor exacto + odds ratio],
        td[Limitación],  tdg[Solo para tablas 2×2 (usar Freeman-Halton para tablas mayores)],
      )
    ],
    [
      #ssstitle[Ejemplo — reacción a fármaco]
      #v(6pt)
      #text(fill: gry, size: 12pt)[
        Ensayo pequeño (n = 14): ¿el fármaco A produce más reacciones que el B?
      ]
      #v(4pt)
      #styled-table(
        columns: (auto, auto, auto),
        th[Fármaco], th[Reacción], th[Sin reacción],
        td[*A*], td[7], td[0],
        td[*B*], td[1], td[6],
      )
      #text(fill: gry, size: 10pt)[
        Frecuencias esperadas < 5 → χ² no válido. Fisher exacto: \
        $p = 0.0014$ → *asociación altamente significativa*.
      ]
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 11pt)[
          ```python
          import numpy as np
          from scipy.stats import fisher_exact
          tabla = np.array([[7, 0], [1, 6]])
          odds, pvalue = fisher_exact(tabla, alternative='two-sided')
          print(f"p = {pvalue:.4f}")
          # →  p = 0.0014
          ```
        ]
      )
    ],
  )
]

// ── Mantel-Haenszel ───────────────────────────────────────────────────────────
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Test de Mantel-Haenszel")
#sstitle("Concepto y estructura")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size: 14pt)[
        Evalúa la asociación entre dos variables categóricas *controlando por una variable de confusión* (estratificador).
        Combina tablas 2×2 de cada estrato en un único estadístico global y estima el *odds ratio ajustado*.
      ]
      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Paso], th[Descripción],
        td[1. Estratificar], tdg[Dividir datos en $K$ subgrupos según la variable de confusión],
        td[2. Tabla por estrato], tdg[Construir una tabla 2×2 en cada estrato],
        td[3. Combinar], tdg[Sumar estadísticos ponderados por tamaño de estrato],
        td[4. OR ajustado], tdg[$hat("OR")_"MH" = sum_k frac(a_k d_k \/ n_k, sum_k b_k c_k \/ n_k)$],
      )
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Sin estratificación, la *variable de confusión* puede crear o enmascarar una asociación real (*paradoja de Simpson*).
      ]
    ],
    [
      #ssstitle[¿Por qué estratificar?]
      #v(6pt)
      #text(size: 13pt)[
        Una variable de confusión está asociada *tanto* con el factor de exposición *como* con el resultado.
        Si no se controla, distorsiona la asociación observada.
      ]
      #v(8pt)
      #block(
        width: 100%, fill: rgb("#fff7ed"),
        stroke: 0.5pt + rgb("#f97316"), inset: (x: 10pt, y: 8pt), radius: 4pt,
        [
          #text(size: 13pt, weight: "bold")[Paradoja de Simpson]
          #v(4pt)
          #text(size: 13pt)[
            Una tendencia observable en los datos *globales* puede *invertirse o desaparecer* al dividir por subgrupos.
            El análisis crudo lleva a una conclusión *opuesta* a la correcta.
          ]
        ]
      )
    ],
  )
]

// ── Mantel-Haenszel — Ejemplo (paradoja de Simpson) ───────────────────────────
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Test de Mantel-Haenszel")
#sstitle("Ejemplo — la paradoja de Simpson en la práctica")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Análisis crudo (sin controlar)]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        Ensayo clínico: Tratamiento A vs. B. Resultado: mortalidad a 30 días.
      ]
      #v(6pt)
      #styled-table(
        columns: (auto, auto, auto, auto),
        th[Tratamiento], th[Muertos], th[Vivos], th[Mort. %],
        td[A],  td[30], td[70],  td[*30 %*],
        td[B],  td[20], td[80],  td[*20 %*],
      )
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#fef2f2"),
        stroke: 0.5pt + rgb("#ef4444"), inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          OR crudo = *1.71* → parece que el Tratamiento A *mata más*.
          ¿Conclusión? "Evitar A".
        ]
      )
      #v(6pt)
      #text(fill: gry, size: 12pt)[
        Pero... el hospital asigna B a pacientes *leves* (buen pronóstico) y A a pacientes *graves*.
        La *severidad* confunde la comparación.
      ]
    ],
    [
      #ssstitle[Análisis estratificado por severidad]
      #v(4pt)
      #styled-table(
        columns: (auto, auto, auto, auto),
        th[Estrato], th[Trat.], th[Muertos], th[Vivos],
        td[*Leve*],   td[A], td[5],  td[45],
        td[*Leve*],   td[B], td[15], td[75],
        td[*Grave*],  td[A], td[25], td[25],
        td[*Grave*],  td[B], td[5],  td[5],
      )
      #v(6pt)
      #styled-table(
        columns: (auto, auto),
        th[Estrato], th[OR estrato],
        td[Leve],  tdg[0.56  (A *protege*)],
        td[Grave], tdg[0.50  (A *protege*)],
      )
      #v(4pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          *OR#sub[MH] ajustado = 0.54* → Tratamiento A *reduce* la mortalidad en ambos estratos.
          La conclusión *se invierte* al controlar la confusión.
        ]
      )
    ],
  )
]

// ── Mantel-Haenszel — Código Python ──────────────────────────────────────────
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Test de Mantel-Haenszel")
#sstitle("Ejemplo — código Python")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size: 13pt)[
        Cada tabla 2×2 tiene la forma:
        #v(4pt)
        #styled-table(
          columns: (auto, auto, auto),
          th[], th[Resultado+], th[Resultado−],
          td[Expuesto (A)],  tdg[$a$], tdg[$b$],
          td[No expuesto (B)], tdg[$c$], tdg[$d$],
        )
        #v(8pt)
        `StratifiedTable` de `statsmodels` acepta una *lista* de matrices 2×2, una por estrato, y calcula automáticamente el OR ajustado y el p-valor global.
      ]
      #v(8pt)
      #text(fill: gry, size: 12pt)[
        Si p < 0.05 → asociación significativa *después* de controlar la confusión.
        OR#sub[MH] < 1 indica que la exposición (A) *reduce* el evento.
      ]
    ],
    [
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
        text(size: 12pt)[
          ```python
          import numpy as np
          from statsmodels.stats.contingency_tables \
              import StratifiedTable

          # Estrato 1: pacientes leves
          #        A      B
          t1 = np.array([[5,  45],   # muertos, vivos
                         [15, 75]])

          # Estrato 2: pacientes graves
          t2 = np.array([[25, 25],
                         [5,  5]])

          st = StratifiedTable([t1, t2])
          print(st.oddsratio_pooled)   # OR_MH ≈ 0.54
          res = st.test_null_odds()
          print(res.pvalue)            # p-valor global
          print(res.statistic)         # estadístico χ²_MH
          ```
        ]
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// BOOTSTRAP
// ════════════════════════════════════════════════════════════════════════════
#section-divider("9", "Bootstrap", subtitle: "Inferencia no paramétrica por remuestreo")

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Bootstrap")
#sstitle("Método")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size: 14pt)[
        El *método bootstrap* estima la variabilidad de un estadístico *remuestreando la muestra original con reemplazo*, sin suponer ninguna distribución teórica para la población.
      ]
      #v(10pt)
      #text(fill: gry, size: 14pt)[La idea central: si la muestra es representativa de la población, remuestrearla simula lo que pasaría al tomar nuevas muestras reales.]
      #v(10pt)
      #grid(columns: (1fr, 1fr), gutter: 10pt,
        block(stroke: 1.5pt + cm3, inset: 8pt, radius: 4pt)[
          #text(fill: cm3, size: 12pt, weight: "bold")[Ventajas]
          #text(fill: gry, size: 12pt)[
            - No asume distribución normal
            - Aplicable a cualquier estadístico
            - Robusto ante outliers
          ]
        ],
        block(stroke: 1.5pt + cm1, inset: 8pt, radius: 4pt)[
          #text(fill: cm1, size: 12pt, weight: "bold")[Limitaciones]
          #text(fill: gry, size: 12pt)[
            - Requiere $n$ suficientemente grande
            - Computacionalmente costoso
            - No mejora una muestra sesgada
          ]
        ],
      )
    ],
    [
      #styled-table(
        columns: (auto, 1fr),
        th[Paso], th[Descripción],
        td[1. Remuestrear], tdg[Extraer $n$ observaciones *con reemplazo* de la muestra original],
        td[2. Calcular],    tdg[Obtener el estadístico de interés en esa réplica ($overline(x)$, mediana, $r$, …)],
        td[3. Repetir],     tdg[$B$ veces — típicamente $B = 1000$ a $10000$],
        td[4. Resumir],     tdg[La distribución de los $B$ valores es la *distribución bootstrap*],
        td[5. IC],          tdg[Percentiles 2.5 % y 97.5 % → IC al 95 %],
      )
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Bootstrap")
#sstitle("Ejemplo — IC para la media")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Situación]
      #v(2pt)
      #text(fill: gry, size: 12pt)[
        Muestra pequeña ($n = 6$) con distribución desconocida.
        Se quiere un IC al 95 % para la *media*.
        #v(6pt)
        Datos: $[2.1, 3.4, 2.8, 4.0, 3.1, 2.5]$
        #v(6pt)
        Media muestral: $overline(x) = 2.98$
      ]
      #v(2pt)
      #ssstitle[Resultado]
      #v(2pt)
      #scale(90%)[
        #styled-table(
          columns: (auto, auto, 1fr),
          th[Método], th[IC 95 %], th[Observación],
          td[*T de Student*], td[$[2.46, 3.51]$], tdg[Supone normalidad],
          td[*Bootstrap*],    td[$[2.57, 3.42]$], tdg[Sin supuestos distribucionales],
        )
      ]
      #v(2pt)
      #text(fill: gry, size: 10pt)[
        Con $n$ pequeño y distribución incierta, bootstrap ofrece una alternativa sin supuestos. Con muestras grandes ambos métodos convergen.
      ]
    ],
    [
      #ssstitle[Python]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          import numpy as np
          rng  = np.random.default_rng(42)
          data = np.array([2.1, 3.4, 2.8, 4.0, 3.1, 2.5])
          n    = len(data)
          B    = 5000
          boots = [
            np.mean(
              rng.choice(data, size=n, replace=True)
            ) for _ in range(B)
          ]
          lo, hi = np.percentile(boots, [2.5, 97.5])
          print(f"IC 95 %: [{lo:.2f}, {hi:.2f}]")
          # → IC 95 %: [2.57, 3.42]
          ```
        ]
      )
      #v(2pt)
      #text(fill: gry, size: 13pt)[
        `rng.choice(..., replace=True)` genera una réplica bootstrap.
        `np.percentile` extrae los límites del IC por el *método de los percentiles*.
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
    Variables, distribuciones y pruebas de hipótesis
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
