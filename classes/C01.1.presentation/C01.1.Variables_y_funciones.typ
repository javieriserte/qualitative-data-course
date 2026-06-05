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
  "Variables y distribuciones",
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
  #set text(size: 17pt)
  #set par(leading: 1.1em)
  + Variables aleatorias y funciones de distribución
  + Variables aleatorias discretas y continuas
  + Niveles de medición
  + Distribuciones paramétricas y no paramétricas
  + Distribuciones importantes \
    #text(fill: gry, size: 14pt)[Normal · T · Poisson · Binomial · Multinomial · Chi-cuadrado]
]

// ════════════════════════════════════════════════════════════════════════════
// VARIABLES ALEATORIAS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Variables aleatorias", subtitle: "Tipos, niveles de medición y rol en el análisis")
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Variables aleatorias")
#sstitle("Concepto")
#slide[
  Una *variable aleatoria* es una magnitud que puede tomar distintos valores como
  resultado de un *proceso aleatorio* o de *variabilidad natural*.

  #v(10pt)
  #figure(image("images/variables_plot.png", height: 230pt))
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Variables aleatorias")
#sstitle("Tipos según su naturaleza")
#slide[
  #styled-table(
    columns: (auto, 1fr, 1fr),
    th[Tipo], th[Descripción], th[Ejemplo],
    td[*Categórica / cualitativa*],
    td[
      Representa grupos o categorías, sin significado numérico directo.
      #text(fill: gry)[
        - *Nominal:* sin orden
        - *Ordinal:* con orden
      ]
    ],
    td[Especie, color, nivel educativo],
    td[*Cuantitativa / numérica*],
    td[
      Representa cantidades medibles.
      #text(fill: gry)[
        - *Discreta:* valores enteros
        - *Continua:* cualquier valor real
      ]
    ],
    td[Edad, peso, temperatura],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Variables aleatorias")
#sstitle("Rol dentro del análisis")
#slide[
  #styled-table(
    columns: (1fr, 1fr, 1fr),
    th[Tipo], th[Definición], th[Ejemplo],
    td[*Variable explicativa \ (independiente)*],
    td[La que se controla o manipula],
    td[Tipo de tratamiento, dosis],
    td[*Variable de respuesta \ (dependiente)*],
    td[La que se mide como resultado],
    td[Expresión génica, rendimiento],
  )
  #v(14pt)
  #text(fill: gry, size: 14pt)[
    Los métodos para variables *ordinales* no pueden aplicarse a *nominales*.
    Los métodos para *nominales* pueden usarse con *ordinales*, pero pierden información del orden.
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// PMF / PDF / CMF / CDF
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Funciones de probabilidad", subtitle: "PMF · PDF · CMF · CDF")
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Funciones de probabilidad")
#sstitle("PMF — Función de masa de probabilidad")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size: 14pt)[
        Describe cómo se distribuye la probabilidad entre los valores posibles
        de una *variable aleatoria discreta*.

        Para cada valor $x$ del dominio:
        $ "PMF"_X (x) = P(X = x) $
      ]

      #text(fill: gry, size: 14pt)[
        - Cada barra representa la probabilidad *exacta* de ese valor. \
        - Todos los valores son $>= 0$. \
        - La suma de todas las barras es *exactamente 1*:
      ]
      #v(4pt)
      $ sum_x "PMF"_X (x) = 1 $
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - No tiene sentido evaluar la PMF fuera de su dominio discreto.
      ]
    ],
    [
      #align(center+horizon)[
        #figure(image("images/pmf_example.png", height: 250pt))
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// PDF
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Funciones de probabilidad")
#sstitle("PDF — Función de densidad de probabilidad")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
        Describe la distribución de probabilidad de una *variable aleatoria
        continua*.

        La probabilidad de caer en un intervalo $[a, b]$ es el *área bajo la curva*:
        $ P(a <= X <= b) = integral_a^b "PDF"_X (x) dif x $
      ]
      #text(fill: gry, size: 12pt)[
        - En un punto aislado, $P(X = a) = 0$.
        - El área total bajo la curva es 1:
      ]
      $ integral_(-oo)^(oo) "PDF"_X (x) dif x = 1 $
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        - La altura de la curva es *densidad*, no probabilidad directa.
        - Puede tomar valores mayores que 1 si el dominio es muy estrecho.
      ]
    ],
    [
      #align(center+horizon)[
        #figure(image("images/pdf_example.png", height: 250pt))
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// CMF
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Funciones de probabilidad")
#sstitle("CMF — Función de masa acumulada")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      Acumula la probabilidad de una variable *discreta* hasta un valor dado:

      $ "CMF"_X (x) = P(X <= x) = sum_(k <= x) "PMF"_X (k) $

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Tiene forma de *escalera*: sube en cada valor del dominio. \
        - Parte en 0 y llega a 1. \
        - Es monótona no decreciente. \
        - Útil para calcular probabilidades de intervalos:
      ]
      #v(4pt)
      $ P(a < X <= b) = "CMF"_X (b) - "CMF"_X (a) $
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        - El salto en cada escalón es exactamente $"PMF"_X (x)$.
      ]
    ],
    [
      #align(center+horizon)[
        #figure(image("images/cmf_example.png", height: 250pt))

      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// CDF
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Funciones de probabilidad")
#sstitle("CDF — Función de distribución acumulada")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      Acumula la probabilidad de una variable *continua* hasta un valor dado:

      $ "CDF"_X (x) = P(X <= x) = integral_(-oo)^(x) "PDF"_X (u) dif u $

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Curva *continua*, monótona creciente, rango $[0, 1]$. \
        - Su derivada es la PDF: $"PDF"_X (x) = frac(d, d x) "CDF"_X (x)$. \
        - Probabilidad de un intervalo:
      ]
      $ P(a < X <= b) = "CDF"_X (b) - "CDF"_X (a) $
      #v(4pt)
      #text(fill: gry, size: 14pt)[
        - Complementaria (*CCDF*): probabilidad de exceder un umbral:
      ]
      $ "CCDF"(x) = P(X > x) = 1 - "CDF"_X (x) $
    ],
    figure(image("images/cdf_example.png", height: 220pt)),
  )
]

