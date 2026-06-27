// ─── Paquetes ────────────────────────────────────────────────────────────────
#import "@preview/cetz:0.3.4": canvas, draw

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

// Caja de estado para secuencias
#let sbox(label, clr) = box(
  inset: (x: 4pt, y: 3pt),
  radius: 4pt,
  fill: clr.lighten(75%),
  stroke: 1pt + clr,
  text(fill: cm2, weight: "bold", size: 10pt)[#label]
)

// ════════════════════════════════════════════════════════════════════════════
// PORTADA
// ════════════════════════════════════════════════════════════════════════════
#cover(
  "Unidad III",
  "Cadenas de Markov",
  "Modelos probabilísticos para datos categóricos secuenciales",
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
  + Motivación — datos categóricos con estructura temporal
  + Definición y propiedad de Markov
  + Matriz de transición
  + Estimación desde datos
  + Aplicaciones en análisis de datos categóricos
  + Modelos Ocultos de Markov (HMM)
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 1 — MOTIVACIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Motivación", subtitle: "Datos categóricos con estructura temporal")

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Motivación")
#sstitle("¿Por qué importan en datos categóricos?")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size: 13pt)[
        Muchos conjuntos de datos no son colecciones de observaciones
        *independientes*, sino *secuencias* donde el orden importa.
      ]
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        Ejemplos cotidianos en análisis cualitativo:
      ]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Dominio], th[Secuencia categórica],
        td[Medicina],       tdg[Estados clínicos del paciente a lo largo del tiempo],
        td[Lingüística],    tdg[Palabras o categorías gramaticales en un texto],
        td[Bioinformática], tdg[Nucleótidos o aminoácidos en una secuencia],
        td[Marketing],      tdg[Páginas visitadas en una sesión web],
        td[Ecología],       tdg[Comportamientos observados de un animal],
      )
    ],
    [
      #ssstitle[El problema central]
      #v(8pt)
      #block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
        #text(fill: gry, size: 13pt)[
          Si un paciente hoy está en estado *"estable"*,
          ¿cuál es la probabilidad de que mañana pase a *"en riesgo"*?

          #v(8pt)
          Las herramientas clásicas (tablas de contingencia, chi-cuadrado)
          ignoran el *orden* y la *dependencia* entre observaciones consecutivas.
        ]
      ]
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        Las *cadenas de Markov* modelan exactamente esta dependencia:
        la probabilidad de transicionar de un estado a otro, dado el
        estado actual.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 2 — DEFINICIÓN Y PROPIEDAD DE MARKOV
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Propiedad de Markov", subtitle: "Definición formal · Sin memoria")

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Definición")
#sstitle("La propiedad de Markov")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size: 12pt)[
        Una *cadena de Markov* es una secuencia de variables aleatorias
        $X_1, X_2, X_3, dots$ que toman valores en un conjunto finito
        de *estados* $S = {s_1, s_2, dots, s_n}$.
      ]

      #v(8pt)
      #block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
        #text(fill: gry, size: 13pt)[
          *Propiedad de Markov:* el estado futuro depende únicamente
          del estado *presente*, no de la historia anterior.

          $ P(X_(t+1) = s_j | X_t = s_i, X_(t-1), dots) = \
          P(X_(t+1) = s_j | X_t = s_i) $
        ]
      ]
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        Esta propiedad se llama también *sin memoria* (*memoryless*).
        Resume toda la historia en un solo estado actual.
      ]
    ],
    [
      #ssstitle[Intuición visual]
      #v(12pt)
      #align(center)[
        #canvas(length: 0.85cm, {
          import draw: *
          let cc = rgb("#00a1ae")
          let cg = rgb("#6B7280")
          let cd = rgb("#032e35")

          // Timeline boxes
          let days = ("Lun", "Mar", "Mié", "Jue", "?")
          let states = ("S", "N", "S", "N", none)
          let cols = (cc, rgb("#a3804c"), cc, rgb("#a3804c"), cg)
          for i in range(5) {
            let x = i * 2.2
            if i < 4 {
              rect((x, 0), (x + 1.6, 1.2),
                fill: cols.at(i).lighten(70%),
                stroke: 1pt + cols.at(i))
              content((x + 0.8, 0.75),
                text(fill: cd, weight: "bold", size: 10pt)[#states.at(i)])
              content((x + 0.8, 0.25),
                text(fill: cg, size: 8pt)[#days.at(i)])
            } else {
              rect((x, 0), (x + 1.6, 1.2),
                fill: cg.lighten(85%),
                stroke: 1pt + cg)
              content((x + 0.8, 0.75),
                text(fill: cg, weight: "bold", size: 14pt)[?])
              content((x + 0.8, 0.25),
                text(fill: cg, size: 8pt)[Jue])
            }
            if i < 4 {
              line((x + 1.6, 0.6), (x + 2.2, 0.6),
                mark: (end: "straight"),
                stroke: (paint: cg, thickness: 0.8pt))
            }
          }

          // Tachado sobre historia antigua
          line((0, -0.5), (5.0, -0.5),
            stroke: (paint: rgb("#dc2626"), thickness: 1.5pt))
          content((2.5, -1.1),
            text(fill: rgb("#dc2626"), size: 9pt)[Historia anterior — *irrelevante*])

          // Flecha indicando solo Mié importa
          line((3.8, 1.5), (3.8, 1.2),
            mark: (end: "straight"),
            stroke: (paint: cc, thickness: 1.5pt))
          content((3.8, 1.9),
            text(fill: cc, size: 9pt, weight: "bold")[Solo esto importa])
        })
      ]
      #v(10pt)
      #text(fill: gry, size: 12pt)[
        Para predecir el *Jueves*, solo usamos el estado del *Miércoles*.
        La cadena "olvida" todo lo anterior.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 3 — MATRIZ DE TRANSICIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Matriz de transición", subtitle: "Representación y propiedades")

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Matriz de Transición")
#sstitle("Definición y propiedades")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size: 13pt)[
        Toda la dinámica queda capturada en la
        *matriz de transición* $P$, donde $P_(i j)$ es la
        probabilidad de pasar del estado $i$ al estado $j$:
      ]
      #v(8pt)
      $ P_(i j) = P(X_(t+1) = s_j | X_t = s_i) $

      #v(8pt)
      #ssstitle[Propiedades]
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        - Todas las entradas son *no negativas*: $P_(i j) >= 0$.
        - Las filas suman 1 (matriz *estocástica por filas*):
          $ sum_j P_(i j) = 1 quad forall i $
        - Cada fila es una distribución de probabilidad sobre los
          estados destino.
      ]
    ],
    [
      #ssstitle[Ejemplo — clima]
      #v(6pt)
      #text(fill: gry, size: 12pt)[
        Estados: Soleado (S), Nublado (N), Lluvioso (L)
      ]
      #v(6pt)
      #align(center)[
        #scale(90%, reflow: true)[
          $ P = mat(
            , S, N, L;
            S, 0.7, 0.2, 0.1;
            N, 0.3, 0.4, 0.3;
            L, 0.2, 0.3, 0.5;
          ) $
        ]
      ]
      #v(8pt)
      #text(fill: gry, size: 12pt)[
        Cada *fila* es la distribución de probabilidad desde ese estado.
        La fila S suma: $0.7 + 0.2 + 0.1 = 1$.

        #v(6pt)
        *Predicción a n pasos:* $P^n$ da las
        probabilidades de transición en $n$ pasos.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Matriz de Transición")
