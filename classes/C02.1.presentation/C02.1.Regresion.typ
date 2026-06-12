// ─── Paquetes externos ───────────────────────────────────────────────────────
#import "@preview/lilaq:0.6.0" as lq

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
  "Regresiones",
  "Modelos de regresión lineal y regularización",
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
  #set text(size: 17pt)
  #set par(leading: 1.1em)
  + Regresión lineal simple — formulación, interpretación y supuestos
  + Regresión lineal múltiple — extensión a varios predictores
  + Evaluación del modelo \
    #text(fill: gry, size: 14pt)[R² · Prueba t · Prueba F · Intervalos de confianza]
  + Diagnóstico de residuos \
    #text(fill: gry, size: 14pt)[Histograma · Q-Q plot · Leverage · Distancia de Cook]
  + Simulación — ejemplo práctico con Python
  + Extensiones del modelo básico \
    #text(fill: gry, size: 14pt)[R² ajustado · WLS · Colinealidad]
  + Regularización \
    #text(fill: gry, size: 14pt)[Ridge · Lasso · Elastic Net]
]

// ════════════════════════════════════════════════════════════════════════════
// 1. REGRESIÓN LINEAL SIMPLE
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Regresión Lineal Simple", subtitle: "Formulación · Interpretación · Supuestos")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Regresión Lineal Simple")
#sstitle("Interpretación geométrica")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      Se busca la *recta* que pase lo más cerca posible de todos los puntos,
      minimizando las distancias verticales al cuadrado.

      #v(8pt)
      $ Y_i = alpha + beta X_i + E_i $

      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Símbolo],
        th[Significado],
        td[$Y_i$],
        tdg[Valor observado de la variable dependiente],
        td[$alpha$],
        tdg[Intercepto — valor de Y cuando X = 0],
        td[$beta$],
        tdg[Pendiente — cambio en Y por unidad de X],
        td[$E_i$],
        tdg[Residuo: $E_i = Y_i - hat(Y)_i$],
        td[$hat(Y)_i$],
        tdg[Valor predicho por el modelo],
      )
    ],
    align(center + horizon, figure(image("images/geom_regression.png", height: 220pt))),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Regresión Lineal Simple")