// ════════════════════════════════════════════════════════════════════════════
// NIVELES DE MEDICIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Niveles de medición", subtitle: "Nominal · Ordinal · Intervalar · Racional")
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Niveles de medición")
#sstitle("Escalas de medición")
#slide[
  #styled-table(
    columns: (auto, 1fr, auto, 1fr),
    th[Nivel], th[Descripción], th[Operaciones], th[Ejemplos],
    td[*Nominal*],
    tdg[Categorías sin orden ni distancia definida],
    td[`==`, `!=`],
    tdg[Tipo de sangre, especie, color de flor],
    td[*Ordinal*],
    tdg[Categorías con orden, pero sin distancias iguales entre niveles],
    td[`<`, `>`, `<=`, `>=`],
    tdg[Nivel de expresión (bajo/medio/alto), escala de dolor],
    td[*Intervalar*],
    tdg[Distancias iguales y significativas, pero el *cero es arbitrario*],
    td[`+`, `-`],
    tdg[Temperatura en °C, año calendario, pH],
    td[*Racional*],
    tdg[Cero absoluto: indica ausencia real del atributo medido],
    td[`*`, `/`],
    tdg[Peso, concentración proteica, longitud, edad],
  )
  #v(8pt)
  #text(fill: gry, size: 13pt)[
    Las escalas son *jerárquicas*: cada nivel incluye todas las operaciones del nivel inferior.
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Niveles de medición")
#sstitle("Intervalar vs. Racional — distinción clave")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 18pt,
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Escala Intervalar]
      #v(8pt)
      El cero es una *convención*, no indica ausencia del atributo.

      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - 0 °C no significa "ausencia de temperatura". \
        - Las diferencias son válidas: \
          #text(fill: cm2)[20 °C − 10 °C = 10 °C ✓] \
        - Los *ratios no tienen sentido*: \
          #text(fill: cm2)[20 °C ≠ "el doble de calor" que 10 °C ✗] \
        - Otros ejemplos: año calendario (el año 0 no es "ausencia de tiempo"),
          pH (0 no es "ausencia de acidez").
      ]
    ],
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Escala Racional]
      #v(8pt)
      El cero *sí* indica ausencia real del atributo medido.

      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - 0 kg significa "ausencia de masa". \
        - Diferencias válidas: \
          #text(fill: cm2)[20 kg − 10 kg = 10 kg ✓] \
        - *Ratios también válidos*: \
          #text(fill: cm2)[20 kg = el doble que 10 kg ✓] \
        - Otros ejemplos: concentración proteica (0 = ausencia), longitud,
          tiempo transcurrido, número de células.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Niveles de medición")
