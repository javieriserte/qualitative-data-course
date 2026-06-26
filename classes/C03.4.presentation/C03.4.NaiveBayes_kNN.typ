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

#let code(body) = block(
  width: 100%, fill: rgb("#f0fdf4"),
  stroke: 0.5pt + cm3, inset: (x: 10pt, y: 8pt), radius: 4pt,
  text(size: 10pt)[#body]
)

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
      #text(size:14pt)[El clasificador parte del teorema de Bayes:]

      $ P(C_k | bold(x)) = frac(P(bold(x) | C_k), P(bold(x))) P(C_k) $

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Como $P(bold(x))$ es igual para todas las clases,
        basta comparar el numerador:
      ]

      $ P(C_k | bold(x)) prop P(bold(x) | C_k) dot P(C_k) $

      #v(0pt)
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
      #text(size: 12pt)[
        Naive Bayes asume que los predictores son
        *condicionalmente independientes* dada la clase:
      ]

      $ P(bold(x) | C_k) = product_(j=1)^p P(x_j | C_k) $

      #v(00pt)
      #text(fill: gry, size: 12pt)[
        Esto permite estimar cada $P(x_j | C_k)$ por separado,
        con muy pocos datos — incluso si $p$ es grande.

        #v(0pt)
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
  #grid(columns: (1fr, 1.5fr), gutter: 16pt,
    [
      Para cada predictor $j$ y clase $k$, GaussianNB estima:

      $ P(x_j | C_k) = frac(1, sigma_(k j) sqrt(2 pi))
          exp lr((-frac((x_j - mu_(k j))^2, 2 sigma_(k j)^2))) $

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        A diferencia de LDA:
        - Cada clase tiene su *propia* $sigma_(k j)$ y $mu_(k j)$por predictor. \
        - La matriz de covarianza implícita es *diagonal* (independencia). \
        - Las fronteras resultantes son *cuadráticas* — similares a QDA
          pero con menos parámetros (sin covarianzas cruzadas).
      ]
    ],
    [
      #align(center+horizon)[
        #figure(image("images/c034_gnb_regions.png", height: 285pt))
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "GaussianNB")
#sstitle("Código — ajuste e inspección del modelo")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #code[
        ```python
        from sklearn.naive_bayes import GaussianNB
        from sklearn.datasets import load_iris
        from sklearn.model_selection import train_test_split

        X, y = load_iris(return_X_y=True)
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=0.3, random_state=42
        )

        gnb = GaussianNB()
        gnb.fit(X_train, y_train)
        ```
      ]
      #v(0pt)
      #code[
        ```python
        # Parámetros estimados por clase y predictor
        gnb.classes_         # [0, 1, 2]
        gnb.class_prior_     # [0.33, 0.33, 0.33]

        gnb.theta_           # media μ_kj  → shape (3, 4)
        gnb.var_             # varianza σ²_kj → shape (3, 4)

        # Cada fila = una clase, cada columna = un predictor
        # theta_[0] → medias de la clase 0 para los 4 features
        ```
      ]
    ],
    [
      #code[
        ```python
        # Predicción para nuevas observaciones
        y_pred = gnb.predict(X_test)

        # Probabilidades posteriores P(C_k | x)
        probs = gnb.predict_proba(X_test)
        # shape (n_muestras, 3) — suma a 1 por fila

        # Ejemplo: primera observación de test
        print(probs[0])
        # [9.99e-01, 7.12e-04, 3.01e-07]
        # → casi certeza de clase 0
        ```
      ]
      #v(0pt)
      #code[
        ```python
        from sklearn.metrics import accuracy_score

        acc = accuracy_score(y_test, y_pred)
        print(f"Accuracy: {acc:.3f}")
        # Accuracy: 0.956
        ```
      ]
      #v(0pt)
      #text(fill: gry, size: 10pt)[
        `theta_` y `var_` permiten reconstruir manualmente
        la gaussiana de cada clase y predictor — útil
        para interpretar qué aprendió el modelo.
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
    #figure(image("images/c034_comparison_frontiers.png", height: 200pt))
  ]
  #v(0pt)
  #grid(columns: (1fr, 1fr, 1fr), gutter: 12pt,
    block(stroke: 1pt + cm2, inset: 10pt, radius: 4pt, width:100%)[
      #text(fill: cm2, weight: "bold", size: 13pt)[LDA]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        $bold(Sigma)$ compartida. Frontera *lineal*. Menos parámetros.
      ]
    ],
    block(stroke: 1pt + grn, inset: 10pt, radius: 4pt, width:100%)[
      #text(fill: grn, weight: "bold", size: 13pt)[GaussianNB]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        $bold(Sigma)_k$ diagonal. Frontera *cuadrática*.
        Ignora covarianzas cruzadas.
      ]
    ],
    block(stroke: 1pt + cm3, inset: 10pt, radius: 4pt)[
      #text(fill: cm3, weight: "bold", size: 13pt)[QDA]
      #v(4pt)
      #text(fill: gry, size: 12pt)[
        $bold(Sigma)_k$ completa.
        Frontera *cuadrática*.
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
  #grid(columns: (1fr, 1.2fr), gutter: 16pt,
    [
      #text(size:12pt)[
        Para cada valor $v$ de la variable $j$, CategoricalNB estima
        la probabilidad condicional como *frecuencia relativa*:
      ]

      $ P(x_j = v | C_k) = frac(n_(k,j,v), n_k) $
      #v(0pt)
      #text(fill: gry, size: 12pt)[donde $n_(k,j,v)$ = observaciones de clase $k$ con $x_j = v$.]
      #v(0pt)
    ],
    [
      #text(size: 12pt)[ *Ejemplo — ¿jugar al tenis?* ]
      #text(fill: gry, size: 12pt)[
        Dataset clásico con 4 predictores categóricos: Tiempo, Temperatura,
        Humedad, Viento; y clase binaria (Jugar: Sí / No).

        Cada barra es $P(x_j = v | C_k)$.
        Por ejemplo: $P("Tiempo"="Lluvia" | "Jugar=No") approx 0.5$
        — cuando no se juega, suele llover.
      ]
    ],
  )
  #align(center+horizon)[
    #figure(image("images/c034_categorical_nb_probs.png", height: 160pt))
  ]
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "CategoricalNB")
#sstitle("Código — preparación y ajuste")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #code[
        ```python
        import pandas as pd
        from sklearn.naive_bayes import CategoricalNB
        from sklearn.preprocessing import OrdinalEncoder
        # Dataset de tenis (14 días)
        df = pd.DataFrame({
            "Tiempo":      ["Soleado","Soleado","Nublado",
                            "Lluvioso","Lluvioso","Lluvioso",
                            "Nublado","Soleado","Soleado",
                            "Lluvioso","Soleado","Nublado",
                            "Nublado","Lluvioso"],
            "Temperatura": ["Alta","Alta","Alta","Templada",
                            "Fría","Fría","Fría","Templada",
                            "Fría","Templada","Templada",
                            "Templada","Alta","Templada"],
            "Humedad":     ["Alta","Alta","Alta","Alta",
                            "Normal","Normal","Normal","Alta",
                            "Normal","Normal","Normal","Alta",
                            "Normal","Alta"],
            "Viento":      ["Débil","Fuerte","Débil","Débil",
                            "Débil","Fuerte","Fuerte","Débil",
                            "Débil","Débil","Fuerte","Fuerte",
                            "Débil","Fuerte"],
            "Jugar":       [0,0,1,1,1,0,1,0,1,1,1,1,1,0],
        })
        ```
      ]
    ],
    [
      #code[
        ```python
        X = df.iloc[:, :-1]   # predictores
        y = df["Jugar"]       # clase (0=No, 1=Sí)
        # CategoricalNB necesita enteros ≥ 0
        enc = OrdinalEncoder()
        X_enc = enc.fit_transform(X)
        # alpha=1 → suavizado de Laplace
        cnb = CategoricalNB(alpha=1.0)
        cnb.fit(X_enc, y)
        ```
      ]
      #code[
        ```python
        # Probabilidades aprendidas por clase
        # cnb.feature_log_prob_[clase][predictor]
        import numpy as np
        probs = [np.exp(p) for p in cnb.feature_log_prob_]

        # probs[1][0] → P(Tiempo=v | Jugar=Sí)
        # para cada categoría v de "Tiempo"
        ```
      ]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        `OrdinalEncoder` convierte cada categoría a un entero.
        El orden numérico no importa para `CategoricalNB` —
        solo se usa como índice interno.
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
      #text(fill: gry, size: 14pt)[
        Se calcula el mismo producto para la clase "No"
        y se asigna la clase con mayor valor.
      ]
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Resultado con sklearn]
      #v(8pt)
      #code[
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

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "CategoricalNB")
#sstitle("Código — cálculo manual del posterior")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #text(fill: gry, size: 12pt)[
        Podemos reproducir el resultado de sklearn paso a paso,
        multiplicando las frecuencias condicionales de cada predictor.
      ]
      #v(8pt)
      #code[
        ```python
        import numpy as np

        # Probabilidades condicionales (con Laplace alpha=1)
        # para el caso: Soleado, Fría, Alta, Fuerte
        caso = enc.transform(
            [["Soleado","Fría","Alta","Fuerte"]]
        )[0].astype(int)

        log_probs = cnb.class_log_prior_.copy()

        for j, val in enumerate(caso):
            log_probs += cnb.feature_log_prob_[j][:, val]

        # Convertir de log a probabilidades normalizadas
        log_probs -= log_probs.max()
        probs = np.exp(log_probs)
        probs /= probs.sum()

        print(dict(zip(["No","Sí"], probs.round(3))))
        # {'No': 0.657, 'Sí': 0.343}
        ```
      ]
    ],
    [
      #text(fill: gry, size: 12pt)[
        El mismo cálculo en forma explícita, usando logaritmos
        para evitar underflow numérico al multiplicar probabilidades pequeñas:
      ]
      #v(8pt)
      #code[
        ```python
        # Equivalente sin logaritmos (solo ilustrativo)
        # — en la práctica los logs son necesarios
        prior_si  = (y == 1).mean()   # 9/14 ≈ 0.643
        prior_no  = (y == 0).mean()   # 5/14 ≈ 0.357
        # P(Soleado | Sí), P(Fría | Sí), ...
        # obtenidos desde cnb.feature_log_prob_
        p_si = prior_si * 0.222 * 0.111 * 0.333 * 0.333
        p_no = prior_no * 0.600 * 0.200 * 0.400 * 0.600

        # Normalizar
        total = p_si + p_no
        print(f"P(Sí | x) = {p_si/total:.3f}")
        print(f"P(No | x) = {p_no/total:.3f}")
        # P(Sí | x) = 0.343
        # P(No | x) = 0.657
        ```
      ]
      #text(fill: gry, size: 11pt)[
        El orden de magnitud de las probabilidades individuales
        es pequeño — por eso sklearn trabaja siempre en escala logarítmica.
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
      #text(size:14pt)[
        Si una combinación (valor, clase) *no aparece* en los datos
        de entrenamiento, su frecuencia estimada es 0:
      ]
      $ P(x_j = v | C_k) = 0 $

      #text(fill: gry, size: 12pt)[
        Al multiplicar las verosimilitudes, *un solo cero
        hace colapsar toda la probabilidad posterior* de esa clase
        — sin importar los demás predictores.
      ]
      #v(0pt)
      #text(size: 12pt)[*Solución: suavizado de Laplace*]

      $ P(x_j = v | C_k) = frac(n_(k,j,v) + alpha, n_k + alpha dot |V_j|) $

      #styled-table(
        columns: (auto, 1fr),
        th[Símbolo], th[Significado],
        td[$alpha$],   tdg[Pseudo-conteo añadido a cada combinación (default = 1)],
        td[$|V_j|$],   tdg[Número de categorías distintas del predictor $j$],
      )
    ],
    [
      #align(center+horizon)[
        #figure(image("images/c034_laplace_effect.png", height: 170pt))
      ]
      #v(8pt)
      #text(fill: gry, size: 12pt)[
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
      #text(size:12pt)[
      kNN es *no paramétrico*: no ajusta ningún modelo.
      Para clasificar un punto nuevo $bold(x)$:
      ]

      #v(0pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Paso], th[Acción],
        td[1], tdg[Calcular la distancia de $bold(x)$ a *todos* los puntos de entrenamiento],
        td[2], tdg[Seleccionar los $k$ puntos más cercanos (*vecinos*)],
        td[3], tdg[Asignar la *clase mayoritaria* entre esos $k$ vecinos],
      )
      #v(10pt)
      #text(fill: gry, size: 12pt)[
        No hay fase de entrenamiento propiamente dicha —
        el modelo *es* el conjunto de datos.
        La distancia más común es la *euclídea*:
      ]
      $ d(bold(x), bold(x)') = sqrt(sum_(j=1)^p (x_j - x'_j)^2) $
    ],
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Implementación básica]
      #v(8pt)
      #code[
        ```python
        from sklearn.neighbors import (
            KNeighborsClassifier)

        knn = KNeighborsClassifier(
            n_neighbors=5,
            metric="euclidean"  # default: minkowski p=2
        )
        knn.fit(X_train, y_train)

        knn.predict(X_new)
        knn.predict_proba(X_new)
        # fracción de vecinos de cada clase
        ```
      ]
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
#sstitle("¿Qué son los vecinos más cercanos?")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 18pt,
    [
      #text(fill: gry, size: 14pt)[
        Dado un punto nuevo $bold(x)$ (estrella azul), kNN busca los
        $k$ puntos de entrenamiento *más cercanos* en el espacio de features.
      ]
      #v(10pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Elemento], th[Descripción],
        td[Estrella $bold(x)$],   tdg[Punto nuevo a clasificar],
        td[Círculo],              tdg[Radio que encierra los $k$ vecinos más próximos],
        td[Líneas punteadas],     tdg[Distancia euclídea a cada vecino],
        td[Puntos resaltados],    tdg[Los $k$ vecinos seleccionados],
      )
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        Con $k = 5$: 3 vecinos son Clase A y 2 son Clase B
        → el punto se asigna a *Clase A* por mayoría.
      ]
    ],
    [
      #align(center+horizon)[
        #figure(image("images/c034_knn_neighbors.png", height: 270pt))
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "kNN")
#sstitle("Código — ajuste, predicción e inspección")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #code[
        ```python
        from sklearn.neighbors import KNeighborsClassifier
        from sklearn.datasets import load_iris
        from sklearn.model_selection import train_test_split

        X, y = load_iris(return_X_y=True)
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=0.3, random_state=42
        )

        knn = KNeighborsClassifier(n_neighbors=5)
        knn.fit(X_train, y_train)

        y_pred  = knn.predict(X_test)
        y_proba = knn.predict_proba(X_test)

        # y_proba[i] → fracción de vecinos de cada clase
        # Ejemplo: [0.0, 0.4, 0.6] → 3 de 5 vecinos son clase 2
        ```
      ]
    ],
    [
      #code[
        ```python
        # Inspeccionar los vecinos de una observación
        distancias, indices = knn.kneighbors(
            X_test[[0]]   # primera obs. de test
        )

        print("Índices de vecinos:", indices[0])
        # [34, 12, 78, 5, 61]

        print("Distancias:", distancias[0].round(3))
        # [0.141, 0.173, 0.200, 0.245, 0.265]

        print("Clases de los vecinos:", y_train[indices[0]])
        # [0, 0, 0, 0, 0]  → unanimidad → P(clase 0) = 1.0
        ```
      ]
      #v(8pt)
      #code[
        ```python
        from sklearn.metrics import accuracy_score

        print(f"Accuracy: {accuracy_score(y_test, y_pred):.3f}")
        # Accuracy: 1.000  (Iris es un dataset sencillo)
        ```
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "kNN")
#sstitle("Efecto del hiperparámetro k")
#slide[
  #grid(columns: (1.4fr, 1fr), gutter: 16pt,
    align(center)[
      #figure(image("images/c034_knn_k_effect.png", height: 270pt))
    ],
    align(center+horizon)[
      #block(stroke: 1pt + cm3, inset: 4pt, radius: 2pt)[
        #text(weight: "bold", fill: cm3, size:14pt)[k pequeño (k = 1)]
        #v(4pt)
        #text(fill: gry, size: 11pt)[
          Frontera muy irregular. Cada punto de entrenamiento
          define su propia región → *sobreajuste* (high variance).
          El modelo memoriza el ruido.
        ]
      ]
      #block(stroke: 1pt + cm1, inset: 4pt, radius: 2pt)[
        #text(weight: "bold", fill: cm1, size:14pt)[k grande (k = 50)]
        #v(4pt)
        #text(fill: gry, size: 11pt)[
          Frontera muy suave. Promedia demasiado →
          *subajuste* (high bias). Ignora patrones locales
          reales en los datos.
        ]
      ]
    ]
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
  #grid(columns: (1fr, 1.5fr), gutter: 16pt,
    [
      #text(size: 10pt)[
        La elección óptima de $k$ se hace midiendo el rendimiento
        sobre datos *no vistos* durante el entrenamiento.
        La *validación cruzada k-fold* divide el conjunto de
        entrenamiento en $f$ partes iguales:
      ]
      #align(center)[
        #scale(80%, reflow:true)[
          #styled-table(
            columns: (auto, 1fr),
            th[Paso], th[Acción],
            td[1], tdg[Dividir los datos de entrenamiento en $f$ folds],
            td[2], tdg[Entrenar con $f-1$ folds, evaluar en el fold restante],
            td[3], tdg[Repetir $f$ veces rotando el fold de validación],
            td[4], tdg[Promediar las $f$ accuracies → CV accuracy],
            td[5], tdg[Elegir el $k$ que maximiza el CV accuracy],
          )
        ]
      ]
    ],
    [
      #align(center+horizon)[
        #figure(image("images/c034_knn_cv.png", height: 205pt))
      ]
      #text(fill: gry, size: 13pt)[
        La curva de train accuracy (azul) decrece con $k$ —
        el modelo se simplifica. La CV accuracy (naranja) tiene
        un máximo: ese es el $k$ óptimo.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Selección de k")