#sstitle("Interpretación de los coeficientes")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      #ssstitle[Pendiente $beta$]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        Representa el *cambio esperado en Y* por cada unidad que aumenta X,
        manteniendo todo lo demás constante.
      ]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Signo de $beta$],
        th[Interpretación],
        td[$beta > 0$],
        tdg[Y aumenta cuando X aumenta],
        td[$beta < 0$],
        tdg[Y disminuye cuando X aumenta],
        td[$beta = 0$],
        tdg[X no explica linealmente a Y],
      )
    ],
    [
      #ssstitle[Intercepto $alpha$]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        Valor esperado de Y cuando X = 0. Solo tiene interpretación sustantiva
        cuando X = 0 es un valor posible en el contexto del problema.
      ]
      #v(8pt)
      #align(center, figure(image("images/coef_interpretation.png", height: 200pt)))
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Regresión Lineal Simple")
#sstitle("Solución analítica — mínimos cuadrados")
#slide[
  #grid(
    columns: (1fr, 1.6fr),
    gutter: 20pt,
    [
      #text(size: 14pt)[
        OLS minimiza la suma de cuadrados de los residuos:
      ]

      $ min_(alpha, beta) sum_(i=1)^n (Y_i - alpha - beta X_i)^2 $

      #text(size: 14pt)[
        La solución tiene forma cerrada:
      ]

      $ hat(beta) = frac("Cov"(X, Y), "Var"(X)) = r_(X Y) dot frac(s_Y, s_X) $

      $ hat(alpha) = overline(Y) - hat(beta) overline(X) $

      #text(fill: gry, size: 11pt)[
        La recta de regresión *siempre pasa por* $(overline(X), overline(Y))$.
      ]
    ],
    [
      #align(center + horizon, figure(image("images/ols_analytical.png", height: 200pt)))
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Regresión Lineal Simple")
#sstitle("Supuestos del modelo")
#slide[
  #styled-table(
    columns: (auto, 1fr, auto),
    th[Supuesto],
    th[Descripción],
    th[Consecuencia si se viola],
    td[*Linealidad*],
    tdg[La relación entre X e Y es lineal],
    tdg[Coeficientes sesgados],
    td[*Independencia*],
    tdg[Los residuos son independientes entre sí],
    tdg[Errores estándar inválidos],
    td[*Homocedasticidad*],
    tdg[Varianza del error constante para todo valor de X],
    tdg[Errores estándar inválidos — inferencia incorrecta],
    td[*Normalidad*],
    tdg[Los residuos siguen $cal(N)(0, sigma^2)$],
    tdg[Pruebas t y F aproximadas en muestras pequeñas],
    td[*Exogeneidad*],
    tdg[X no está correlacionada con el error E],
    tdg[Coeficientes sesgados e inconsistentes],
  )
  #v(10pt)
  #text(fill: gry, size: 13pt)[
    Los supuestos de *linealidad* y *exogeneidad* afectan la validez de los
    coeficientes. Los de *independencia*, *homocedasticidad* y *normalidad*
    afectan la validez de la inferencia (p-valores, intervalos de confianza).
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// 2. REGRESIÓN LINEAL MÚLTIPLE
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Regresión Lineal Múltiple", subtitle: "Extensión a varios predictores")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Regresión Lineal Múltiple")
#sstitle("Formulación general")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    text(14pt)[
      La regresión múltiple extiende el modelo simple a *k predictores*:

      $ Y = alpha + beta_1 X_1 + beta_2 X_2 + ... + beta_k X_k + E $

      #v(8pt)
      En notación matricial (más compacta para el caso general):

      $ bold(Y) = bold(X) bold(beta) + bold(E) $

      #v(6pt)
      donde $bold(X)$ es la *matriz de diseño* ($n times (k+1)$, con una
      columna de unos para el intercepto), $bold(beta)$ es el vector de
      coeficientes y $bold(E) tilde cal(N)(bold(0), sigma^2 bold(I))$.

      #v(8pt)
      La solución OLS tiene forma cerrada:

      $ hat(bold(beta)) = (bold(X)^top bold(X))^(-1) bold(X)^top bold(Y) $
    ],
    [
      #ssstitle[De simple a múltiple]
      #v(8pt)
      #styled-table(
        columns: (1fr, 1fr),
        th[Simple ($k=1$)],
        th[Múltiple ($k > 1$)],
        tdg[Recta en 2D],
        tdg[Hiperplano en $(k+1)$D],
        tdg[$hat(beta) = "Cov" slash "Var"$],
        tdg[$hat(bold(beta)) = (bold(X)^top bold(X))^(-1) bold(X)^top bold(Y)$],
        tdg[$R^2 = r_(X Y)^2$],
        tdg[$R^2$ ya no es cuadrado de una correlación simple],
        tdg[1 prueba t],
        tdg[1 prueba t por coeficiente + prueba F global],
        tdg[Sin colinealidad],
        tdg[Colinealidad posible entre predictores],
      )
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Regresión Lineal Múltiple")
#sstitle("Interpretación de los coeficientes parciales")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    text(size: 14pt)[
      En regresión múltiple cada $hat(beta)_j$ es un *coeficiente parcial*:

      #v(6pt)
      #block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
        $hat(beta)_j$ representa el cambio esperado en Y por cada unidad
        de $X_j$, *manteniendo fijas todas las demás variables*.
      ]

      #v(10pt)
      Esto tiene dos consecuencias importantes:

      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - El coeficiente de $X_j$ en regresión múltiple puede diferir
          —incluso en signo— del coeficiente en regresión simple, porque
          *controla* por los otros predictores \
        - Agregar o quitar variables cambia los coeficientes de las
          que ya estaban en el modelo
      ]
    ],
    [
      #ssstitle[Ejemplo — paradoja de Simpson]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Supongamos que se modela el rendimiento de plantas ($Y$) en función
        del riego ($X_1$) y la radiación solar ($X_2$).
      ]
      #v(6pt)
      #styled-table(
        columns: (1fr, 1fr),
        th[Modelo],
        th[$hat(beta)_"riego"$],
        tdg[$Y$ ~ $X_1$ (simple)],
        tdg[$+0.3$],
        tdg[$Y$ ~ $X_1 + X_2$ (múltiple)],
        tdg[$-0.1$],
      )
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        Si riego y radiación están correlacionados, ignorar $X_2$ puede
        producir un coeficiente de $X_1$ con signo incorrecto.
        La regresión múltiple *desconfunde* el efecto de cada variable.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Regresión Lineal Múltiple")