#sstitle("Estadísticos y métodos válidos por escala")
#slide[
  #styled-table(
    columns: (auto, 1fr, 1fr),
    th[Nivel], th[Estadísticos válidos], th[Pruebas estadísticas típicas],
    td[*Nominal*],
    tdg[Moda, frecuencias, proporciones],
    tdg[Chi-cuadrado, Fisher exacto],
    td[*Ordinal*],
    tdg[Mediana, percentiles, rango intercuartílico],
    tdg[Mann-Whitney, Kruskal-Wallis, Spearman],
    td[*Intervalar*],
    tdg[Media, desviación estándar, correlación de Pearson],
    tdg[t de Student, ANOVA, regresión lineal],
    td[*Racional*],
    tdg[Todo lo anterior + media geométrica, coeficiente de variación],
    tdg[Los mismos que Intervalar; además permiten comparar razones],
  )
  #v(8pt)
  #text(fill: gry, size: 13pt)[
    Usar un estadístico de un nivel superior sobre datos de nivel inferior produce
    resultados *sin interpretación válida* (ej. calcular la media de grupos nominales).
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// DISTRIBUCIONES — GENERAL
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "Distribuciones", subtitle: "Paramétricas y no paramétricas")
#pagebreak()
#counter-display
#stitle("Unidad I", sub: "Distribuciones")
#sstitle("Paramétricas vs. no paramétricas")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    block(stroke: 2pt + cm3, inset: 10pt, radius: 5pt)[
      #ssstitle[Paramétricas]
      #v(2pt)
      #text(size: 14pt)[
      La forma de la distribución está dada por un *modelo matemático teórico*
      que describe el proceso generador de los datos.
      ]
      #v(2pt)
      #text(fill: gry, size: 14pt)[
        - Uno o más *parámetros* controlan la forma (ej. $mu$, $sigma$, $lambda$).
        - Suponen que los datos provienen de un proceso conocido.
        - Más eficientes cuando el supuesto es correcto: necesitan *menos datos*
          para estimar bien. \
        - Si el supuesto es incorrecto, las conclusiones pueden ser erróneas.
      ]
      #v(2pt)
      #text(fill: cm2, size: 14pt)[*Ejemplos:* Normal, Exponencial, Poisson, Binomial]
    ],
    block(stroke: 2pt + cm1, inset: 10pt, radius: 5pt)[
      #ssstitle[No paramétricas]
      #v(2pt)
      #text(size: 14pt)[
      La distribución se *construye directamente a partir de los datos*,
      sin asumir ninguna forma funcional de antemano.
      ]
      #v(2pt)
      #text(fill: gry, size: 14pt)[
        - No dependen de supuestos sobre el proceso generador.
        - Más robustas frente a datos atípicos o distribuciones irregulares.
        - Requieren *más datos* para describir la distribución con precisión.
        - La distribución cambia si se agregan nuevas observaciones.
      ]
      #v(2pt)
      #text(fill: cm2, size: 14pt)[*Ejemplos:* Histograma, KDE, distribución empírica]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// DISTRIBUCIÓN NORMAL
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4.1", "Distribución Normal", subtitle: "Gaussiana · Teorema Central del Límite")
#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Normal")
#sstitle("Distribución Normal (Gaussiana)")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      También llamada *distribución de Gauss* o *Gaussiana*.
      #v(2pt)
      #text(fill: gry, size: 14pt)[Dos parámetros de forma:]
      #v(2pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Parámetro], th[Rol],
        td[$mu$ (promedio)],  tdg[Desplaza la campana sobre el eje X],
        td[$sigma$ (desv. est.)], tdg[Controla el ancho y altura de la campana],
      )
      #v(2pt)
      Normal estándar: $cal(N)(0, 1)$ con $mu=0$, $sigma=1$
      #v(2pt)
      $ f(x) = frac(1, sigma sqrt(2 pi)) exp lr(( -frac((x - mu)^2, 2 sigma^2) )) $
    ],
    align(
      center+horizon,
      figure(image("images/normal_description.png", height: 250pt)),
    )
  )
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Normal")
#sstitle("Efecto del parámetro mu")
#slide[
  #figure(image("images/normal_mu.png", height: 295pt))
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Normal")
#sstitle("Efecto del parámetro sigma")
#slide[
  #figure(image("images/normal_sigma.png", height: 295pt))
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Normal")
#sstitle("Teorema Central del Límite")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
        Para una muestra de tamaño $n$ con valores i.i.d., media $mu$ y
        desviación estándar $sigma$, la distribución de la media muestral
        converge a:
      ]

      $ overline(x_n) tilde cal(N) lr(( mu, frac(sigma, sqrt(n)) )) quad "cuando" n -> oo $

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Aplica *independientemente* de la distribución original. \
        - A mayor $n$, la distribución de $overline(x_n)$ se concentra
          más alrededor de $mu$. \
        - La dispersión decrece como $sigma / sqrt(n)$: duplicar el
          tamaño de muestra reduce el error a la mitad. \
        - Es la base teórica de la mayoría de los intervalos de
          confianza y pruebas de hipótesis.
      ]
    ],
    align(
      center+horizon,
      figure(image("images/central_limit.png", height: 320pt)),
    )
  )
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Normal")
#sstitle("Generación de datos aleatorios")
#slide[
  #figure(image("images/normal_sample.png", height: 220pt))
  #v(8pt)
  #block(
    width: 88%, fill: rgb("#f0fdf4"),
    stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
    [
      ```python
      from scipy.stats import norm
      normal_sample = norm.rvs(loc=0, scale=1, size=1000)
      # Obtenemos una lista de 1000 valores aleatorios
      ```
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Normal")
#sstitle("PDF y CDF en Python")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[PDF — densidad en un punto]
      #v(6pt)
      #text(fill: gry, size: 14pt)[¿Cuál es la densidad en $x = 1.0$ para $cal(N)(0,1)$?]
      #v(4pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size:14pt)[
          ```python
          from scipy.stats import norm

          # PDF en un punto
          orm.pdf(1.0, loc=0, scale=1)
          # → 0.2420

          # PDF en varios puntos
          import numpy as np
          x = np.linspace(-3, 3, 100)
          y = norm.pdf(x, loc=0, scale=1)
          ```
        ]
      )
    ],
    [
      #ssstitle[CDF — probabilidad acumulada]
      #v(6pt)
      #text(fill: gry, size: 14pt)[¿Qué fracción de datos cae por debajo de $x = 1.96$?]
      #v(4pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size:14pt)[
          ```python
          from scipy.stats import norm

          # P(X <= 1.96)
          norm.cdf(1.96, loc=0, scale=1)
          # → 0.9750

          # P(X > 1.96) — complementaria
          norm.sf(1.96, loc=0, scale=1)
          # → 0.0250

          # P(-1.96 <= X <= 1.96)
          norm.cdf(1.96) - norm.cdf(-1.96)
          # → 0.9500
          ```
        ]
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// DISTRIBUCIÓN T
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4.2", "Distribución T de Student", subtitle: "Muestras pequeñas · Colas pesadas")
#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "T de Student")
#sstitle("Distribución T — Origen y concepto")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
        Aparece cuando se quiere estimar la media de una población *normal*
        a partir de una muestra pequeña y la *desviación estándar poblacional
        es desconocida*.

        Se estandariza la media muestral usando $S_n$ (desviación de la muestra)
        en lugar de $sigma$:
      ]

      $ t = frac(overline(X_n) - mu, frac(S_n, sqrt(n))) $

      #v(6pt)
      #text(fill: gry, size: 14pt)[
        Esta cantidad sigue una distribución T con $nu = n - 1$ *grados de
        libertad*, no una normal, porque $S_n$ introduce incertidumbre extra
        al ser también estimada a partir de los datos.
      ]
    ],
    [
      #ssstitle[¿Por qué no usar la Normal?]
      #v(2pt)
      #text(fill: gry, size: 14pt)[
        Con $sigma$ conocida, la media estandarizada sigue exactamente $cal(N)(0,1)$.
        Al *estimar* $sigma$ con $S_n$ a partir de pocos datos:
      ]
      #styled-table(
        columns: (auto, 1fr),
        th[$n$ pequeño], th[Efecto],
        td[$n < 30$],   tdg[$S_n$ es muy variable → colas más pesadas que la Normal],
        td[$n = 30$],   tdg[La T ya es muy similar a $cal(N)(0,1)$],
        td[$n -> oo$],  tdg[La T converge exactamente a $cal(N)(0,1)$],
      )
      #text(fill: gry, size: 13pt)[
        Las colas pesadas reflejan la mayor incertidumbre con muestras pequeñas.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "T de Student")
