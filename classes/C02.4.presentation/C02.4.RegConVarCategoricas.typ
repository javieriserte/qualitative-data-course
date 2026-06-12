// ─── Configuración global ────────────────────────────────────────────────────
#set page(
  paper: "presentation-16-9",
  background: rect(fill: rgb("#f9f8f5"), width: 100%, height: 100%),
  margin: (x: 32pt, y: 26pt),
)
#set text(font: "Arial", size: 18pt, lang: "es", fill: rgb("#032e35"))
#set par(justify: false, leading: 0.6em)
#show math.equation: set text(size: 15pt)

// ─── Paleta ──────────────────────────────────────────────────────────────────
#let cm1 = rgb("#a3804c")
#let cm2 = rgb("#032e35")
#let cm3 = rgb("#00a1ae")
#let grn = rgb("#15803D")
#let gry = rgb("#6B7280")
#let red = rgb("#e74c3c")

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
  inset: 4pt,
  fill: (col, row) => if row == 0 { cm2 } else if calc.odd(row) { rgb("#f0f4f4") } else { white },
  ..args,
)

#let th(body) = text(fill: white, weight: "bold", size: 12pt)[#body]
#let td(body) = text(fill: cm2, size: 12pt)[#body]
#let tdg(body) = text(fill: gry, size: 12pt)[#body]

#let code-box(body) = block(
  width: 88%, fill: rgb("#f0fdf4"),
  stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
  text(size: 11pt)[#body]
)

// ════════════════════════════════════════════════════════════════════════════
// PORTADA
// ════════════════════════════════════════════════════════════════════════════
#cover(
  "Unidad II",
  "Regresión con Variables Categóricas",
  "One-Hot · Target Encoding · OvR · Multinomial",
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
  #set text(size: 15pt)
  #set par(leading: 0.9em)
  + Variables categóricas en modelos lineales
  + One-Hot Encoding / Dummies \
    #text(fill: gry, size: 12pt)[Variables dicotómicas · Múltiples categorías · Multicolinealidad]
  + Target Encoding \
    #text(fill: gry, size: 12pt)[Codificación por media del target]
  + Modelos con variable dependiente categórica múltiple \
    #text(fill: gry, size: 12pt)[One-vs-Rest (OvR)]
  + Regresión Logística Multinomial \
    #text(fill: gry, size: 12pt)[Softmax · Log-odds · Categoría de referencia]
]

// ════════════════════════════════════════════════════════════════════════════
// 1. VARIABLES CATEGÓRICAS EN MODELOS LINEALES
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Variables Categóricas", subtitle: "Limitaciones de los modelos lineales estándar")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Variables categóricas")
#sstitle("El problema")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      Los modelos lineales estándar *solo pueden trabajar con variables
      continuas* (dependientes e independientes).

      #v(8pt)
      Sin embargo, en la práctica abundan variables categóricas:

      #v(4pt)
      #text(fill: gry, size: 14pt)[
        - *Independientes:* sexo, hábito de fumar, nivel educativo,
          ciudad de residencia.
        - *Dependientes:* tipo de diagnóstico, ciudad de destino,
          categoría de producto.
      ]

      #v(8pt)
      Existen estrategias para incorporar estas variables a los modelos:
    ],
    [
      #styled-table(
        columns: (auto, 1fr, 1fr),
        th[Tipo], th[Variable independiente], th[Variable dependiente],
        td[Dicotómica],    tdg[Dummy 0/1],         tdg[Reg. logística binaria],
        td[Multinomial],   tdg[One-Hot / Target enc.], tdg[OvR · MNLogit],
        td[Ordinal],       tdg[Encoding ordinal],  tdg[Reg. ordinal],
      )
      #v(10pt)
      #block(stroke: 1.5pt + cm1, inset: 8pt, radius: 4pt, width: 100%)[
        #text(size: 12pt)[
          El tipo de variable determina qué estrategia de codificación
          y qué modelo es adecuado.
        ]
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 2. ONE-HOT ENCODING / DUMMIES
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "One-Hot Encoding", subtitle: "Dummies · Variables independientes categóricas")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "One-Hot Encoding")
#sstitle("Codificación con variables dummy")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      Para incluir una variable categórica como independiente en un
      modelo lineal, se transforma en una o más variables binarias (0/1).

      #v(0pt)
      #ssstitle[Variable dicotómica]
      #v(0pt)
      #text(fill: gry, size: 13pt)[
        - Se crea *una sola* variable: 1 para una categoría, 0 para la otra.
        - Ejemplo: `Sex_Female = 1` si mujer, `0` si hombre.
      ]

      #v(0pt)
      #ssstitle[Variable con N categorías]
      #v(0pt)
      #text(fill: gry, size: 11pt)[
        - *Dummies:* se crean $N - 1$ variables (se excluye una categoría
          de referencia para evitar multicolinealidad perfecta).
        - *One-Hot:* se crean $N$ variables (una por categoría).
          Requiere regularización o eliminación explícita de una columna.
      ]
    ],
    [

      #align(center)[
        #styled-table(
          columns: (100pt, 100pt),
          th[Categoría], th[Encoding],
          td[Rojo],    tdg[1 0 0],
          td[Verde],   tdg[0 1 0],
          td[Azul],       tdg[0 0 1],
        )
      ]
      #text(fill: gry, size: 12pt)[
        Cada fila tiene exactamente un `1` en la columna correspondiente
        a su categoría; el resto son `0`.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "One-Hot Encoding")