#sstitle("Supuesto adicional — no colinealidad")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      #text(size: 14pt)[
        La regresión simple tiene 4 supuestos. La regresión múltiple agrega uno:
      ]

      #v(1pt)
      #block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
        #text(size: 12pt)[
          *No colinealidad perfecta:* ninguna variable predictora puede ser
          combinación lineal exacta de otras. Si ocurre,
          $(bold(X)^top bold(X))$ es singular y $hat(bold(beta))$ no existe.
        ]
      ]

      #text(size: 12pt)[
        En la práctica la colinealidad es *parcial* (alta correlación, no exacta)
        y produce coeficientes inestables con errores estándar grandes.
      ]

      #text(size: 12pt)[
        Diagnóstico: *Factor de Inflación de la Varianza (VIF)*
        #align(center)[
          #scale(80%, reflow: true)[
            $ "VIF"_j = frac(1, 1 - R^2_j) $
          ]
        ]
      ]

      #text(size: 12pt)[
        donde $R^2_j$ es el $R^2$ de regresar $X_j$ contra todos
        los demás predictores. $"VIF" > 5$ es señal de alerta.
      ]
    ],
    [
      #ssstitle[VIF en Python]
      #v(8pt)
      #block(
        width: 100%,
        fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3,
        inset: (x: 12pt, y: 10pt),
        radius: 4pt,
        text(size: 13pt)[
          ```python
          from statsmodels.stats.outliers_influence \
              import variance_inflation_factor
          import statsmodels.api as sm
          import pandas as pd

          exog = sm.add_constant(X)

          vif = pd.DataFrame({
            "variable": exog.columns,
            "VIF": [
              variance_inflation_factor(
                exog.values, i)
              for i in range(exog.shape[1])
            ]
          })
          print(vif)
          ```
        ],
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 3. EVALUACIÓN DEL MODELO
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Evaluación del modelo", subtitle: "R² · Prueba t · Prueba F · Intervalos de confianza")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Evaluación del modelo")
#sstitle("Partición de la variabilidad")
#slide[
  #grid(
    columns: (1fr, 1.4fr),
    gutter: 20pt,
    [
      Toda la variabilidad de Y se descompone en dos partes:

      $
        underbrace(sum(Y_i - overline(Y))^2, SS_"tot") =
        underbrace(sum(hat(Y)_i - overline(Y))^2, SS_"reg") +
        underbrace(sum(Y_i - hat(Y)_i)^2, SS_"res")
      $

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Suma de cuadr.],
        th[Significado],
        td[$SS_"tot"$],
        tdg[Variabilidad total de Y alrededor de $overline(Y)$],
        td[$SS_"reg"$],
        tdg[Variabilidad explicada por el modelo],
        td[$SS_"res"$],
        tdg[Variabilidad no explicada (residuos)],
      )
    ],
    align(center + horizon, lq.diagram(
      width: 260pt,
      height: 210pt,
      legend: (position: left + top),
      xlabel: lq.label[#text(size: 10pt)[X]],
      ylabel: lq.label[#text(size: 10pt)[Y]],
      xlim: (0.5, 8.5),
      ylim: (3, 16.5),

      // Puntos de dispersión
      lq.scatter(
        (1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.5, 6.0, 6.5, 7.0, 7.5),
        (5.5, 5.0, 7.0, 7.5, 9.0, 9.5, 10.5, 11.5, 12.0, 12.5, 13.5, 13.5, 15.0),
        color: cm2,
        size: 5pt,
      ),

      // Punto observado Yi (x=5, y=14) — destacado en cm1
      lq.scatter((5,), (14,), color: cm1, size: 8pt),

      // Punto predicho Ŷi (x=5, y=11) — en cm3
      lq.scatter((5,), (11,), color: cm3, size: 7pt),

      // Recta de regresión y = 1.5x + 3.5
      lq.line((1, 5.0), (8, 15.5), stroke: cm3 + 2pt, label: lq.label[#text(size: 10pt)[$hat(Y)$ (modelo)]]),

      // Línea de la media ȳ = 8
      lq.hlines(8, stroke: (paint: gry, dash: "dashed", thickness: 1.5pt), label: lq.label[#text(
        size: 10pt,
      )[$hat(Y)$ (media)]]),

      // Indicadores verticales
      lq.line((4.7, 8), (4.7, 14), stroke: cm1 + 2.5pt), // SS_tot
      lq.line((5.0, 8), (5.0, 11), stroke: cm3 + 2.5pt), // SS_reg
      lq.line((5.3, 11), (5.3, 14), stroke: rgb("#e74c3c") + 2.5pt), // SS_res

      // Etiquetas de los segmentos
      lq.place(4.55, 11.0, align: right + horizon)[
        #text(fill: cm1, size: 8pt, weight: "bold")[$S S_"tot"$]],
      lq.place(5.4, 9.3, align: left + horizon)[
        #text(fill: cm3, size: 8pt, weight: "bold")[$S S_"reg"$]],
      lq.place(5.4, 12.7, align: left + horizon)[
        #text(fill: rgb("#e74c3c"), size: 8pt, weight: "bold")[$S S_"res"$]],

      // Etiquetas de los puntos clave
      lq.place(5.15, 14.3, align: left + horizon)[
        #text(fill: cm1, size: 7pt)[$Y_i$]],
      lq.place(5.15, 11.4, align: left + horizon)[
        #text(fill: cm3, size: 7pt)[$hat(Y)_i$]],
      lq.place(0.65, 8.45, align: left + horizon)[
        #text(fill: gry, size: 7pt)[$overline(Y)$]],
    )),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Evaluación del modelo")
#sstitle("Coeficiente de determinación R²")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      $R^2$ mide la *proporción de la variabilidad total* de Y que el modelo
      explica:

      $ R^2 = frac(SS_"reg", SS_"tot") = 1 - frac(SS_"res", SS_"tot") $

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Varía entre 0 y 1 *cuando el modelo incluye intercepto* \
        - $R^2 = 1$: el modelo explica toda la variabilidad \
        - $R^2 = 0$: el modelo no explica nada \
        - En regresión simple: $R^2 = r_(X Y)^2$
      ]
    ],
    [
      #align(center + horizon, figure(image("images/cell_15.png", height: 230pt)))
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Gráfico real vs. predicho: cuanto más próximos a la diagonal,
        mayor $R^2$.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Evaluación del modelo")
#sstitle("Efecto del nivel de error en R²")
#slide[
  #grid(
    columns: (1fr, 1.7fr),
    gutter: 10pt,
    [
      #text(fill: gry, size: 12pt)[
        El mismo modelo con cuatro niveles de error ($sigma = 0.05, 0.20, 0.50, 1.00$).
        A mayor error, los puntos se alejan de la diagonal y $R^2$ disminuye.
      ]
    ],
    align(center, figure(image("images/cell_19.png", height: 270pt))),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Evaluación del modelo")
#sstitle("Prueba t sobre los coeficientes")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      #text(size: 14pt)[
        Para cada coeficiente se contrasta si es significativamente distinto de cero:
      ]

      $ H_0: beta = 0 quad "vs." quad H_1: beta eq.not 0 $

      #text(size: 14pt)[
        El estadístico es:
      ]
      $ t = frac(hat(beta), "SE"(hat(beta))) $

      #text(size: 14pt)[
        donde $"SE"(hat(beta)) = sqrt(SS_"res" slash (n-2)) / sqrt(sum(X_i - overline(X))^2)$
        es el *error estándar de la estimación*.

        #v(6pt)
        #text(fill: gry, size: 13pt)[
          Bajo $H_0$, el estadístico sigue una $t$ con $n-2$ grados de libertad.
          Un p-valor pequeño indica que el coeficiente es estadísticamente distinto de 0.
        ]
      ]
    ],
    align(center + horizon)[
      #text(fill: gry, size: 12pt)[Ejemplo — salida del modelo]
      #v(8pt)
      #styled-table(
        columns: (auto, auto, auto, auto, auto),
        th[Término],
        th[Coef.],
        th[SE],
        th[t],
        th[p-valor],
        td[Intercepto],
        tdg[2.134],
        tdg[0.412],
        tdg[5.18],
        tdg[< 0.001],
        td[$X_1$],
        tdg[0.873],
        tdg[0.091],
        tdg[9.59],
        tdg[< 0.001],
        td[$X_2$],
        tdg[-0.312],
        tdg[0.155],
        tdg[-2.01],
        tdg[0.048],
      )
      #v(10pt)
      #text(fill: gry, size: 11pt)[
        SE: error estándar del coeficiente \
        p-valor: bajo $H_0: beta = 0$, distribución $t_(n-p-1)$
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Evaluación del modelo")
#sstitle("Prueba F global del modelo")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      Contrasta si el modelo en su conjunto explica más variabilidad que la
      media sola:

      $ H_0: beta = 0 quad "vs." quad H_1: beta eq.not 0 $

      $ F = frac(SS_"reg" slash p, \ SS_"res" slash (n - p - 1)) = frac("MS"_"reg", "MS"_"res") $

      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Símbolo],
        th[Significado],
        td[$p$],
        tdg[Número de predictores],
        td[$n$],
        tdg[Número de observaciones],
        td[$"MS"$],
        tdg[Media cuadrática = SS / grados de libertad],
      )
    ],
    [
      #ssstitle[Relación F — R²]
      #v(8pt)
      En regresión simple ($p=1$) existe una relación directa:

      $ F = frac(R^2 slash 1, \ (1-R^2) slash (n-2)) $

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Un F grande (p-valor pequeño) indica que el modelo explica una
        proporción significativa de la variabilidad de Y.
        En regresión simple, la prueba F es equivalente a la prueba t
        sobre $hat(beta)$.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Evaluación del modelo")
#sstitle("Intervalos de confianza de los coeficientes")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      Un IC del 95% para $beta$ es:

      $ hat(beta) plus.minus t_(alpha slash 2,\ n-2) dot "SE"(hat(beta)) $

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Si el IC *no contiene el 0*, el coeficiente es significativo
          al nivel $alpha$ \
        - Cuanto más estrecho, más precisa es la estimación \
        - Depende del tamaño de muestra $n$ y de la varianza del error $sigma^2$
      ]
      #v(8pt)
      #text(fill: cm2, size: 14pt)[
        Los ICs y los p-valores son *inválidos* si se violan los supuestos de
        independencia u homocedasticidad — los coeficientes siguen siendo
        insesgados, pero su incerteza queda mal estimada.
      ]
    ],
    [
      #ssstitle[En Python — statsmodels]
      #v(8pt)
      #block(
        width: 100%,
        fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3,
        inset: (x: 12pt, y: 10pt),
        radius: 4pt,
        text(size: 13pt)[
          ```python
          import statsmodels.api as sm

          exog = sm.add_constant(x)
          res  = sm.OLS(y, exog).fit()

          # Tabla completa: coef, SE, t, p, IC
          print(res.summary())

          # Solo ICs
          print(res.conf_int(alpha=0.05))

          # R², F-stat y su p-valor
          print(res.rsquared)
          print(res.fvalue, res.f_pvalue)
          ```
        ],
      )
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 4. DIAGNÓSTICO DE RESIDUOS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "Diagnóstico de residuos", subtitle: "Histograma · Q-Q · Leverage · Cook")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Diagnóstico de residuos")
#sstitle("¿Qué contienen los residuos?")
#slide[
  #grid(
    columns: (1fr, 1.2fr),
    gutter: 20pt,
    [
      #text(size: 14pt)[
        Los residuos $E_i = Y_i - hat(Y)_i$ capturan todo lo que el modelo
        *no explicó*:
      ]

      #text(fill: gry, size: 14pt)[
        - Ruido aleatorio
        - Relaciones no lineales omitidas
        - Variables explicativas no incluidas
        - Errores de medición
        - Valores atípicos (*outliers*)
      ]
      #text(size: 14pt)[
        Si el modelo es adecuado, los residuos deben:
      ]

      #text(fill: gry, size: 14pt)[
        - Estar centrados en *cero*
        - No mostrar patrones al graficarlos
        - Tener varianza constante (*homocedasticidad*)
        - Ser independientes entre sí
        - Seguir aproximadamente una *distribución normal*
      ]
    ],
    [
      #ssstitle[Histograma + Q-Q plot]
      #v(2pt)
      #figure(image("images/qq_residuals.png", height: 160pt))
      #text(fill: gry, size: 13pt)[
        El *Q-Q plot* es más sensible que el histograma para detectar
        desviaciones de la normalidad, especialmente en las colas.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Diagnóstico de residuos")
#sstitle("Residuos vs. valores predichos")
#slide[
  #grid(
    columns: (1.4fr, 1fr),
    gutter: 20pt,
    align(center + horizon, figure(image("images/cell_17.png", height: 270pt))),
    [
      #ssstitle[¿Qué buscar?]
      #v(8pt)
      #styled-table(
        columns: (1fr, 1fr),
        th[Patrón],
        th[Diagnóstico],
        tdg[Nube aleatoria alrededor de 0],
        tdg[Modelo adecuado],
        tdg[Abanico que se abre],
        tdg[Heterocedasticidad],
        tdg[Curva o tendencia],
        tdg[No linealidad omitida],
        tdg[Puntos muy alejados],
        tdg[Outliers influyentes],
      )
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        Es el gráfico diagnóstico más importante.
        Debe examinarse *siempre* antes de interpretar el modelo.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Diagnóstico de residuos")
#sstitle("Leverage")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      #text(size: 12pt)[
        El *leverage* $h_i$ mide cuánto influye la *posición de $X_i$* sobre el
        ajuste, independientemente del valor de $Y_i$.
      ]
      #v(8pt)
      $ h_i = frac(1, n) + frac((X_i - overline(X))^2, sum_j (X_j - overline(X))^2) $
      #v(8pt)
      #text(fill: gry, size: 11pt)[
        - $0 lt.eq h_i lt.eq 1$ y $sum h_i = p + 1$ (número de parámetros).
        - Un punto alejado del centro en $X$ tiene alto leverage: *puede torcer
          la recta aunque su residuo sea pequeño*.
        - Umbral habitual: $h_i > 2(p+1) slash n$.
      ]
      #v(8pt)
      #block(stroke: 1.5pt + cm1, inset: 10pt, radius: 4pt, width: 100%)[
        #text(size: 13pt)[
          Alto leverage *no implica* observación influyente. Solo indica que ese
          punto *tiene la capacidad* de distorsionar la estimación.
        ]
      ]
    ],
    align(center + horizon, figure(image("images/leverage.png", height: 200pt))),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Diagnóstico de residuos")