#sstitle("Diagrama de estados")
#slide[
  #grid(columns: (1.1fr, 1fr), gutter: 20pt,
    [
      #align(center)[
        #canvas(length: 0.9cm, {
          import draw: *

          let nodo(pos, label, clr) = {
            circle(pos, radius: 0.85,
              fill: clr.lighten(75%),
              stroke: 1.5pt + clr,
              name: label)
            content(pos,
              text(fill: rgb("#032e35"), weight: "bold", size: 11pt)[#label])
          }

          let pS = (0, 3)
          let pN = (-3, -1.2)
          let pL = (3, -1.2)

          // Auto-bucles
          bezier(
            (-.3, 3.85), (.3, 3.85),
            (-.7, 5.2), (.7, 5.2),
            mark: (end: "straight"),
            stroke: (paint: rgb("#6B7280"), thickness: 1pt))
          content((0, 5.0),
            text(fill: rgb("#00a1ae"), size: 9pt, weight: "bold")[0.70])

          bezier(
            (-3.85, -.6), (-3.85, -1.8),
            (-5.2, .1), (-5.2, -2.5),
            mark: (end: "straight"),
            stroke: (paint: rgb("#6B7280"), thickness: 1pt))
          content((-5.0, -1.1),
            text(fill: rgb("#00a1ae"), size: 9pt, weight: "bold")[0.40])

          bezier(
            (3.85, -.6), (3.85, -1.8),
            (5.2, .1), (5.2, -2.5),
            mark: (end: "straight"),
            stroke: (paint: rgb("#6B7280"), thickness: 1pt))
          content((5.05, -1.1),
            text(fill: rgb("#00a1ae"), size: 9pt, weight: "bold")[0.50])

          // S -> N
          line((-0.6, 2.3), (-2.3, -0.55),
            mark: (end: "straight"),
            stroke: (paint: rgb("#6B7280"), thickness: 1pt, dash: "dashed"))
          content((-1.8, 1.1),
            text(fill: rgb("#6B7280"), size: 9pt)[0.20])

          // N -> S
          line((-2.0, -0.3), (-0.3, 2.1),
            mark: (end: "straight"),
            stroke: (paint: rgb("#6B7280"), thickness: 1pt))
          content((-0.8, 0.8),
            text(fill: rgb("#6B7280"), size: 9pt)[0.30])

          // S -> L
          line((0.6, 2.3), (2.3, -0.55),
            mark: (end: "straight"),
            stroke: (paint: rgb("#6B7280"), thickness: 1pt, dash: "dashed"))
          content((1.8, 1.1),
            text(fill: rgb("#6B7280"), size: 9pt)[0.10])

          // L -> S
          line((2.0, -0.3), (0.3, 2.1),
            mark: (end: "straight"),
            stroke: (paint: rgb("#6B7280"), thickness: 1pt))
          content((0.8, 0.8),
            text(fill: rgb("#6B7280"), size: 9pt)[0.20])

          // N -> L
          line((-2.15, -1.55), (2.15, -1.55),
            mark: (end: "straight"),
            stroke: (paint: rgb("#6B7280"), thickness: 1pt, dash: "dashed"))
          content((0, -1.9),
            text(fill: rgb("#6B7280"), size: 9pt)[0.30])

          // L -> N
          line((2.15, -0.85), (-2.15, -0.85),
            mark: (end: "straight"),
            stroke: (paint: rgb("#6B7280"), thickness: 1pt))
          content((0, -0.5),
            text(fill: rgb("#6B7280"), size: 9pt)[0.30])

          nodo(pS, "S", rgb("#00a1ae"))
          nodo(pN, "N", rgb("#a3804c"))
          nodo(pL, "L", rgb("#032e35"))

          content((0, 2.0),
            text(fill: rgb("#6B7280"), size: 8pt)[Soleado])
          content((-3, -2.2),
            text(fill: rgb("#6B7280"), size: 8pt)[Nublado])
          content((3, -2.2),
            text(fill: rgb("#6B7280"), size: 8pt)[Lluvioso])
        })
      ]
    ],
    [
      #v(10pt)
      #text(size: 13pt)[
        Cada *nodo* es un estado; cada *flecha* es una transición
        posible con su probabilidad asociada.
      ]
      #v(10pt)
      #text(fill: gry, size: 12pt)[
        - Las flechas *continuas* son las transiciones más probables.
        - Las flechas *discontinuas* indican baja probabilidad.
        - Los *bucles* muestran la prob. de permanecer en el mismo estado.
      ]
      #v(12pt)
      #ssstitle[Lectura de la matriz]
      #v(6pt)
      #text(fill: gry, size: 12pt)[
        La *fila* $i$ contiene todas las probabilidades de salida
        del estado $i$: suma 1 porque el sistema siempre transiciona
        a algún estado (incluso si es el mismo).
      ]
    ],
  )
]


// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 4 — DISTRIBUCIÓN ESTACIONARIA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "Distribución estacionaria", subtitle: "Comportamiento a largo plazo")

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Distribución Estacionaria")
#sstitle("Comportamiento a largo plazo")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size: 13pt)[
        Si aplicamos la matriz de transición repetidamente, la
        distribución sobre los estados *converge* a una distribución
        estable llamada *distribución estacionaria* $pi$.
      ]
      #v(8pt)
      #block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
        #text(fill: gry, size: 13pt)[
          La distribución $pi$ satisface:
          $ pi P = pi $
          $ sum_i pi_i = 1, quad pi_i >= 0 $

          Es el *vector propio izquierdo* de $P$ asociado al autovalor 1.
        ]
      ]
    ],
    [
      #ssstitle[Resultado para el ejemplo clima]
      #v(8pt)
      #align(center)[
        #canvas(length: 1.0cm, {
          import draw: *
          let cc = rgb("#00a1ae")
          let cg1 = rgb("#a3804c")
          let cgr = rgb("#6B7280")
          let cd = rgb("#032e35")

          let pi = (0.4681, 0.2766, 0.2553)
          let labels = ("S", "N", "L")
          let colors = (cc, cg1, cgr)
          let maxh = 3.0

          for i in range(3) {
            let x = i * 1.5
            let h = pi.at(i) * maxh
            rect((x, 0), (x + 1.1, h),
              fill: colors.at(i).lighten(60%),
              stroke: 1pt + colors.at(i))
            content((x + 0.55, h + 0.3),
              text(fill: cd, size: 10pt, weight: "bold")[#str(calc.round(pi.at(i) * 100, digits: 1))%])
            content((x + 0.55, -0.35),
              text(fill: colors.at(i), size: 11pt, weight: "bold")[#labels.at(i)])
          }

          content((2.2, -0.9),
            text(fill: cd, size: 9pt)[Soleado · Nublado · Lluvioso])
        })
      ]
      #v(10pt)
      #text(fill: gry, size: 12pt)[
        A largo plazo el sistema estará *Soleado* ~47% del tiempo,
        *Nublado* ~28% y *Lluvioso* ~26%, sin importar el estado inicial.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Matriz de Transición")
#sstitle("Predicción a n pasos")
#slide[
  #align(center)[
    #canvas(length: 1.1cm, {
      import draw: *
      let cc = rgb("#00a1ae")
      let cg1 = rgb("#a3804c")
      let cgr = rgb("#6B7280")
      let cd = rgb("#032e35")

      // Datos: t=0, t=1, t=3, t→∞
      let groups = (
        (label: "t = 0",    s: 1.00, n: 0.00, l: 0.00),
        (label: "t = 1",    s: 0.70, n: 0.20, l: 0.10),
        (label: "t = 3",    s: 0.50, n: 0.28, l: 0.22),
        (label: "t → ∞",   s: 0.47, n: 0.28, l: 0.26),
      )

      let bw = 0.45
      let gap = 0.12
      let gw = 3 * bw + 2 * gap + 0.5
      let maxh = 3.5
      let colors = (cc, cg1, cgr)
      let labels = ("S", "N", "L")

      for gi in range(4) {
        let g = groups.at(gi)
        let gx = gi * (gw + 0.4)
        let vals = (g.s, g.n, g.l)

        // Group label
        content((gx + gw / 2 - 0.3, -0.5),
          text(fill: cd, weight: "bold", size: 10pt)[#g.label])

        // π label for last group
        if gi == 3 {
          content((gx + gw / 2 - 0.3, maxh + 0.5),
            text(fill: cc, weight: "bold", size: 14pt)[π])
        }

        for bi in range(3) {
          let bx = gx + bi * (bw + gap)
          let h = vals.at(bi) * maxh
          let clr = colors.at(bi)

          rect((bx, 0), (bx + bw, h),
            fill: clr.lighten(60%),
            stroke: 1pt + clr)

          // Value label
          if vals.at(bi) > 0.03 {
            content((bx + bw / 2, h + 0.25),
              text(fill: cd, size: 8pt)[#str(vals.at(bi))])
          }

          // State label below
          content((bx + bw / 2, -0.25),
            text(fill: clr, size: 8pt, weight: "bold")[#labels.at(bi)])
        }

        // Arrow to next group
        if gi < 3 {
          line((gx + gw + 0.0, maxh / 2), (gx + gw + 0.35, maxh / 2),
            mark: (end: "straight"),
            stroke: (paint: cgr, thickness: 1pt))
        }
      }

      // Legend
      for i in range(3) {
        let lx = i * 1.8 + 6.0
        rect((lx, -1.2), (lx + 0.35, -0.9),
          fill: colors.at(i).lighten(60%), stroke: 0.8pt + colors.at(i))
        content((lx + 0.55, -1.05),
          text(fill: cd, size: 8pt)[#labels.at(i)])
      }
    })
  ]
  #v(4pt)
  #align(center)[
    #text(fill: gry, size: 13pt)[
      La distribución converge a la distribución estacionaria $pi$ independientemente del estado inicial.
    ]
  ]
]
// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 5 — ESTIMACIÓN DESDE DATOS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Estimación", subtitle: "Aprender la matriz de transición desde datos")

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Estimación")
#sstitle("Estimación de máxima verosimilitud")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size: 13pt)[
        Dada una secuencia observada de estados categóricos, el estimador
        de máxima verosimilitud de $P_(i j)$ es la
        *frecuencia relativa* de transiciones:
      ]
      #v(8pt)
      $ hat(P)_(i j) = frac(n_(i j), sum_k n_(i k)) $

      #v(6pt)
      #text(fill: gry, size: 13pt)[
        donde $n_(i j)$ es el número de veces que se observó la
        transición $i arrow j$ en los datos.
      ]
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        *Suavizado de Laplace:* cuando algunas transiciones son raras
        se agrega una pseudocuenta $alpha$:
        $ hat(P)_(i j) = frac(n_(i j) + alpha, sum_k n_(i k) + alpha |S|) $
      ]
    ],
    [
      #ssstitle[Proceso de estimación]
      #v(6pt)

      // Secuencia observada con cajas de colores
      #align(center)[
        #sbox("S", cm3) #h(2pt) #box(baseline: -2pt)[$arrow$] #h(2pt)
        #sbox("N", cm1) #h(2pt) #box(baseline: -2pt)[$arrow$] #h(2pt)
        #sbox("S", cm3) #h(2pt) #box(baseline: -2pt)[$arrow$] #h(2pt)
        #sbox("S", cm3) #h(2pt) #box(baseline: -2pt)[$arrow$] #h(2pt)
        #sbox("L", gry) #h(2pt) #box(baseline: -2pt)[$arrow$] #h(2pt)
        #sbox("N", cm1)
      ]
      #v(8pt)

      // Pares extraídos
      #text(fill: gry, size: 11pt)[Pares (origen → destino) extraídos:]
      #v(4pt)
      #align(center)[
        #grid(columns: (auto, auto, auto, auto, auto), gutter: 6pt,
          [#sbox("S", cm3) #box(baseline: -2pt)[$arrow$] #sbox("N", cm1)],
          [#sbox("N", cm1) #box(baseline: -2pt)[$arrow$] #sbox("S", cm3)],
          [#sbox("S", cm3) #box(baseline: -2pt)[$arrow$] #sbox("S", cm3)],
          [#sbox("S", cm3) #box(baseline: -2pt)[$arrow$] #sbox("L", gry)],
          [#sbox("L", gry) #box(baseline: -2pt)[$arrow$] #sbox("N", cm1)],
        )
      ]
      #v(8pt)

      // Tabla de conteos
      #align(center)[
        #scale(85%, reflow: true)[
          #styled-table(
            columns: (auto, auto, auto, auto),
            th[], th[→ S], th[→ N], th[→ L],
            td[*S*], tdg[1], tdg[1], tdg[1],
            td[*N*], tdg[1], tdg[0], tdg[0],
            td[*L*], tdg[0], tdg[1], tdg[0],
          )
        ]
      ]
      #v(6pt)
      #text(fill: gry, size: 11pt)[Normalizar cada fila por su suma da $hat(P)$.]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 6 — APLICACIONES