#sstitle("Código — búsqueda del k óptimo")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #code[
        ```python
        import numpy as np
        import matplotlib.pyplot as plt
        from sklearn.neighbors import KNeighborsClassifier
        from sklearn.model_selection import cross_val_score

        k_values = range(1, 31)
        cv_scores   = []
        train_scores = []

        for k in k_values:
            knn = KNeighborsClassifier(n_neighbors=k)

            # CV accuracy (5-fold)
            cv = cross_val_score(
                knn, X_train, y_train, cv=5, scoring="accuracy"
            )
            cv_scores.append(cv.mean())

            # Train accuracy
            knn.fit(X_train, y_train)
            train_scores.append(
                knn.score(X_train, y_train)
            )
        ```
      ]
    ],
    [
      #code[
        ```python
        # Identificar el k óptimo
        k_optimo = k_values[np.argmax(cv_scores)]
        print(f"k óptimo: {k_optimo}")
        print(f"CV accuracy: {max(cv_scores):.3f}")

        # Reentrenar con todo X_train y k óptimo
        knn_final = KNeighborsClassifier(
            n_neighbors=k_optimo
        )
        knn_final.fit(X_train, y_train)

        # Evaluar en test (una sola vez, al final)
        test_acc = knn_final.score(X_test, y_test)
        print(f"Test accuracy: {test_acc:.3f}")
        ```
      ]
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        *Regla importante:* el conjunto de test no debe
        usarse para elegir $k$ — solo para la evaluación
        final. Usarlo en la selección introduce sesgo
        optimista en la estimación de error.
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
  #grid(columns: (1fr, 1.8fr), gutter: 16pt,
    [
      #text(size:12pt)[
        kNN clasifica por *distancia*. Si dos predictores tienen
        escalas muy distintas, el de mayor escala domina el cálculo
        y los demás se vuelven irrelevantes.
      ]
      #v(0pt)
      #text(fill: gry, size: 12pt)[
        *Ejemplo:* X1 en centímetros (rango 0–200),
        X2 en kilogramos (rango 0–100).
        Una diferencia de 1 cm equivale a 1 unidad de distancia,
        igual que 1 kg — aunque 1 cm es mucho menos significativo.
      ]

      #v(0pt)
      #text(size: 12pt)[*Solución: estandarización z-score*]

      $ z_j = frac(x_j - mu_j, sigma_j) $

      #v(0pt)
      #text(fill: gry, size: 10pt)[
        Cada predictor queda con media 0 y desviación estándar 1.
        Así todos contribuyen por igual al cálculo de distancia.
      ]
    ],
    [
      #align(center+horizon)[
        #figure(image("images/c034_knn_normalization.png", height: 150pt))
      ]
      #text(fill: gry, size: 13pt)[
        Sin normalizar (izquierda), $X_1$ domina la distancia
        y las fronteras son casi horizontales. Con normalización
        (derecha), ambos predictores contribuyen por igual.
      ]
    ],
  )
]