#sstitle("Distancia de Cook")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      #text(size: 12pt)[
        La *distancia de Cook* $D_i$ combina leverage y residuo para medir el
        *impacto conjunto* de una observación sobre todos los coeficientes.
      ]
      $ D_i = frac(E_i^2, (p+1) dot "MS"_"res") dot frac(h_i, (1 - h_i)^2) $
      #text(fill: gry, size: 13pt)[
        - $E_i$: residuo de la observación $i$.
        - $"MS"_"res" = SS_"res" slash (n - p - 1)$: varianza residual.
        - El segundo factor amplifica el efecto cuando $h_i$ es grande.
      ]
      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Valor de $D_i$],
        th[Diagnóstico],
        td[$D_i < 4 slash n$],
        tdg[Observación poco influyente],
        td[$D_i approx 0.5$],
        tdg[Merece atención],
        td[$D_i > 1$],
        tdg[Observación muy influyente],
      )
    ],
    [
      #align(center + horizon)[
        #figure(image("images/cook.png", height: 190pt))
      ]
      #v(6pt)
      #block(stroke: 1.5pt + cm3, inset: 9pt, radius: 4pt, width: 100%)[
        #text(size: 12pt)[
          Leverage alto + residuo pequeño → *no influyente* \
          Leverage bajo + residuo grande → *outlier*, no influyente \
          Leverage alto + residuo grande → *influyente* ← problema real
        ]
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 5. SIMULACIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Simulación", subtitle: "Ejemplo práctico con Python")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Simulación")
#sstitle("Generación de datos y ajuste OLS")
#slide[
  #grid(
    columns: (1fr, 1.3fr),
    gutter: 16pt,
    [
      #text(size:13pt)[
      Simulamos un modelo con *2 variables independientes* y 1000 observaciones:
      ]

      $ Y = alpha + beta_1 X_1 + beta_2 X_2 + E $

      #block(
        width: 100%,
        fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3,
        inset: (x: 12pt, y: 10pt),
        radius: 4pt,
        text(size: 12pt)[
          ```python
          import numpy as np, scipy.stats as st
          import statsmodels.api as sm

          nvars, nvalues = 2, 1000
          alpha  = np.random.rand()
          betas  = np.random.rand(nvars)
          errors = (0.15 * st.norm.rvs(size=nvalues))
          equis  = np.random.rand(nvars, nvalues)

          Y = (alpha + np.matmul(betas, equis) + errors)

          exog   = sm.add_constant(equis.T)
          fitted = sm.OLS(endog=Y, exog=exog).fit()
          print(fitted.summary())
          ```
        ],
      )
    ],
    align(center + horizon, figure(image("images/cell_07.png", height: 180pt))),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Simulación")