#sstitle("Distribución T — Forma y propiedades")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(fill: gry, size: 14pt)[Función de densidad de probabilidad:]
      $ "PDF"_T (x, nu) = frac(Gamma lr(( frac(nu+1, 2) )), sqrt(nu pi) dot Gamma lr(( frac(nu, 2) ))) lr(( 1 + frac(x^2, nu) ))^(-frac(nu+1, 2)) $

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Propiedad], th[Valor],
        td[Dominio],   tdg[$(-oo, +oo)$],
        td[Simetría],  tdg[Simétrica alrededor de 0],
        td[Media],     tdg[$E[X] = 0$ para $nu > 1$],
        td[Varianza],  tdg[$frac(nu, nu-2)$ para $nu > 2$ — siempre $> 1$],
        td[Parámetro], tdg[$nu = n - 1$ grados de libertad],
      )
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        $Gamma$ es la función Gamma, generalización del factorial.
      ]
    ],
    align(
      center+horizon,
      figure(image("images/distribution_t.png", height: 250pt)),
    )
  )
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "T de Student")
#sstitle("Distribución T — Uso en Python")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[PDF y CDF]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size:14pt)[
          ```python
          from scipy.stats import t

          df = 10  # grados de libertad

          # densidad en x = 1.5
          t.pdf(1.5, df=df)  # → 0.1048

          # P(X <= 1.5)
          t.cdf(1.5, df=df)  # → 0.9177

          # valor crítico para alpha=0.05
          # (cola derecha bilateral)
          t.ppf(0.975, df=df)  # → 2.228
          ```
        ]
      )
    ],
    [
      #ssstitle[Muestra aleatoria]
      #v(6pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size:14pt)[
          ```python
          from scipy.stats import t
          import numpy as np
          import matplotlib.pyplot as plt

          df = 5
          sample = t.rvs(df=df, size=1000)

          x = np.linspace(-4, 4, 200)
          plt.plot(x, t.pdf(x, df=5), label="T (df=5)")
          plt.plot(x, t.pdf(x, df=30), label="T (df=30)")
          plt.legend()
          ```
        ]
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// DISTRIBUCIÓN DE POISSON
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4.3", "Distribución de Poisson", subtitle: "Conteo de eventos independientes")
#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Poisson")
#sstitle("Distribución de Poisson — Definición")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
        Modela el *número de veces que ocurre un evento* en una unidad fija
        de tiempo, espacio, área o volumen, cuando los eventos son:
        #v(2pt)
        #text(fill: gry, size: 12pt)[
          - *Independientes:* que ocurra uno no afecta al siguiente.
          - *A tasa constante:* la frecuencia media $lambda$ no cambia.
          - *No simultáneos:* dos eventos no co-ocurren en un instante.
        ]
      ]
      #text(size:14pt)[
        $ "PMF"(k, lambda) = frac(lambda^k, k!) e^(-lambda), quad k = 0, 1, 2, ... $
      ]
      #styled-table(
        columns: (auto, 1fr),
        th[Propiedad], th[Valor],
        td[Parámetro],  tdg[$lambda > 0$: tasa media de ocurrencia],
        td[Media],      tdg[$E[X] = lambda$],
        td[Varianza],   tdg[$"Var"[X] = lambda$ — media y varianza coinciden],
        td[Dominio],    tdg[$k in {0, 1, 2, ...}$],
      )
    ],
    [
      #ssstitle[Ejemplos de aplicación]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Número de mutaciones en una secuencia de ADN de longitud $L$. \
        - Número de lecturas de RNA-seq que mapean a un gen por unidad de tiempo. \
        - Llamadas recibidas en un call center por hora. \
        - Meteoritos que impactan la Tierra por año. \
        - Errores de tipeo por página de texto. \
        - Bacterias presentes en 1 mL de solución diluida.
      ]
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        La coincidencia $E[X] = "Var"[X] = lambda$ es una propiedad
        característica: si en datos reales la varianza supera mucho a
        la media, puede indicar *sobredispersión* y la Poisson no sería
        el modelo más adecuado.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Poisson")