// ════════════════════════════════════════════════════════════════════════════
#section-divider("6", "Aplicaciones", subtitle: "Análisis de datos categóricos")

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Aplicaciones")
#sstitle("Análisis de secuencias de texto")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size: 13pt)[
        Un modelo de Markov de orden 1 sobre palabras o categorías
        captura la *estructura local* del lenguaje.
      ]
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        *Aplicaciones concretas:*
        - Corrección ortográfica (¿qué palabra sigue?)
        - Clasificación de textos por género literario
        - Detección de anomalías en logs de eventos
        - Generación de texto sintético para pruebas
      ]
      #v(10pt)
      #text(fill: gry, size: 12pt)[
        Secuencia de categorías gramaticales observada:
      ]
      #v(4pt)
      #align(center)[
        #sbox("N", cm3) #h(2pt) $arrow$ #h(2pt)
        #sbox("V", cm1) #h(2pt) $arrow$ #h(2pt)
        #sbox("ADJ", grn) #h(2pt) $arrow$ #h(2pt)
        #sbox("N", cm3) #h(2pt) $arrow$ #h(2pt)
        #sbox("V", cm1) #h(2pt) $dots$
      ]
    ],
    [
      #ssstitle[Diagrama de bigramas]
      #v(6pt)
      #align(center)[
        #canvas(length: 0.85cm, {
          import draw: *
          let cc = rgb("#00a1ae")
          let cg1 = rgb("#a3804c")
          let cgrn = rgb("#15803D")
          let cgr = rgb("#6B7280")
          let cd = rgb("#032e35")

          let nodo(pos, lbl, clr, nm) = {
            circle(pos, radius: 0.9,
              fill: clr.lighten(75%),
              stroke: 1.5pt + clr,
              name: nm)
            content(pos,
              text(fill: cd, weight: "bold", size: 11pt)[#lbl])
          }

          nodo((0, 3.5), "N", cc, "N")
          nodo((-3, 0), "V", cg1, "V")
          nodo((3, 0), "ADJ", cgrn, "ADJ")

          // N -> V (3)
          line((-0.7, 2.9), (-2.4, 0.75),
            mark: (end: "straight"),
            stroke: (paint: cc, thickness: 2pt))
          content((-1.8, 1.9),
            text(fill: cc, weight: "bold", size: 10pt)[3])

          // V -> N (2)
          line((-2.1, 0.8), (-0.4, 2.9),
            mark: (end: "straight"),
            stroke: (paint: cg1, thickness: 1.5pt))
          content((-0.7, 1.7),
            text(fill: cg1, weight: "bold", size: 10pt)[2])

          // V -> ADJ (1)
          line((-2.1, -0.1), (2.1, -0.1),
            mark: (end: "straight"),
            stroke: (paint: cg1, thickness: 1pt))
          content((0, -0.5),
            text(fill: cg1, size: 10pt)[1])

          // ADJ -> N (1)
          line((2.4, 0.75), (0.7, 2.9),
            mark: (end: "straight"),
            stroke: (paint: cgrn, thickness: 1pt))
          content((1.8, 1.9),
            text(fill: cgrn, size: 10pt)[1])

          content((0, -1.2),
            text(fill: cgr, size: 8pt)[Conteos de transiciones observadas])
        })
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Aplicaciones")
#sstitle("Trayectorias de pacientes")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size: 13pt)[
        En estudios longitudinales, cada paciente genera una
        *secuencia de estados de salud* categóricos. Las cadenas de
        Markov permiten estimar probabilidades de progresión o remisión.
      ]
      #v(8pt)
      #ssstitle[Estados clínicos]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Estado], th[Descripción],
        td[*Remisión*],   tdg[Sin síntomas activos],
        td[*Leve*],       tdg[Síntomas controlados],
        td[*Moderado*],   tdg[Requiere seguimiento activo],
        td[*Severo*],     tdg[Requiere hospitalización],
        td[*Absorbente*], tdg[Curación o éxitus — estado terminal],
      )
    ],
    [
      #ssstitle[Diagrama con estado absorbente]
      #v(6pt)
      #align(center)[
        #canvas(length: 0.8cm, {
          import draw: *
          let cc = rgb("#00a1ae")
          let cg1 = rgb("#a3804c")
          let cgrn = rgb("#15803D")
          let cgr = rgb("#6B7280")
          let cred = rgb("#dc2626")
          let cd = rgb("#032e35")

          let estados = ("Rem.", "Leve", "Mod.", "Sev.")
          let colors = (cgrn, cc, cg1, cred)

          for i in range(4) {
            let x = i * 2.8
            circle((x, 2), radius: 0.85,
              fill: colors.at(i).lighten(75%),
              stroke: 1.5pt + colors.at(i))
            content((x, 2),
              text(fill: cd, weight: "bold", size: 9pt)[#estados.at(i)])

            if i < 3 {
              // forward arrow
              line((x + 0.85, 2.2), (x + 1.95, 2.2),
                mark: (end: "straight"),
                stroke: (paint: cgr, thickness: 1pt))
              // back arrow
              line((x + 1.95, 1.8), (x + 0.85, 1.8),
                mark: (end: "straight"),
                stroke: (paint: cgr, thickness: 1pt))
            }
          }

          // Self-loop Absorbente abajo
          circle((8.4, -0.6), radius: 0.85,
            fill: cred.lighten(85%),
            stroke: 2pt + cred)
          // Double ring
          circle((8.4, -0.6), radius: 1.05,
            fill: none,
            stroke: 1pt + cred)
          content((8.4, -0.6),
            text(fill: cred, weight: "bold", size: 8pt)[Abs.])
          content((8.4, -1.85),
            text(fill: cred, size: 8pt)[$P_(i i) = 1$])

          // Arrow from Severo to Absorbente
          line((8.4, 1.15), (8.4, 0.45),
            mark: (end: "straight"),
            stroke: (paint: cred, thickness: 1.5pt))
          content((9.3, 0.8),
            text(fill: cred, size: 8pt)[absorción])
        })
      ]
      #v(6pt)
      #text(fill: gry, size: 11pt)[
        *Matriz fundamental* $N = (I - Q)^(-1)$: calcula el tiempo
        esperado hasta absorción desde cada estado transitorio.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Aplicaciones")