#sstitle("Resultados del ajuste")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      #ssstitle[Coeficientes reales vs. estimados]
      #v(8pt)
      #styled-table(
        columns: (1fr, 1fr),
        th[Real],
        th[Estimado],
        tdg[$alpha approx 0.988$],
        tdg[$hat(alpha) = 1.006$],
        tdg[$beta_1 approx 0.785$],
        tdg[$hat(beta)_1 = 0.783$],
        tdg[$beta_2 approx 0.871$],
        tdg[$hat(beta)_2 = 0.843$],
      )
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        Con $n = 1000$ y $sigma = 0.15$, el modelo recupera los
        parámetros reales con gran precisión. El $R^2 = 0.833$ indica
        que el modelo explica el 83.3% de la variabilidad de Y.
      ]
    ],
    [
      #ssstitle[Predicción de nuevos valores]
      #v(8pt)
      #block(
        width: 100%,
        fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3,
        inset: (x: 12pt, y: 10pt),
        radius: 4pt,
        text(size: 13pt)[
          ```python
          # Predecir con X1=0.5, X2=2
          # (incluir 1 para el intercepto)
          fitted.predict([1, 0.5, 2])
          # → array([3.084])

          # Predecir las primeras 4 obs.
          fitted.predict(exog[:4])
          # Predichos: [1.96, 1.82, 2.08, 1.96]
          # Reales:    [1.81, 1.74, 2.01, 1.86]
          ```
        ],
      )
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        `sm.add_constant` agrega automáticamente la columna de unos
        necesaria para estimar el intercepto.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 6. EXTENSIONES