#sstitle("Distribución de Poisson — Ejemplo")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Llamadas fraudulentas en 30 días]
      #v(2pt)
      #text(size:12pt)[
        Una persona recibe en promedio *77 llamadas fraudulentas al año*.
        ¿Cuántas es esperable que reciba en 30 días?
        #v(2pt)
        Calculamos $lambda$ escalando la tasa anual al período de interés:
      ]
      $ lambda = frac(77, 365) times 30 approx 6.33 $
      #styled-table(
        columns: (1fr, 1fr),
        th[Evento], th[Probabilidad],
        td[$P(X = 0)$ — ninguna],  tdg[$approx 0.0018$],
        td[$P(X = 6)$ — exacto 6], tdg[$approx 0.163$ ← barra roja],
        td[$P(X <= 6)$],           tdg[$approx 0.463$],
        td[$P(X > 10)$ — más de 10], tdg[$approx 0.082$],
      )
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        El valor más probable (*moda*) es $k = floor(lambda) = 6$.
      ]
    ],
    figure(image("images/poisson_example.png", height: 240pt)),
  )
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Poisson")
#sstitle("Distribución de Poisson — Uso en Python")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[PMF y CDF]
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size:14pt)[
          ```python
          from scipy.stats import poisson

          lam = 6.33  # lambda

          # P(X = 6)
          poisson.pmf(6, mu=lam)   # → 0.163

          # P(X <= 6)
          poisson.cdf(6, mu=lam)   # → 0.463

          # P(X > 10) — complementaria
          poisson.sf(10, mu=lam)   # → 0.082
          ```
        ]
      )
    ],
    [
      #ssstitle[Muestra aleatoria]
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size:14pt)[
          ```python
          from scipy.stats import poisson
          import numpy as np
          import matplotlib.pyplot as plt

          lam = 6.33
          k = np.arange(0, int(3 * lam))

          plt.bar(k, poisson.pmf(k, mu=lam))
          plt.xlabel("k")
          plt.ylabel("PMF(k, λ)")
          plt.title(f"Poisson(λ={lam})")
          ```
        ]
      )
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        `poisson.sf(k, mu)` es equivalente a
        `1 - poisson.cdf(k, mu)` pero más precisa
        numéricamente para probabilidades muy pequeñas.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// DISTRIBUCIÓN BINOMIAL
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4.4", "Distribución Binomial", subtitle: "Variables dicotómicas · Ensayos de Bernoulli")
#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Binomial")
#sstitle("Distribución Binomial — Definición")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
        Cuenta el número de *éxitos* en $n$ ensayos de Bernoulli
        independientes, cada uno con probabilidad de éxito $p$.

        $ P(X = k) = binom(n, k) p^k (1-p)^(n-k), quad 0 <= k <= n $
      ]
      #v(2pt)
      #text(fill: gry, size: 13pt)[donde $binom(n,k) = frac(n!, k!(n-k)!)$ cuenta las formas de elegir $k$ éxitos entre $n$ ensayos.]

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Propiedad], th[Valor],
        td[Condiciones],  tdg[$n$ fijo, $p$ constante, ensayos independientes],
        td[Dominio],      tdg[$k in {0, 1, ..., n}$],
        td[Media],        tdg[$E[X] = n p$],
        td[Varianza],     tdg[$"Var"[X] = n p (1-p)$],
        td[Moda],         tdg[$floor((n+1)p)$ o $ceil((n+1)p) - 1$],
      )
    ],
    [
      #ssstitle[Ejemplos de aplicación]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Número de pacientes que responden a un tratamiento entre $n$ tratados.
        - Número de variantes de un gen en $n$ individuos secuenciados.
      ]
      #v(10pt)
      #ssstitle[Conexión con otras distribuciones]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        - Si $n=1$: *distribución de Bernoulli* (un solo ensayo). \
        - Si $n$ grande y $p$ pequeño con $lambda = n p$ fijo: \
          la Binomial converge a una *distribución de Poisson*. \
        - Si $n$ grande: converge a una *Normal* $cal(N)(n p, sqrt(n p (1-p)))$ \
          (Teorema Central del Límite).
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Binomial")
#sstitle("Distribución Binomial — PMF y CMF")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[PMF]
      #v(4pt)
      #figure(image("images/binomial_pmf.png", height: 200pt))
      #text(fill: gry, size: 12pt)[
        Cada barra es la probabilidad exacta de exactamente $k$ éxitos.
        La forma depende de $n$ y $p$: simétrica si $p=0.5$, sesgada si $p$ se aleja de $0.5$.
      ]
    ],
    [
      #ssstitle[CMF]
      #v(4pt)
      #figure(image("images/binomial_cmf.png", height: 200pt))
      #text(fill: gry, size: 12pt)[
        Escalera que acumula probabilidad. Útil para calcular:
        $P(X <= k)$, $P(X >= k) = 1 - "CMF"(k-1)$, $P(a <= X <= b)$.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Binomial")
#sstitle("Distribución Binomial — Uso en Python")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[PMF y CDF]
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size:14pt)[
      ```python
      from scipy.stats import binom

      n, p = 20, 0.3

      # P(X = 6)
      binom.pmf(6, n=n, p=p)   # → 0.1916

      # P(X <= 8)
      binom.cdf(8, n=n, p=p)   # → 0.8867

      # P(X >= 9) — cola derecha
      binom.sf(8, n=n, p=p)    # → 0.1133

      # valor con P(X <= k) >= 0.95
      binom.ppf(0.95, n=n, p=p) # → 10
      ```
        ])
    ],
    [
      #ssstitle[Muestra aleatoria]
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size:14pt)[
      ```python
      from scipy.stats import binom
      import numpy as np
      import matplotlib.pyplot as plt

      n, p = 20, 0.3
      k = np.arange(0, n + 1)

      plt.bar(k, binom.pmf(k, n=n, p=p))
      plt.plot(k, binom.cdf(k, n=n, p=p),
        color="red", marker="o",
        label="CMF")
      plt.legend()
      ```
        ])
      #text(fill: gry, size: 13pt)[
        `binom.ppf(q, n, p)` devuelve el menor $k$ tal que
        $P(X <= k) >= q$ — útil para calcular cuantiles
        e intervalos de confianza discretos.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// DISTRIBUCIÓN MULTINOMIAL
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4.5", "Distribución Multinomial", subtitle: "Generalización de la Binomial")
#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Multinomial")
#sstitle("Distribución Multinomial — Definición")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(size:14pt)[
      Generalización de la Binomial para *más de dos categorías*:
      $n$ ensayos independientes, cada uno cae en una de $k$ categorías
      con probabilidades fijas $p_1, ..., p_k$ ($sum p_i = 1$).

      ]
      $ P(X_1=x_1, ..., X_k=x_k) = frac(n!, x_1 ! dots.c x_k !) p_1^(x_1) dots.c p_k^(x_k) $

      #text(fill: gry, size: 13pt)[con $sum x_i = n$ — el vector $(x_1,...,x_k)$ describe el resultado completo.]

      #styled-table(
        columns: (auto, 1fr),
        th[Condición], th[Descripción],
        td[$n$ fijo],      tdg[Total de ensayos conocido],
        td[$p_i$ fijos],   tdg[Probabilidades constantes en los ensayos],
        td[Independencia], tdg[Un ensayo no afecta a los demás],
        td[$sum p_i = 1$], tdg[Las categorías cubren todos los casos],
      )
    ],
    [
      #ssstitle[El coeficiente multinomial]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        El factor $frac(n!, x_1! dots.c x_k!)$ cuenta el número de
        *ordenamientos distintos* de $n$ objetos cuando hay $x_i$ de
        cada tipo $i$.
      ]
      #v(8pt)
      #ssstitle[Ejemplos de aplicación]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - Distribución de frecuencias de 4 bases nucleotídicas (A, T, C, G)
          en una secuencia de $n$ posiciones.
        - Recuento de votos entre $k$ candidatos en $n$ votantes.
        - Distribución de $n$ lecturas de RNA-seq entre $k$ genes.
      ]
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        Cuando $k=2$: $frac(n!, x_1! x_2!) p_1^(x_1) p_2^(x_2) = binom(n,x_1) p^(x_1)(1-p)^(x_2)$
        — se recupera la Binomial.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Multinomial")