#sstitle("Simulación de trayectorias")
#slide[
  #grid(columns: (1fr, 1.4fr), gutter: 20pt,
    [
      #text(size: 13pt)[
        Una cadena de Markov calibrada puede *simular* nuevas
        secuencias que siguen el mismo patrón de transiciones
        que los datos originales.
      ]
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        *Usos principales:*
        - Generación de datos sintéticos
        - Bootstrap y validación de modelos
        - Escenarios clínicos hipotéticos
        - Estimación de riesgos a largo plazo
      ]
      #v(10pt)
      #block(stroke: 2pt + cm1, inset: 12pt, radius: 5pt)[
        #text(fill: gry, size: 12pt)[
          Cada paso se elige aleatoriamente según la fila
          de la matriz $P$ correspondiente al estado actual.
        ]
      ]
    ],
    [
      #ssstitle[Trayectorias simuladas]
      #v(10pt)

      // Trayectoria 1 — desde Leve
      #text(fill: gry, size: 11pt)[Trayectoria A — inicio: Leve]
      #v(4pt)
      #set text(size: 10pt)
      #sbox("Leve", cm3) #h(1pt) $→$ #h(1pt)
      #sbox("Leve", cm3) #h(1pt) $→$ #h(1pt)
      #sbox("Mod.", cm1) #h(1pt) $→$ #h(1pt)
      #sbox("Leve", cm3) #h(1pt) $→$ #h(1pt)
      #sbox("Rem.", grn) #h(1pt) $→$ #h(1pt)
      #sbox("Rem.", grn)
      #v(2pt)
      #sbox("Rem.", grn) #h(1pt) $→$ #h(1pt)
      #sbox("Mod.", cm1) #h(1pt) $→$ #h(1pt)
      #sbox("Leve", cm3) #h(1pt) $→$ #h(1pt)
      #sbox("Rem.", grn) #h(1pt) $→$ #h(1pt)
      #sbox("Rem.", grn) #h(1pt) $→$ #h(1pt) $dots$
      #set text(size: 18pt)

      #v(14pt)

      // Trayectoria 2 — desde Severo
      #text(fill: gry, size: 11pt)[Trayectoria B — inicio: Severo]
      #v(4pt)
      #set text(size: 10pt)
      #sbox("Sev.", rgb("#dc2626")) #h(1pt) $→$ #h(1pt)
      #sbox("Sev.", rgb("#dc2626")) #h(1pt) $→$ #h(1pt)
      #sbox("Mod.", cm1) #h(1pt) $→$ #h(1pt)
      #sbox("Sev.", rgb("#dc2626")) #h(1pt) $→$ #h(1pt)
      #sbox("Mod.", cm1) #h(1pt) $→$ #h(1pt)
      #sbox("Leve", cm3)
      #v(2pt)
      #sbox("Leve", cm3) #h(1pt) $→$ #h(1pt)
      #sbox("Rem.", grn) #h(1pt) $→$ #h(1pt)
      #sbox("Rem.", grn) #h(1pt) $→$ #h(1pt)
      #sbox("Leve", cm3) #h(1pt) $→$ #h(1pt)
      #sbox("Rem.", grn) #h(1pt) $→$ #h(1pt) $dots$
      #set text(size: 18pt)
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SECCIÓN 7 — MODELOS OCULTOS DE MARKOV
// ════════════════════════════════════════════════════════════════════════════
#section-divider("7", "Modelos Ocultos", subtitle: "Hidden Markov Models — HMM")

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Modelos Ocultos (HMM)")
#sstitle("Motivación y definición")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size: 13pt)[
        En muchas situaciones los estados verdaderos son *latentes*
        (no observables directamente). Solo vemos *emisiones*
        que dependen del estado oculto.
      ]
      #v(8pt)
      #block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
        #text(fill: gry, size: 13pt)[
          *Ejemplo:* el "estado de ánimo" de un usuario en una sesión
          web es latente. Solo observamos las páginas visitadas
          (categorías como "producto", "ayuda", "carrito").
        ]
      ]
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        Un *HMM* tiene tres componentes:
        - $pi$: distribución inicial sobre estados ocultos.
        - $A$: matriz de transición entre estados ocultos.
        - $B$: matriz de emisión (prob. de cada observación dado el estado).
      ]
    ],
    [
      #ssstitle[Modelo gráfico HMM]
      #v(6pt)
      #align(center)[
        #canvas(length: 0.85cm, {
          import draw: *
          let cc = rgb("#00a1ae")
          let cg1 = rgb("#a3804c")
          let cgr = rgb("#6B7280")
          let cd = rgb("#032e35")

          // Background rects
          rect((-2.0, 1.0), (10.5, 3.6),
            fill: cc.lighten(90%),
            stroke: none,
            radius: 4pt)
          rect((-2.0, -2.6), (10.5, 0.6),
            fill: cg1.lighten(90%),
            stroke: none,
            radius: 4pt)

          content((-0.7, 3.3),
            text(fill: cc, size: 8pt, weight: "bold")[oculto])
          content((-0.7, -2.3),
            text(fill: cg1, size: 8pt, weight: "bold")[observado])

          let zs = ("z₁", "z₂", "z₃", "z₄")
          let os = ("o₁", "o₂", "o₃", "o₄")

          for i in range(4) {
            let x = i * 2.8

            // Hidden state node
            circle((x, 2.3), radius: 0.7,
              fill: cc.lighten(70%),
              stroke: 1.5pt + cc)
            content((x, 2.3),
              text(fill: cd, weight: "bold", size: 10pt)[#zs.at(i)])

            // Observation node
            rect((x - 0.65, -1.95), (x + 0.65, -0.65),
              fill: cg1.lighten(70%),
              stroke: 1.5pt + cg1,
              radius: 3pt)
            content((x, -1.3),
              text(fill: cd, weight: "bold", size: 10pt)[#os.at(i)])

            // Emission arrow
            line((x, 1.6), (x, -0.65),
              mark: (end: "straight"),
              stroke: (paint: cgr, thickness: 1pt))
            content((x + 0.4, 0.45),
              text(fill: cgr, size: 8pt)[B])

            // Transition arrow
            if i < 3 {
              line((x + 0.7, 2.3), (x + 2.1, 2.3),
                mark: (end: "straight"),
                stroke: (paint: cc, thickness: 1.2pt))
              content((x + 1.4, 2.65),
                text(fill: cc, size: 8pt)[A])
            }
          }

          // π label
          content((-1.5, 2.65),
            text(fill: cc, size: 10pt, weight: "bold")[π])
          line((-1.5, 2.45), (-0.7, 2.3),
            mark: (end: "straight"),
            stroke: (paint: cc, thickness: 0.8pt))
        })
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Modelos Ocultos (HMM)")
#sstitle("Algoritmos clave")
#slide[
  #grid(columns: (1fr, 1fr, 1fr), gutter: 16pt,
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Forward-Backward]
      #v(8pt)
      #text(fill: gry, size: 12pt)[
        *¿Cuál es la probabilidad de la secuencia observada?*

        #v(6pt)
        Calcula $P(O | lambda)$ de manera eficiente usando
        programación dinámica.

        #v(6pt)
        También da la distribución posterior sobre estados en
        cada paso de tiempo.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Viterbi]
      #v(8pt)
      #text(fill: gry, size: 12pt)[
        *¿Cuál es la secuencia de estados ocultos más probable?*

        #v(6pt)
        Decodifica la trayectoria óptima de estados dado
        el modelo y las observaciones.

        #v(6pt)
        Usado en reconocimiento de voz, etiquetado gramatical,
        y análisis de secuencias biológicas.
      ]
    ],
    block(stroke: 2pt + grn, inset: 14pt, radius: 5pt)[
      #ssstitle[Baum-Welch]
      #v(8pt)
      #text(fill: gry, size: 12pt)[
        *¿Cómo estimar los parámetros del modelo?*

        #v(6pt)
        Algoritmo EM especializado para HMM. Itera entre
        calcular la distribución posterior de estados
        y actualizar los parámetros.

        #v(6pt)
        Converge a un máximo (local) de la verosimilitud.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Modelos Ocultos (HMM)")
#sstitle("Ejemplo — comportamiento web")
#slide[
  #text(fill: gry, size: 12pt)[
    *El modelo aprende a inferir el estado oculto desde las observaciones.*
    Dos perfiles latentes: *Comprador* y *Curioso*.
  ]
  #v(8pt)
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Matriz de emisión B]
      #v(6pt)
      // Heatmap-style table — higher prob = darker fill
      #let heat(p) = cm3.lighten(100% - int(p * 90%))
      #table(
        stroke: none,
        inset: 7pt,
        columns: (auto, auto, auto, auto, auto, auto),
        fill: (col, row) => {
          if row == 0 or col == 0 { cm2 }
          else {
            let vals_comp = (0.05, 0.40, 0.35, 0.05, 0.15)
            let vals_cur  = (0.10, 0.50, 0.05, 0.25, 0.10)
            let idx = col - 1
            let p = if row == 1 { vals_comp.at(idx) } else { vals_cur.at(idx) }
            let pct = calc.max(10, int((1.0 - p * 1.8) * 100))
            cm3.lighten(pct * 1%)
          }
        },
        th[], th[Inicio], th[Prod.], th[Carrito], th[Ayuda], th[Salida],
        text(fill: white, weight: "bold", size: 11pt)[Comprador],
        text(fill: cm2, size: 10pt)[0.05],
        text(fill: white, size: 10pt)[0.40],
        text(fill: white, size: 10pt)[0.35],
        text(fill: cm2, size: 10pt)[0.05],
        text(fill: cm2, size: 10pt)[0.15],
        text(fill: white, weight: "bold", size: 11pt)[Curioso],
        text(fill: cm2, size: 10pt)[0.10],
        text(fill: white, size: 10pt)[0.50],
        text(fill: cm2, size: 10pt)[0.05],
        text(fill: white, size: 10pt)[0.25],
        text(fill: cm2, size: 10pt)[0.10],
      )
      #v(6pt)
      #text(fill: gry, size: 11pt)[
        Celdas más oscuras = mayor probabilidad de esa observación
        para ese estado oculto.
      ]
    ],
    [
      #ssstitle[Inferencia de estados ocultos]
      #v(10pt)
      #set text(size: 10pt)

      #text(fill: gry, size: 11pt)[Sesión A — Comprador:]
      #v(4pt)
      #text(fill: cm3, weight: "bold")[Obs: ]
      #sbox("Prod.", cm3) #h(1pt) $→$ #h(1pt)
      #sbox("Cart.", cm3) #h(1pt) $→$ #h(1pt)
      #sbox("Cart.", cm3) #h(1pt) $→$ #h(1pt)
      #sbox("Prod.", cm3)
      #v(3pt)
      #text(fill: cm1, weight: "bold")[Est: ]
      #sbox("Comp.", cm1) #h(1pt) $→$ #h(1pt)
      #sbox("Comp.", cm1) #h(1pt) $→$ #h(1pt)
      #sbox("Comp.", cm1) #h(1pt) $→$ #h(1pt)
      #sbox("Comp.", cm1)

      #v(14pt)

      #text(fill: gry, size: 11pt)[Sesión B — Curioso:]
      #v(4pt)
      #text(fill: cm3, weight: "bold")[Obs: ]
      #sbox("Prod.", cm3) #h(1pt) $→$ #h(1pt)
      #sbox("Ayuda", cm1) #h(1pt) $→$ #h(1pt)
      #sbox("Prod.", cm3) #h(1pt) $→$ #h(1pt)
      #sbox("Ayuda", cm1)
      #v(3pt)
      #text(fill: gry, weight: "bold")[Est: ]
      #sbox("Cur.", gry) #h(1pt) $→$ #h(1pt)
      #sbox("Cur.", gry) #h(1pt) $→$ #h(1pt)
      #sbox("Cur.", gry) #h(1pt) $→$ #h(1pt)
      #sbox("Cur.", gry)
      #set text(size: 18pt)
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// RESUMEN
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#counter-display
#stitle("Cadenas de Markov", sub: "Resumen")
#sstitle("Ideas clave")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #styled-table(
        columns: (auto, 1fr),
        th[Concepto], th[Qué resuelve],
        td[*Propiedad de Markov*],  tdg[Modela dependencia sin historia completa],
        td[*Matriz de transición*], tdg[Resume toda la dinámica del sistema],
        td[*Dist. estacionaria*],   tdg[Comportamiento promedio a largo plazo],
        td[*Estimación MLE*],       tdg[Aprender de datos con conteo de transiciones],
        td[*HMM*],                  tdg[Estados latentes + observaciones categóricas],
      )
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        Las cadenas de Markov complementan LCA y clustering:
        donde LCA *agrupa* individuos, Markov modela
        *cómo cambian* a lo largo del tiempo.
      ]
    ],
    [
      #ssstitle[¿Qué herramienta usar?]
      #v(8pt)
      #block(stroke: 2pt + cm3, inset: 12pt, radius: 5pt)[
        #text(fill: cm2, weight: "bold", size: 13pt)[Cadena de Markov simple]
        #v(4pt)
        #text(fill: gry, size: 12pt)[
          Datos observables · Transiciones directas entre estados
        ]
      ]
      #v(8pt)
      #block(stroke: 2pt + cm1, inset: 12pt, radius: 5pt)[
        #text(fill: cm2, weight: "bold", size: 13pt)[Cadena con absorbentes]
        #v(4pt)
        #text(fill: gry, size: 12pt)[
          Estudios de supervivencia · Tiempo hasta evento terminal
        ]
      ]
      #v(8pt)
      #block(stroke: 2pt + grn, inset: 12pt, radius: 5pt)[
        #text(fill: cm2, weight: "bold", size: 13pt)[HMM]
        #v(4pt)
        #text(fill: gry, size: 12pt)[
          Estados latentes · Secuencias con emisiones categóricas
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
    Cadenas de Markov y modelos probabilísticos secuenciales
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