#sstitle("Ejemplo — predicción de altura")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size: 14pt)[
        Se ajusta un modelo OLS para predecir la *altura* de estudiantes
        a partir de:
        #v(4pt)
        #text(fill: gry, size: 13pt)[
          - Sexo (`Sex_Female`)
          - Hábito de fumar (`Smoke_Never`, `Smoke_Occas`, `Smoke_Regul`)
          - Frecuencia de ejercicio (`Exer_Freq`)
        ]

        #v(6pt)
        Las variables categóricas se codifican con dummies, excluyendo
        una categoría de referencia por grupo:
        #v(2pt)
        #text(fill: gry, size: 12pt)[
          - Referencia de Sexo: `Sex_Male`
          - Referencia de Smoke: `Smoke_Heavy`
          - Referencia de Exer: `Exer_Some`/`Exer_None`
        ]
      ]
    ],
    [
      #code-box[
        ```python
        survey_mod = pd.get_dummies(
          survey[["Height","Sex","Smoke","Exer"]]
        ).astype(float)

        # Seleccionamos N-1 por grupo
        selected = [
          'Height', 'Sex_Female',
          'Smoke_Never', 'Smoke_Occas',
          'Smoke_Regul', 'Exer_Freq',
        ]
        survey_mod = survey_mod[selected]

        exog = sm.add_constant(
          survey_train.drop(columns=["Height"])
        )
        model = sm.OLS(
          endog=survey_train["Height"],
          exog=exog
        ).fit()
        ```
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "One-Hot Encoding")
#sstitle("Resultados — ajuste en test")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #figure(image("images/ols_dummy_scatter.png", height: 270pt))
    ],
    [
      #v(10pt)
      #text(size: 14pt)[
        El gráfico muestra la altura *real* (eje X) frente a la *predicha*
        (eje Y) en el conjunto de test.
      ]
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        - La correlación $rho$ mide la concordancia lineal entre
          valores reales y predichos.
        - Los puntos se agrupan en columnas verticales porque
          las variables predictoras son todas binarias (0/1):
          el modelo solo puede generar un número discreto de
          predicciones distintas.
        - Esto es una *limitación* del modelo con variables
          categóricas puras sin predictores continuos.
      ]
      #v(8pt)
      #block(stroke: 1.5pt + cm1, inset: 7pt, radius: 4pt, width: 100%)[
        #text(size: 12pt)[
          Añadir predictores continuos (talla de la mano, edad)
          mejoraría la granularidad de las predicciones.
        ]
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 3. TARGET ENCODING
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Target Encoding", subtitle: "Codificación por media del target")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Target Encoding")
#sstitle("Concepto")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      Consiste en reemplazar cada categoría por un *valor numérico que
      resume su relación con la variable dependiente*.

      #v(8pt)
      #ssstitle[Procedimiento]
      #v(4pt)
      #set text(size: 13pt)
      + Para cada nivel de la variable categórica, calcular la
        *media del target* ($overline(y)_k$) en el conjunto de entrenamiento.
      + Reemplazar cada categoría por esa media.

      #v(8pt)
      $ "Color" = "Rojo" quad arrow.r quad overline(y)_("Rojo") = frac(sum_{i: x_i="Rojo"} y_i, n_("Rojo")) $

      #v(6pt)
      #text(fill: gry, size: 12pt)[
        *Ventaja:* genera una sola variable numérica por categoría,
        independientemente del número de niveles.
      ]
    ],
    [
      #grid(
        columns: (1fr, 1fr),
        gutter: 10pt,
        [
          #text(size:12pt)[Original]
          #scale(60%, reflow:true)[
            #styled-table(
              columns: (1fr, 1fr, 1fr),
              th[Y], th[A], th[Color],
              td[1], td[1], td[Rojo],
              td[2], td[4], td[Rojo],
              td[3], td[3], td[Verde],
              td[3], td[4], td[Verde],
              td[6], td[7], td[Verde],
              td[2], td[4], td[Verde],
              td[1], td[5], td[Azul],
              td[2], td[7], td[Azul],
            )
          ]
        ],
        [
          #text(size:12pt)[Target Encoding]
          #scale(60%, reflow:true)[
            #styled-table(
              columns: (1fr, 1fr, 1fr),
              th[Y], th[A], th[Color],
              td[1], td[1], td[1.5],
              td[2], td[4], td[1.5],
              td[3], td[3], td[3.5],
              td[3], td[4], td[3.5],
              td[6], td[7], td[3.5],
              td[2], td[4], td[3.5],
              td[1], td[5], td[1.5],
              td[2], td[7], td[1.5],
            )
          ]
        ]
      )


      #v(4pt)
      #block(stroke: 1.5pt + red, inset: 7pt, radius: 4pt, width: 100%)[
        #text(size: 11pt)[
          *Riesgo de leakage:* nunca calcular las medias sobre el
          conjunto de test. Siempre ajustar el encoding solo en train.
        ]
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Target Encoding")
#sstitle("Implementación en Python")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #code-box[
        ```python
        import pandas as pd

        # Calcular medias en train
        target_means = (
          df_train
          .groupby("Color")["Y"]
          .mean()
        )

        # Aplicar a train y test
        df_train["Color_enc"] = (
          df_train["Color"].map(target_means)
        )
        df_test["Color_enc"] = (
          df_test["Color"].map(target_means)
        )
        ```
      ]
    ],
    [
      #ssstitle[Con scikit-learn]
      #v(4pt)
      #code-box[
        ```python
        from sklearn.preprocessing import (
          TargetEncoder
        )

        enc = TargetEncoder()
        X_train_enc = enc.fit_transform(
          X_train[["Color"]], y_train
        )
        X_test_enc = enc.transform(
          X_test[["Color"]]
        )
        ```
      ]
      #v(6pt)
      #text(fill: gry, size: 12pt)[
        `TargetEncoder` de sklearn incorpora *regularización*
        (shrinkage) para evitar que categorías raras con pocas
        observaciones dominen la codificación.
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 4. ONE-VS-REST (OvR)
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "One-vs-Rest", subtitle: "Variable dependiente con múltiples categorías")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "One-vs-Rest")
#sstitle("Estrategia OvR")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      Cuando la *variable dependiente tiene $N$ categorías*, se pueden
      construir $N$ modelos logísticos independientes.

      #v(8pt)
      #ssstitle[Procedimiento]
      #v(4pt)
      #set text(size: 13pt)
      + Para cada categoría $k$, crear una variable binaria: \
        $Y_k = 1$ si la observación pertenece a $k$, $0$ en caso contrario.
      + Ajustar un modelo logístico para cada $Y_k$.
      + Para predecir, calcular $P(Y = k)$ con cada modelo y asignar
        la categoría con mayor probabilidad.

      #v(8pt)
      $ hat(y) = arg max_k P_k(x) $
    ],
    [
      #code-box[
        ```python
        outputs = c_data["lugar"].unique()
        # ["Newark", "NewYork", "WestWood"]

        fitted_models = []
        for o in outputs:
          c_endog = (
            survey_train["lugar"] == o
          ).astype(int)

          m = sm.Logit(
            endog=c_endog,
            exog=exog
          )
          fitted_models.append(m.fit())

        # Predicción
        predicted = np.column_stack([
          m.predict(exog_test)
          for m in fitted_models
        ])
        y_pred = np.argmax(predicted, axis=1)
        ```
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "One-vs-Rest")
#sstitle("Resultados — clasificación de ciudades")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #figure(image("images/ovr_confusion.png", height: 260pt))
    ],
    [
      #v(10pt)
      #text(size: 14pt)[
        Se predice la *ciudad de residencia* a partir de:
        #v(4pt)
        #text(fill: gry, size: 13pt)[
          - Ingreso mensual
          - Número de hijos
          - Edad
          - Horas de viaje diario
        ]
      ]

      #v(8pt)
      #text(fill: gry, size: 13pt)[
        La *matriz de confusión* muestra cuántas observaciones de cada
        clase real fueron predichas como cada clase.
        La diagonal principal corresponde a las predicciones correctas.
      ]

      #v(8pt)
      #block(stroke: 1.5pt + cm3, inset: 7pt, radius: 4pt, width: 100%)[
        #text(size: 12pt)[
          *Limitación del OvR:* los $N$ modelos son independientes y
          sus probabilidades no necesariamente suman 1.
          La asignación se hace por argmax, no por normalización.
        ]
      ]
    ],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 5. REGRESIÓN LOGÍSTICA MULTINOMIAL
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Regresión Multinomial", subtitle: "MNLogit · Softmax · Log-odds")

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Regresión Multinomial")
#sstitle("Modelo MNLogit")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        Extensión natural de la regresión logística binaria cuando la
        variable dependiente tiene *más de dos categorías nominales*.
        #v(2pt)
        Para cada categoría $k$ se define un predictor lineal:

        $ eta_k = beta_(0k) + beta_(1k) x_1 + dots.c + beta_(p k) x_p $

        #v(2pt)
        Las probabilidades se obtienen con la función *softmax*:

        $ P(Y = k | bold(x)) = frac(exp(eta_k), sum_(j=1)^K exp(eta_j)) $
      ]


      #v(4pt)
      #text(fill: gry, size: 11pt)[
        - Las probabilidades son *no negativas* y suman 1. \
        - Una categoría actúa como *referencia* (coeficientes = 0). \
        - Los coeficientes se interpretan como *log-odds* respecto
          a la categoría de referencia.
      ]
    ],
    [
      #code-box[
        ```python
        import statsmodels.api as sm

        model = sm.MNLogit(
          endog=survey_train["lugar"],
          exog=survey_train.iloc[:, :4]
        )
        fitted = model.fit()
        print(fitted.summary())
        ```
      ]
      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Parámetro], th[Descripción],
        td[$K$], tdg[Número de categorías],
        td[Referencia], tdg[Categoría con coef. = 0],
        td[Softmax], tdg[Probabilidades normalizadas],
        td[MLE], tdg[Estimación por máx. verosimilitud],
      )
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Regresión Multinomial")
#sstitle("Resultados del modelo")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #code-box[
        ```
        MNLogit Regression Results
        ==============================
        Dep. Variable:       lugar
        No. Observations:      50
        Pseudo R-squ.:       0.60
        LLR p-value:    3.95e-12
        ──────────────────────────
        lugar=Newark
        ingreso      0.008  p=0.006
        hijos       -4.52   p<0.001
        edad        -0.015  p=0.867
        horas_viaje -6.16   p=0.008
        ──────────────────────────
        lugar=WestWood
        ingreso      0.002  p=0.180
        hijos       -1.67   p=0.004
        edad         0.107  p=0.064
        horas_viaje -2.90   p=0.026
        ```
      ]
    ],
    [
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Los coeficientes se interpretan como *log-odds* de pertenecer
        a esa categoría vs. la categoría de referencia (NewYork).
      ]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Variable], th[Efecto (Newark vs. NewYork)],
        td[`hijos`], tdg[Más hijos → menos prob. Newark],
        td[`horas_viaje`], tdg[Más viaje → menos prob. Newark],
        td[`ingreso`], tdg[Mayor ingreso → más prob. Newark],
        td[`edad`], tdg[No significativo (p=0.87)],
      )
      #v(6pt)
      #text(fill: gry, size: 12pt)[
        Pseudo $R^2 = 0.60$ indica un buen ajuste relativo al
        modelo nulo (solo intercepto).
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad II", sub: "Regresión Multinomial")
#sstitle("Comparación OvR vs. MNLogit")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[OvR — Matriz de confusión]
      #figure(image("images/ovr_confusion.png", height: 175pt))
    ],
    [
      #ssstitle[MNLogit — Matriz de confusión]
      #figure(image("images/mnlogit_confusion.png", height: 175pt))
    ],
  )
  #v(2pt)
  #slide[
    #styled-table(
      columns: (auto, 1fr, 1fr),
      th[Aspecto],      th[OvR],                        th[MNLogit],
      td[Modelos],      tdg[$N$ modelos independientes], tdg[1 modelo conjunto],
      td[Probabilidades], tdg[No normalizadas (argmax)], tdg[Softmax — suman 1],
      td[Interpretación], tdg[Cada modelo es autónomo], tdg[Coeficientes relativos a referencia],
      td[Implementación], tdg[Flexible — cualquier clasificador], tdg[Específico para logística],
    )
  ]
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
    Regresión con Variables Categóricas
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