#sstitle("Distribución Multinomial — Ejemplos")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[Composición de bases de ADN]
      #v(2pt)
      #text(size:14pt)[
        En una secuencia aleatoria de *$n = 10$ nucleótidos* con frecuencias
        iguales ($p = 0.25$ por base), ¿cuál es la probabilidad de observar
        exactamente 3 A, 2 T, 3 C y 2 G?
      ]
      $ P = frac(10!, 3! 2! 3! 2!) times 0.25^(10) approx 0.0643 $

      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size:14pt)[
      ```python
      from scipy.stats import multinomial

      p = [0.25, 0.25, 0.25, 0.25]
      x = [3, 2, 3, 2]

      multinomial.pmf(x, n=10, p=p)
      # → 0.0643
      ```
        ])
    ],
    [
      #ssstitle[Ejemplo: dados — todos diferentes]
      #v(2pt)
      #text(size:14pt)[
      6 dados, 6 categorías ($p_i = 1/6$), queremos un dado de cada valor:
      ]
      $ P = frac(6!, 1!^6) times (1/6)^6 = 720 times frac(1, 46656) approx 0.0154 $

      #v(2pt)
      #styled-table(
        columns: (1fr, 1fr),
        th[Evento], th[Probabilidad],
        td[Todos diferentes],      td[$approx 0.01543$],
        td[Exactamente 5 iguales], td[$approx 0.003858$],
        td[Exactamente 6 iguales], td[$approx 0.000129$],
        td[*Al menos 5 iguales*],  td[*$approx 0.003987$*],
      )
      #v(6pt)
      #text(fill: gry, size: 12pt)[Verificado con $10^7$ simulaciones Monte Carlo: $approx 0.003995$]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// DISTRIBUCIÓN CHI-CUADRADO
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4.6", "Distribución Chi-cuadrado", subtitle: "Desviación entre lo observado y lo esperado")
#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Chi-cuadrado")
#sstitle("Distribución Chi-cuadrado (χ²) — Definición")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      Si $Z_1, ..., Z_k tilde cal(N)(0,1)$ son independientes:

      $ X = sum_(i=1)^k Z_i^2 tilde chi^2 (k) $

      #v(6pt)
      #styled-table(
        columns: (1fr, 1fr),
        th[Propiedad], th[Valor],
        td[Dominio],  td[$X >= 0$],
        td[Media],    td[$E[X] = k$],
        td[Varianza], td[$"Var"[X] = 2k$],
        td[Forma],    tdg[Asimétrica a la derecha],
      )
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Cada término $Z_i^2$ es una *desviación al cuadrado* respecto
        a 0. Al sumarlas obtenemos una *medida total de variabilidad*.
        A medida que $k$ crece, la distribución se vuelve más simétrica
        (Teorema Central del Límite).
      ]
    ],
    figure(image("images/chi2_distribution.png", height: 250pt)),
  )
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Chi-cuadrado")
#sstitle("Distribución Chi-cuadrado (χ²) — Intuición")
#slide[
  #ssstitle[¿Qué mide realmente?]
  #v(2pt)
  #text(size:14pt)[
    La $chi^2$ cuantifica *cuánto difieren los datos observados de lo que
    esperaríamos si no hubiera ningún efecto*. La fórmula general es:
  ]
  $ chi^2 = sum_i frac((O_i - E_i)^2, E_i) $

  #text(fill: gry, size: 15pt)[donde $O_i$ son las frecuencias *observadas* y $E_i$ las *esperadas* bajo la hipótesis nula.]

  #v(2pt)
  #text(size:14pt)[
    #grid(columns: (1fr, 1fr), gutter: 14pt,
      block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
        *Si los datos se ajustan bien* al modelo esperado, los $(O_i - E_i)^2$ son pequeños
        → $chi^2$ pequeño → *no hay evidencia de diferencia*.
      ],
      block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
        *Si los datos se desvían mucho* del modelo esperado, los $(O_i - E_i)^2$ son grandes
        → $chi^2$ grande → *hay evidencia de diferencia*.
      ],
    )
  ]
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Chi-cuadrado")
#sstitle("Distribución Chi-cuadrado (χ²) — Ejemplo")
#slide[
  #ssstitle[¿El grupo sanguíneo es independiente del sexo?]
  #v(8pt)
  Se encuesta a 200 personas y se registra grupo sanguíneo (A, B, O, AB) y sexo.

  #v(6pt)
  #styled-table(
    columns: (auto, 1fr, 1fr, 1fr),
    th[], th[Hombre], th[Mujer], th[Total],
    td[*A*],  td[30], td[28], td[58],
    td[*B*],  td[12], td[18], td[30],
    td[*O*],  td[40], td[52], td[92],
    td[*AB*], td[ 8], td[12], td[20],
    td[*Total*], td[90], td[110], td[200],
  )
  #text(size:14pt)[
  En este ejemplo $v = (4 - 1) times (2 - 1) = 3$, grados de libertad.
  Si conozco los totales de la tabla, es 3 el mínimo número de datos que
  se requieren para poder calcular todos los valores de la tabla.
  ]
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Chi-cuadrado")
#sstitle("Distribución Chi-cuadrado (χ²) — Aplicaciones")
#slide[
  #styled-table(
    columns: (auto, 1fr),
    th[Uso], th[Descripción],
    td[*Prueba de independencia*],
    tdg[Evalúa si dos variables categóricas son independientes (tablas de contingencia)],
    td[*Prueba de bondad de ajuste*],
    tdg[Compara una distribución observada con una teórica esperada],
    td[*ANOVA*],
    tdg[Aparece en la derivación de las distribuciones F y t],
  )
  #v(10pt)
  #text(fill: gry, size: 14pt)[
    En todos los casos la lógica es la misma: un $chi^2$ grande indica que
    los datos observados son *poco compatibles* con la hipótesis de partida.
    El valor crítico depende de los grados de libertad y el nivel de significancia elegido.
  ]
]