// ════════════════════════════════════════════════════════════════════════════
#section-divider("6", "Extensiones", subtitle: "R² ajustado · WLS · Colinealidad")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Extensiones")
#sstitle("R² ajustado")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      El $R^2$ *siempre aumenta* al agregar variables, incluso si no aportan
      información. El $R^2$ ajustado penaliza por el número de predictores:

      $ R^2_"aj" = 1 - frac((1 - R^2)(n - 1), n - p - 1) $

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Símbolo],
        th[Significado],
        td[$n$],
        tdg[Número de observaciones],
        td[$p$],
        tdg[Número de predictores (sin intercepto)],
      )
      #text(fill: gry, size: 14pt)[
        $R^2_"aj"$ puede *disminuir* si se agrega una variable que no aporta.
        Solo aumenta si la nueva variable mejora el ajuste más de lo esperado
        por azar.
      ]
    ],
    [
      #block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
        Usar *$R^2$* para describir el ajuste de un modelo ya definido.
      ]
      #v(10pt)
      #block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
        Usar *$R^2$ ajustado* para *comparar modelos* con distinto número
        de predictores.
      ]
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        Otras métricas de comparación: AIC y BIC, que también penalizan
        la complejidad y aparecen en el `summary()` de statsmodels.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Extensiones")