#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Normalización en kNN")
#sstitle("Código — pipeline con estandarización")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #code[
        ```python
        from sklearn.preprocessing import StandardScaler
        from sklearn.neighbors import KNeighborsClassifier
        from sklearn.pipeline import Pipeline
        from sklearn.model_selection import (
            cross_val_score, train_test_split
        )

        # Pipeline: escalar → clasificar
        # El scaler se ajusta solo sobre X_train
        # y aplica la misma transformación a X_test
        pipe = Pipeline([
            ("scaler", StandardScaler()),
            ("knn",    KNeighborsClassifier(n_neighbors=5))
        ])

        pipe.fit(X_train, y_train)
        y_pred = pipe.predict(X_test)
        ```
      ]
    ],
    [
      #code[
        ```python
        # Por qué usar Pipeline y no escalar a mano:
        # ✗ Incorrecto — fuga de información (data leakage)
        scaler = StandardScaler()
        X_all_scaled = scaler.fit_transform(X)   # usa test!
        X_tr, X_te, y_tr, y_te = train_test_split(
            X_all_scaled, y
        )

        # ✓ Correcto — el pipeline escala dentro del CV
        cv_scores = cross_val_score(
            pipe, X_train, y_train, cv=5
        )
        print(cv_scores.mean().round(3))
        # → 0.971
        ```
      ]
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        El `Pipeline` garantiza que los parámetros del
        `StandardScaler` ($mu_j$, $sigma_j$) se estiman
        *solo* sobre el fold de entrenamiento de cada
        iteración del CV — nunca con datos de validación.
      ]
    ],
  )
]