#pagebreak()
#counter-display
#stitle("Distribuciones", sub: "Chi-cuadrado")
#sstitle("Distribución Chi-cuadrado (χ²)")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #ssstitle[PDF y CDF]
      #v(2pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size:14pt)[
          ```python
          from scipy.stats import chi2

          df = 5  # grados de libertad

          # densidad en x = 4.0
          chi2.pdf(4.0, df=df)   # → 0.1440

          # P(X <= 4.0)
          chi2.cdf(4.0, df=df)   # → 0.4506

          # P(X > 4.0) — cola derecha
          chi2.sf(4.0, df=df)    # → 0.5494

          # valor crítico al 5% (cola derecha)
          chi2.ppf(0.95, df=df)  # → 11.07
          ```
        ]
      )
    ],
    [
      #ssstitle[Graficar PDF para distintos ν]
      #v(2pt)
      #block(
        width: 100%, fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
        text(size:14pt)[
      ```python
      import numpy as np
      import matplotlib.pyplot as plt
      from scipy.stats import chi2

      x = np.linspace(0, 20, 500)

      for df in [1, 2, 5, 10]:
          plt.plot(
              x, chi2.pdf(x, df=df),
              label=f"ν = {df}"
          )

      plt.xlabel("χ²")
      plt.ylabel("Densidad")
      plt.legend(title="Grados de libertad")
      plt.xlim(0, 20)
      ```
        ]
      )
    ],
  )
]

#align(center+horizon)[
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