#sstitle("WLS — Mínimos cuadrados ponderados")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      #text(size: 14pt)[
        Cuando hay *heterocedasticidad*, los coeficientes OLS siguen siendo
        *insesgados*, pero los *errores estándar quedan mal estimados*,
        invalidando p-valores e intervalos de confianza.
        WLS asigna un *peso $w_i$* a cada observación y minimiza:
      ]

      $ sum_(i=1)^n w_i (Y_i - hat(Y)_i)^2 $

      #text(size: 14pt)[
        Si se conoce la varianza de cada punto: $w_i = 1 slash "Var"(E_i)$
      ]

      #text(fill: gry, size: 14pt)[
        Si la varianza crece con X (p.e. $"Var"(E_i) prop X_i^2$),
        se usan pesos $w_i = 1 slash X_i^2$.
        Cuando la varianza no se conoce, se estima a partir de los
        residuos de un ajuste OLS preliminar.
      ]
    ],
    align(center + horizon, figure(image("images/cell_22.png", height: 170pt))),
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Extensiones")
#sstitle("WLS en Python")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 16pt,
    [
      #block(
        width: 100%,
        fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3,
        inset: (x: 12pt, y: 10pt),
        radius: 4pt,
        text(size: 13pt)[
          ```python
          import statsmodels.api as sm
          import numpy as np

          # Paso 1: ajuste OLS preliminar
          exog = sm.add_constant(x)
          res_ols = sm.OLS(y, exog).fit()

          # Paso 2: estimar varianza del error
          # asumiendo Var(E) ∝ x²
          w = 1 / (x ** 2)

          # Paso 3: ajuste WLS
          res_wls = sm.WLS(y, exog,
                           weights=w).fit()

          print(res_wls.summary())
          ```
        ],
      )
    ],
    [
      #ssstitle[¿Cuándo usar WLS?]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Cuando el gráfico de residuos vs. predichos muestra un
          patrón en *abanico* \
        - Cuando se sabe que la precisión de medición varía entre
          observaciones (p.e. distintos instrumentos) \
        - Cuando las observaciones son promedios de grupos con
          distinto tamaño: $w_i = n_i$
      ]
      #v(10pt)
      #text(fill: cm2, size: 14pt)[
        Una alternativa es usar *errores estándar robustos* (HC)
        en lugar de WLS cuando no se conoce la forma de la varianza:
        `res.get_robustcov_results(cov_type='HC3')`
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Extensiones")
#sstitle("Colinealidad")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      #text(size: 14pt)[
        La *colinealidad* ocurre cuando dos o más variables predictoras están
        fuertemente correlacionadas entre sí.
      ]

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Efectos sobre el modelo:
        - Los coeficientes se vuelven *inestables*: pequeños cambios en los
          datos producen grandes cambios en $hat(beta)$ \
        - Los *errores estándar* de los $beta$ aumentan mucho \
        - El modelo puede tener buen $R^2$ pero coeficientes
          difíciles de interpretar \
        - Los signos de los coeficientes pueden invertirse
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Diagnóstico: matriz de correlación entre predictores,
        *VIF* (Factor de Inflación de la Varianza).
        $"VIF"_j > 5$ es señal de colinealidad problemática.
      ]
    ],
    [
      #ssstitle[Dataset Iris — correlaciones entre predictores]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr, 1fr, 1fr, 1fr),
        th[],
        th[sep.len],
        th[sep.wid],
        th[pet.len],
        th[pet.wid],
        td[*sep.len*],
        tdg[$1.00$],
        tdg[$-0.12$],
        tdg[$0.87$],
        tdg[$0.82$],
        td[*sep.wid*],
        tdg[$-0.12$],
        tdg[$1.00$],
        tdg[$-0.43$],
        tdg[$-0.37$],
        td[*pet.len*],
        tdg[$0.87$],
        tdg[$-0.43$],
        tdg[$1.00$],
        tdg[$0.96$],
        td[*pet.wid*],
        tdg[$0.82$],
        tdg[$-0.37$],
        tdg[$0.96$],
        tdg[$1.00$],
      )
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        `petal length` y `petal width` tienen $r = 0.96$: alta colinealidad.
        Al incluir ambas para predecir `sepal length`, los coeficientes
        se vuelven inestables.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 7. REGULARIZACIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("7", "Regularización", subtitle: "Ridge · Lasso · Elastic Net")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Regularización")