#pagebreak()
#counter-display
#stitle("Unidad III", sub: "Comparación")
#sstitle("Código — comparar todos los clasificadores")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 16pt,
    [
      #code[
        ```python
        from sklearn.discriminant_analysis import (
            LinearDiscriminantAnalysis,
            QuadraticDiscriminantAnalysis,
        )
        from sklearn.naive_bayes import GaussianNB
        from sklearn.neighbors import KNeighborsClassifier
        from sklearn.pipeline import Pipeline
        from sklearn.preprocessing import StandardScaler
        from sklearn.model_selection import cross_val_score

        modelos = {
            "LDA":       LinearDiscriminantAnalysis(),
            "QDA":       QuadraticDiscriminantAnalysis(),
            "GaussianNB": GaussianNB(),
            "kNN k=5":   Pipeline([
                             ("sc", StandardScaler()),
                             ("knn", KNeighborsClassifier(5))
                         ]),
            "kNN k=15":  Pipeline([
                             ("sc", StandardScaler()),
                             ("knn", KNeighborsClassifier(15))
                         ]),
        }
        ```
      ]
    ],
    [
      #code[
        ```python
        resultados = {}
        for nombre, modelo in modelos.items():
            scores = cross_val_score(
                modelo, X_train, y_train,
                cv=5, scoring="accuracy"
            )
            resultados[nombre] = scores.mean()

        for nombre, acc in sorted(
            resultados.items(),
            key=lambda x: -x[1]
        ):
            print(f"{nombre:<14} {acc:.3f}")

        # GaussianNB    0.968
        # kNN k=5       0.962
        # QDA           0.958
        # LDA           0.947
        # kNN k=15      0.943
        ```
      ]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Comparar siempre con CV sobre *train* — nunca
        mirar el test hasta elegir el modelo final.
        El ranking cambia con cada dataset.
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