#sstitle("Motivación — sobreajuste y colinealidad")
#slide[
  #text(13pt)[
    Los modelos lineales pueden *sobreajustarse* cuando hay muchas variables
    o alta correlación entre ellas.

    #v(1pt)
    Los métodos de regularización agregan una *penalización sobre los coeficientes*
    para controlar la complejidad del modelo.
  ]

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: 1fr,
    column-gutter: 15pt,
    block(stroke: 2pt + cm3, inset: 12pt, radius: 5pt, width: 100%, height: 50%)[
      #ssstitle[Ridge (L2)]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Penaliza la suma de los *cuadrados* de los coeficientes.
        *Reduce* los coeficientes pero nunca los lleva a cero.
        Útil con *multicolinealidad*.
      ]
      $ J(beta) = SS_"res" + lambda sum_j beta_j^2 $
    ],
    block(stroke: 2pt + cm1, inset: 12pt, radius: 5pt, width: 100%, height: 50%)[
      #ssstitle[Lasso (L1)]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Penaliza la suma del *valor absoluto* de los coeficientes.
        Puede llevar coeficientes a *exactamente cero*:
        selección automática de variables.
      ]
      $ J(beta) = SS_"res" + lambda sum_j |beta_j| $
    ],
    block(stroke: 2pt + grn, inset: 12pt, radius: 5pt, width: 100%, height: 50%)[
      #ssstitle[Elastic Net]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Combina L1 + L2. Selección de variables como Lasso,
        más estable con variables correlacionadas.
      ]
      $
        J = SS_"res" + lambda [alpha sum|beta_j| + \
          (1-alpha) sum beta_j^2]
      $
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Regularización")
#sstitle("El parámetro de penalización lambda")
#slide[
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    [
      #text(fill: gry, size: 14pt)[
        - $lambda = 0$: sin penalización → equivale a OLS \
        - $lambda$ grande: coeficientes muy pequeños (o cero en Lasso) \
        - El valor óptimo se elige por *validación cruzada*
      ]
      #v(10pt)
      #block(
        width: 100%,
        fill: rgb("#f0fdf4"),
        stroke: 0.5pt + cm3,
        inset: (x: 12pt, y: 10pt),
        radius: 4pt,
        text(size: 13pt)[
          ```python
          from sklearn.linear_model import (
              LinearRegression, Ridge, Lasso)

          # OLS
          ols = LinearRegression().fit(x, y)

          # Ridge con λ=0.1
          ridge = Ridge(alpha=0.1).fit(x, y)

          # Lasso con λ=0.05
          lasso = Lasso(alpha=0.05).fit(x, y)
          ```
        ],
      )
    ],
    [
      #align(center + horizon, figure(image("images/cell_30.png", height: 200pt)))
      #align(center)[
        #scale(75%, reflow: true)[
          #styled-table(
            columns: (auto, 1fr, 1fr),
            th[Variable],
            th[OLS ($lambda=0$)],
            th[Lasso ($lambda=0.05$)],
            td[sepal width],
            tdg[$0.651$],
            tdg[$0.237$],
            td[petal length],
            tdg[$0.709$],
            tdg[$0.418$],
            td[petal width],
            tdg[$-0.556$],
            tdg[$0.000$],
            td[$R^2$],
            tdg[$0.859$],
            tdg[$0.810$],
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
    Regresiones y reducción de dimensionalidad
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
