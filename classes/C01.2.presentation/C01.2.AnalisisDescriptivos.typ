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

#let th(body)  = text(fill: white, weight: "bold", size: 12pt)[#body]
#let td(body)  = text(fill: cm2,   size: 12pt)[#body]
#let tdg(body) = text(fill: gry,   size: 12pt)[#body]

#let code-box(body) = block(
  width: 100%, fill: rgb("#f0fdf4"),
  stroke: 0.5pt + cm3, inset: (x: 12pt, y: 8pt), radius: 4pt,
  text(size: 13pt)[#body]
)

#let tip-box(body) = block(
  width: 100%, fill: rgb("#fffbeb"),
  stroke: 0.5pt + cm1, inset: (x: 12pt, y: 10pt), radius: 4pt,
  text(size: 13pt, fill: cm2)[#body]
)

#let warn-box(body) = block(
  width: 100%, fill: rgb("#fff1f2"),
  stroke: 0.5pt + rgb("#e11d48"), inset: (x: 12pt, y: 10pt), radius: 4pt,
  text(size: 13pt, fill: cm2)[#body]
)

#let info-box(body) = block(
  width: 100%, fill: rgb("#f0f9ff"),
  stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
  text(size: 13pt, fill: cm2)[#body]
)

// ════════════════════════════════════════════════════════════════════════════
// PORTADA
// ════════════════════════════════════════════════════════════════════════════
#cover(
  "Unidad I",
  "Análisis descriptivo",
  "Variables, muestras y estadísticos de resumen",
  "Análisis de Datos Cualitativos",
  "2026",
)

// ════════════════════════════════════════════════════════════════════════════
// ÍNDICE
// ════════════════════════════════════════════════════════════════════════════
#counter-display
#stitle("Unidad I", sub: "Contenidos")
#sstitle("Índice")
#slide[
  #set text(size: 17pt)
  #set par(leading: 1.1em)
  + Introducción y motivación
  + Datos, variables y observaciones
  + Tipos de variables
  + Muestra estadística y técnicas de muestreo
  + Estadísticos de tendencia central
  + Estadísticos de dispersión
  + Estadísticos de forma
  + Descripción gráfica
  + Teorización post hoc y data fishing
]

// ════════════════════════════════════════════════════════════════════════════
// 1. INTRODUCCIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Introducción", subtitle: "¿Qué es el análisis de datos?")

#pagebreak()
#counter-display
#stitle("Introducción")
#sstitle("¿Qué es el análisis de datos?")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      El *análisis de datos* es el proceso de explorar, limpiar,
      describir e interpretar información para
      *responder preguntas o generar conocimiento*.

      #v(10pt)
      #tip-box[
        En cualquier campo, el análisis de datos busca
        *transformar observaciones en comprensión*.
      ]
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        No basta con recolectar datos. \
        Es necesario organizarlos, resumirlos y analizarlos
        para extraer conclusiones válidas.
      ]
    ],
    [
      #styled-table(
        columns: (auto, 1fr),
        th[Etapa], th[¿Qué se hace?],
        td[Explorar],   tdg[Conocer los datos: tipos, rangos, valores faltantes.],
        td[Limpiar],    tdg[Corregir errores, eliminar duplicados, tratar outliers.],
        td[Describir],  tdg[Resumir con estadísticos y gráficos.],
        td[Interpretar],tdg[Extraer conclusiones y formular hipótesis.],
      )
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Introducción")
#sstitle("Dos enfoques complementarios")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Cuantitativo]
      #v(6pt)
      #text(size: 14pt)[
        Medir, comparar o predecir fenómenos mediante *variables numéricas*.
      ]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        *Datos típicos:* medidas experimentales, conteos, intensidades,
        expresión génica, concentraciones.
      ]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        *Ejemplos:*
        - Análisis de expresión diferencial (RNA-seq)
        - Modelos de crecimiento poblacional
        - Cuantificación de proteínas o metabolitos
      ]
    ],
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Cualitativo]
      #v(6pt)
      #text(size: 14pt)[
        Comprender patrones, funciones o significados a partir de
        *observaciones no numéricas*.
      ]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        *Datos típicos:* secuencias de ADN/proteínas, imágenes,
        anotaciones funcionales, fenotipos.
      ]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        *Ejemplos:*
        - Clasificación funcional de genes (Gene Ontology)
        - Análisis de patrones morfológicos
        - Codificación de observaciones de campo
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Introducción")
#sstitle("El análisis descriptivo")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        El *análisis descriptivo* es la *primera etapa* del análisis estadístico.
        Su objetivo no es probar hipótesis, sino *entender los datos*.
      ]

      #v(10pt)
      #tip-box[
        El análisis descriptivo nos da un *mapa inicial del territorio*,
        antes de aplicar modelos o pruebas estadísticas avanzadas.
      ]
      #v(10pt)
      #text(fill: gry, size: 14pt)[Preguntas que responde:]
      #v(4pt)
      #text(size: 15pt)[
        - ¿Qué variables existen y cómo se distribuyen?
        - ¿Qué valores son típicos o extremos?
        - ¿Existen patrones, relaciones o agrupamientos visibles?
      ]
    ],
    [
      #styled-table(
        columns: (auto, 1fr),
        th[Tipo], th[Herramientas],
        td[*Gráfica*],  tdg[Histogramas, scatter plots, boxplots, heatmaps.],
        td[*Numérica*], tdg[Media, mediana, varianza, desviación estándar.],
      )
      #v(14pt)
      #text(fill: gry, size: 14pt)[El análisis descriptivo está ligado al:]
      #v(6pt)
      #text(size: 15pt)[
        - *Análisis exploratorio (EDA):* detectar patrones y anomalías.
        - *Planteo de hipótesis:* formular preguntas a verificar.
        - *Diseño experimental:* orientar la recolección de datos futuros.
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 2. DATOS, VARIABLES Y OBSERVACIONES
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Datos y variables", subtitle: "Conceptos fundamentales · Dataset Iris")

#pagebreak()
#counter-display
#stitle("Datos y variables", sub: "Conceptos")
#sstitle("Población, muestra y observación")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #styled-table(
        columns: (auto, 1fr),
        th[Concepto], th[Definición],
        td[*Población*],
        tdg[Conjunto total de elementos sobre los que se quiere estudiar una característica. \ _Ej: todas las flores de una especie._],
        td[*Muestra*],
        tdg[Subconjunto de la población del cual se obtienen datos. \ _Ej: 150 flores medidas en el laboratorio._],
        td[*Observación*],
        tdg[Cada fila del conjunto de datos; una unidad individual. \ _Ej: una flor medida._],
        td[*Variable*],
        tdg[Característica medible de una observación. \ _Ej: largo del pétalo._],
      )
    ],
    [
      #tip-box[
        *Analogía de la tabla de datos:*

        Imaginá una planilla de Excel donde:
        - Cada *fila* es una observación (un individuo).
        - Cada *columna* es una variable (una característica medida).
        - Cada *celda* es el valor de esa variable para ese individuo.
      ]
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        Distinguir bien estos conceptos es esencial para elegir
        el análisis estadístico correcto.
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Datos y variables", sub: "Ejemplo")
#sstitle("El dataset Iris")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      El dataset *Iris* es uno de los más usados en estadística y aprendizaje
      automático. Contiene mediciones de flores de tres especies:

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - _Iris setosa_
        - _Iris versicolor_
        - _Iris virginica_
      ]
      #v(8pt)
      #code-box[
        ```python
        from sklearn import datasets

        iris = datasets.load_iris(as_frame=True)
        df = iris.frame
        df.head()
        ```
      ]
    ],
    [
      #styled-table(
        columns: (1fr, 1fr, auto),
        th[Variable], th[Descripción], th[Tipo],
        td[`sepal length`], tdg[Largo del sépalo (cm)],  td[Continua],
        td[`sepal width`],  tdg[Ancho del sépalo (cm)],  td[Continua],
        td[`petal length`], tdg[Largo del pétalo (cm)],  td[Continua],
        td[`petal width`],  tdg[Ancho del pétalo (cm)],  td[Continua],
        td[`target`],       tdg[Especie de la flor],      td[Categórica],
      )
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        150 observaciones · 4 variables continuas · 1 variable categórica · 3 clases (50 flores c/u)
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 3. TIPOS DE VARIABLES
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Tipos de variables", subtitle: "Categóricas · Nominales · Ordinales")

#pagebreak()
#counter-display
#stitle("Tipos de variables", sub: "Categóricas")
#sstitle("Variables categóricas")
#slide[
  Las *variables categóricas* representan atributos o categorías
  que no son numéricamente medibles, pero permiten clasificar elementos en grupos.

  #v(8pt)
  #styled-table(
    columns: (auto, 1fr, 1fr, 1fr),
    th[Tipo], th[Características], th[Ejemplos], th[Operaciones],
    td[*Nominal*],
    tdg[Las categorías *no tienen orden* lógico. Se usan para identificar o clasificar.],
    tdg[Especie (_setosa_, _versicolor_) \ Tipo de tejido (hígado, cerebro) \ Genotipo (AA, Aa, aa)],
    tdg[Igualdad / diferencia \ Conteo de frecuencias],
    td[*Ordinal*],
    tdg[Las categorías tienen *orden natural*, pero sin distancia cuantificable entre ellas.],
    tdg[Expresión génica (bajo, medio, alto) \ Severidad clínica (leve, moderada, severa) \ Estadios del desarrollo],
    tdg[Comparaciones de orden \ Mediana \ Estadísticos no paramétricos],
  )
]

#pagebreak()
#counter-display
#stitle("Tipos de variables", sub: "Nominal vs. Ordinal")
#sstitle("La diferencia clave: orden y distancia")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    block(stroke: 2pt + cm1, inset: 14pt, radius: 5pt)[
      #ssstitle[Variable Nominal]
      #v(8pt)
      Las categorías *no tienen orden ni distancia* entre ellas.

      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - "mamífero", "reptil", "ave" → no hay un orden lógico.
        - "mamífero − reptil" *no tiene sentido numérico*.
        - Solo se puede preguntar: ¿son *iguales o diferentes*?
      ]
      #v(6pt)
      #text(fill: cm2, size: 14pt)[
        *Ejemplos:* especie, tipo de sangre, genotipo, tejido.
      ]
    ],
    block(stroke: 2pt + cm3, inset: 14pt, radius: 5pt)[
      #ssstitle[Variable Ordinal]
      #v(8pt)
      Las categorías tienen *orden*, pero las distancias entre
      niveles no son iguales ni cuantificables.

      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - "leve < moderada < severa" → hay un orden claro.
        - Pero "moderada − leve" *no es igual* a "severa − moderada".
        - Se puede preguntar: ¿cuál es *mayor o menor*?
      ]
      #v(6pt)
      #text(fill: cm2, size: 14pt)[
        *Ejemplos:* grado de expresión, estadio tumoral, escala de dolor.
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Tipos de variables", sub: "Casos intermedios")
#sstitle("Cuando las categorías tienen estructura")
#slide[
  Aunque formalmente sean nominales, hay situaciones donde se puede definir
  una *noción de distancia* basada en conocimiento externo.

  #v(6pt)
  #styled-table(
    columns: (1fr, 1fr, 1fr),
    th[Caso], th[Métrica derivada], th[Ejemplo],
    td[*Relación filogenética*],
    tdg[Distancia evolutiva entre taxones],
    tdg[_Homo sapiens_ vs. _Pan troglodytes_],
    td[*Secuencias simbólicas*],
    tdg[Distancia de edición o similitud de secuencia],
    tdg[Comparar dos proteínas por identidad de secuencia],
    td[*Categorías espaciales*],
    tdg[Distancia geográfica o ambiental (km, gradiente)],
    tdg[Sitios de muestreo ecológico],
    td[*Función génica (GO terms)*],
    tdg[Distancia semántica en la ontología],
    tdg[Comparar funciones biológicas entre genes],
  )
  #v(6pt)
  #text(fill: gry, size: 13pt)[
    Esto habilita métodos como análisis de correspondencias, escalamiento
    multidimensional (MDS) o métodos de kernel.
  ]
]

// ════════════════════════════════════════════════════════════════════════════
// 4. MUESTRA ESTADÍSTICA Y TÉCNICAS DE MUESTREO
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "Muestreo", subtitle: "Muestra estadística · Técnicas")

#pagebreak()
#counter-display
#stitle("Muestreo", sub: "Conceptos")
#sstitle("¿Qué es una muestra estadística?")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      Una *muestra* es un subconjunto de datos extraído de una *población estadística*,
      obtenido mediante un proceso de muestreo definido.

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - Permite estudiar la población *sin observarla por completo*.
        - Cada observación representa una *unidad muestral*.
      ]
      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Tipo de muestra], th[Descripción],
        td[*Completa*],
        tdg[Incluye todos los casos de la población. Casi siempre imposible por costo o tiempo.],
        td[*Representativa*],
        tdg[Porción seleccionada aleatoriamente que refleja las características de la población.],
      )
    ],
    [
      #tip-box[
        *Para un buen muestreo la muestra debe:*
        - Ser elegida sin depender de propiedades individuales de las unidades.
        - Asegurar que *cada elemento tenga la misma probabilidad* de ser elegido.
        - Basarse en un proceso *aleatorio* para evitar sesgos.
      ]
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        Una muestra sesgada puede llevar a conclusiones incorrectas
        sobre la población, aunque el análisis estadístico sea impecable.
      ]
    ]
  )
]
#pagebreak()
#counter-display
#stitle("Muestreo", sub: "Conceptos")
#sstitle("Muestra presentativa vs sesgada")
#align(center)[
  #figure(image("images/muestra_representativa_vs_sesgada.png", width: 80%))
]

#pagebreak()
#counter-display
#stitle("Muestreo", sub: "Experimental vs. Computacional")
#sstitle("Dos sentidos del muestreo")
#slide[
  #styled-table(
    columns: (auto, 1fr, 1fr),
    th[Aspecto], th[Muestreo experimental], th[Muestreo en análisis de datos],
    td[*Momento*],
    tdg[Antes del análisis],
    tdg[Después de tener el dataset completo],
    td[*Propósito*],
    tdg[Obtener datos representativos del fenómeno real],
    tdg[Evaluar o entrenar modelos predictivos],
    td[*Control*],
    tdg[Sobre la recolección de datos],
    tdg[Sobre el uso y partición de datos],
    td[*Riesgo*],
    tdg[Sesgo de selección biológico o ambiental],
    tdg[Sobreajuste o validación inadecuada],
    td[*Ejemplo*],
    tdg[Elegir individuos de distintas poblaciones naturales],
    tdg[Separar datos en _train_, _validation_ y _test sets_],
  )
]

#pagebreak()
#counter-display
#stitle("Muestreo", sub: "Aleatorio simple")
#sstitle("Muestreo aleatorio simple (MAS)")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      El *MAS* es el método más básico:
      cada elemento de la población tiene la *misma probabilidad de ser seleccionado*.

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Tipo], th[Descripción],
        td[*Con reemplazo*],
        tdg[Una misma unidad puede seleccionarse varias veces. \ Útil cuando la población es pequeña.],
        td[*Sin reemplazo*],
        tdg[Una vez elegida, la unidad no puede repetirse. \ Más común en estudios reales.],
      )
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        Cuando la población es muy grande respecto a la muestra,
        ambos métodos dan resultados casi idénticos.
      ]
    ],
    [
      #align(center)[
        #figure(image("images/muestreo_aleatorio_simple.png", width: 100%))
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Muestreo", sub: "Sistemático")
#sstitle("Muestreo sistemático")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      El *muestreo sistemático* selecciona elementos a *intervalos regulares*
      dentro de una población ordenada.

      #v(6pt)
      #text(fill: gry, size: 14pt)[*Procedimiento:*]
      #v(4pt)
      #text(size: 15pt)[
        + *Ordenar* la población (por tiempo, tamaño, etc.)
        + *Elegir aleatoriamente* un punto de inicio dentro del primer intervalo.
        + *Seleccionar cada k-ésimo elemento* hasta completar la muestra.
      ]
      #v(6pt)
      #warn-box[
        *Precaución:* si la variable tiene *patrones periódicos*,
        el muestreo puede no capturar la variabilidad real. \
      ]
    ],
    [
      #align(center)[
        #figure(image("images/muestreo_sistematico.png", width: 100%))
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Muestreo", sub: "Estratificado")
#sstitle("Muestreo estratificado")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        El *muestreo estratificado* divide la población en *grupos homogéneos*
        (estratos) y extrae muestras dentro de cada uno.
      ]
      #v(2pt)
      #text(fill: gry, size: 14pt)[Cada estrato es *internamente homogéneo* y *diferente de los otros*.]

      #v(2pt)
      #text(fill: gry, size: 14pt)[*Procedimiento:*]
      #v(4pt)
      #text(size: 12pt)[
        + Dividir la población por una variable relevante (especie, grupo etario, sexo).
        + Aplicar MAS o sistemático *dentro de cada estrato*.
        + Combinar los resultados.
      ]
      #v(2pt)
      #tip-box[
        En el dataset Iris: los tres estratos son las tres especies,
        con 50 flores cada una → asignación *uniforme*.
      ]
    ],
    [
      #styled-table(
        columns: (auto, 1fr),
        th[Tipo de asignación], th[Criterio],
        td[*Proporcional*],
        tdg[Muestra en cada estrato proporcional al tamaño del estrato. Preserva las proporciones reales.],
        td[*Óptima*],
        tdg[Proporcional a la variabilidad interna del estrato (σ). Más eficiente estadísticamente.],
        td[*Uniforme*],
        tdg[Igual número de casos por estrato. Facilita comparaciones entre grupos.],
      )
      #v(8pt)
      #text(fill: gry, size: 13pt)[
        La asignación óptima favorece los estratos más variables,
        reduciendo el error estándar del estimador global.
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Muestreo", sub: "Estratificado")
#sstitle("Muestreo estratificado")
#align(center)[
  #figure(image("images/muestreo_estratificado.png", width: 65%))
]

// ════════════════════════════════════════════════════════════════════════════
// 5. ESTADÍSTICOS DE TENDENCIA CENTRAL
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Tendencia central", subtitle: "Media · Mediana · Moda")

#pagebreak()
#counter-display
#stitle("Estadísticos de resumen", sub: "Tipos")
#sstitle("Estadísticos de resumen")
#slide[
  Los *estadísticos de resumen* permiten describir cuantitativamente
  cómo se distribuyen los datos de una muestra.

  #v(8pt)
  #styled-table(
    columns: (auto, 1fr, 1fr),
    th[Tipo], th[¿Qué mide?], th[Ejemplos],
    td[*Tendencia central*],
    tdg[Valor típico o representativo de la distribución],
    tdg[Media, mediana, moda],
    td[*Dispersión*],
    tdg[Cuánto se alejan los datos entre sí],
    tdg[Varianza, desviación estándar, IQR, MAD],
    td[*Forma*],
    tdg[La estructura de la distribución],
    tdg[Asimetría (skewness), apuntamiento (kurtosis)],
  )
  #v(10pt)
  #info-box[
    *Concepto clave:* \
    Distribución = *Tendencia central* + *Dispersión* + *Forma*
  ]
]
#pagebreak()
#counter-display
#stitle("Estadísticos de resumen", sub: "Tipos")
#sstitle("Estadísticos de resumen")
#align(center)[
  #figure(image("images/media_mediana_moda.png", height: 75%))
]

#pagebreak()
#counter-display
#stitle("Tendencia central", sub: "Media")
#sstitle("Media aritmética")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        La *media* es el promedio aritmético. Suma todos los valores
        y los divide por la cantidad de observaciones.
      ]

      $ overline(X) = frac(1, N) sum_(i=1)^N x_i $

      #v(2pt)
      #text(fill: gry, size: 14pt)[
        - Es el estimador de máxima verosimilitud de $mu$ bajo normalidad.
        - *No es robusta*: un valor extremo (outlier) la desplaza significativamente.
      ]
      #v(2pt)
      #warn-box[
        *Ejemplo:* los salarios de 9 empleados (\$50.000) y el CEO (\$1.000.000). \
        La media sería $~$145.000 — un valor que no representa a nadie.
      ]
    ],
    [
      #code-box[
        ```python
        import pandas as pd

        data = {
          "altura_cm": [170,165,180,175,172,
                        168,185,177,176,180],
          "peso_kg":   [70, 65, 80, 75, 72,
                        68, 85, 77, 76, 82],
        }
        df = pd.DataFrame(data)

        # Media
        media = df.mean(numeric_only=True)
        # altura_cm → 174.8
        # peso_kg   → 75.0
        ```
      ]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        `df.mean()` calcula la media de cada columna numérica.
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Tendencia central", sub: "Mediana y Moda")
#sstitle("Mediana y moda")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Mediana]
      #v(6pt)
      Valor ubicado en el *percentil 50*: el que divide la muestra en dos mitades iguales.

      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - Es un estimador *robusto*: los outliers no la afectan.
        - Puede calcularse en datos categóricos *ordinales*.
        - Si N es par, es el promedio de los dos valores centrales.
      ]
      #v(6pt)
      #code-box[
        ```python
        mediana = df.median(numeric_only=True)
        # altura_cm → 175.5
        ```
      ]
      #v(6pt)
      #tip-box[
        Cuando la media y la mediana difieren mucho,
        hay probable *asimetría* o *outliers* en los datos.
      ]
    ],
    [
      #ssstitle[Moda]
      #v(6pt)
      El valor *más frecuente* en el conjunto de datos.

      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - Es el *único* estadístico de tendencia central válido
          para variables *nominales*.
        - Difícil de estimar para variables *continuas*
          (depende de cómo se agrupen los datos).
        - Una distribución puede tener *múltiples modas*.
      ]
      #v(6pt)
      #code-box[
        ```python
        moda = df.mode(numeric_only=True).iloc[0]
        # Devuelve la primera moda si hay varias
        ```
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Tendencia central", sub: "Robustez")
#sstitle("Robustez: el efecto de los outliers")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      Un estadístico es *robusto* si *no se ve fuertemente afectado*
      por valores atípicos o distribuciones irregulares.

      #v(8pt)
      #styled-table(
        columns: (auto, auto, auto),
        th[Estadístico], th[Robusto], th[Cuándo usarlo],
        td[Media],   td[No], tdg[Datos normales, sin outliers extremos],
        td[Mediana], td[Sí], tdg[Datos asimétricos o con valores extremos],
        td[Moda],    td[Sí], tdg[Variables nominales o datos muy discretos],
      )
    ],
    [
      #ssstitle[Ejemplo con outlier]
      #v(4pt)
      #code-box[
        ```python
        alturas = [170, 165, 180, 175, 172,
                   168, 185, 177, 176, 300]
        # ↑ 300 cm: valor atípico (error de medición)

        import numpy as np
        media   = np.mean(alturas)    # → 186.8 ← afectada
        mediana = np.median(alturas)  # → 175.5 ← estable

        print(f"Media:   {media:.1f}")
        print(f"Mediana: {mediana:.1f}")
        ```
      ]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        La mediana no se desplaza ante el outlier de 300 cm;
        la media sube más de 10 cm por ese único valor.
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 6. ESTADÍSTICOS DE DISPERSIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("6", "Dispersión", subtitle: "Varianza · IQR · MAD · Rango")

#pagebreak()
#counter-display
#stitle("Dispersión", sub: "Medidas")
#sstitle("Estadísticos de dispersión")
#slide[
  Los estadísticos de dispersión cuantifican *cuánto varían los datos*
  respecto a su valor central.

  #v(6pt)
  #styled-table(
    columns: (auto, 1fr, auto),
    th[Estadístico], th[Definición], th[Robustez],
    td[*Desv. estándar (s)*],
    tdg[$s = sqrt(frac(sum_(i=1)^N (x_i - overline(x))^2, N-1))$ — variabilidad promedio respecto a la media.],
    td[No robusto],
    td[*Varianza (s²)*],
    tdg[Cuadrado de la desviación estándar. Amplifica el efecto de los outliers.],
    td[No robusto],
    td[*IQR*],
    tdg[$Q_3 - Q_1$ — amplitud del 50% central de los datos.],
    td[Robusto],
    td[*MAD*],
    tdg[$"mediana"(|X_i - "mediana"(X)|)$ — dispersión basada en la mediana.],
    td[Muy robusto],
    td[*Rango total*],
    tdg[$max(X) - min(X)$ — diferencia entre extremos.],
    td[Muy sensible],
  )
]

#pagebreak()
#counter-display
#stitle("Dispersión", sub: "Ejemplo")
#sstitle("Comparar medidas de dispersión")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #code-box[
        ```python
        import pandas as pd

        # Datos con un outlier
        alturas = [170, 165, 180, 175, 172,
                   168, 185, 177, 176, 300]
        df = pd.DataFrame({"altura_cm": alturas})

        std = df["altura_cm"].std()

        q3  = df["altura_cm"].quantile(0.75)
        q1  = df["altura_cm"].quantile(0.25)
        iqr = q3 - q1

        mad = (
          df["altura_cm"]
          - df["altura_cm"].median()
        ).abs().median()

        rango = df["altura_cm"].max() \
              - df["altura_cm"].min()
        ```
      ]
    ],
    [
      #ssstitle[Resultados]
      #v(6pt)
      #styled-table(
        columns: (1fr, auto, 1fr),
        th[Estadístico], th[Valor], th[Observación],
        td[Desv. estándar], td[41.0], tdg[Inflada por el outlier de 300 cm],
        td[IQR],            td[9.25], tdg[No se ve afectado],
        td[MAD],            td[5.0],  tdg[Muy estable],
        td[Rango total],    td[135],  tdg[Completamente dominado por el outlier],
      )
      #v(8pt)
      #tip-box[
        *Regla práctica:* usar *IQR* o *MAD* cuando los datos
        son asimétricos o contienen valores extremos. \
        Usar *desviación estándar* cuando los datos son normales.
      ]
    ]
  )
]
#pagebreak()
#counter-display
#stitle("Dispersión", sub: "Ejemplo")
#sstitle("Comparar medidas de dispersión")
#align(center)[
  #figure(image("images/dispersion_measures.png", width: 60%))
]

// ════════════════════════════════════════════════════════════════════════════
// 7. ESTADÍSTICOS DE FORMA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("7", "Forma", subtitle: "Asimetría · Curtosis")

#pagebreak()
#counter-display
#stitle("Forma", sub: "Asimetría")
#sstitle("Skewness — asimetría de la distribución")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      La *asimetría (skewness)* mide el grado de simetría de la distribución
      respecto a la media.

      $ "Skewness" = frac(1, N) sum_(i=1)^N lr((frac(x_i - overline(x), s)))^3 $

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr, 1fr),
        th[Tipo], th[Descripción], th[Ejemplo],
        td[*Simétrica*],
        tdg[Datos iguales a ambos lados],
        tdg[Media ≈ Mediana \ distribución normal],
        td[*Skew > 0*],
        tdg[Cola más larga a la *derecha*],
        tdg[Ingresos, \ tamaños poblacionales],
        td[*Skew < 0*],
        tdg[Cola más larga a la *izquierda*],
        tdg[Edad al morir \ en poblaciones jóvenes],
      )
    ],
    [
      #align(center)[
        #figure(image("images/skewness.png", width: 60%))
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Forma", sub: "Curtosis")
#sstitle("Kurtosis — forma del pico y peso de las colas")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        La *curtosis (kurtosis)* mide la concentración de datos alrededor
        de la media y la *pesadez de las colas*.
      ]

      $ "Kurtosis" = frac(1, N) sum_(i=1)^N lr((frac(x_i - overline(x), s)))^4 $

      #v(2pt)
      #text(fill: gry, size: 12pt)[
        Se suele reportar el *exceso de curtosis* (respecto a la normal):
        $ K_"exceso" = "Kurtosis" - 3 $
      ]
      #v(6pt)
      #styled-table(
        columns: (auto, auto, 1fr),
        th[Tipo], th[Exceso], th[Características],
        td[*Mesocúrtica*],  td[≈ 0], tdg[Similar a la distribución normal],
        td[*Leptocúrtica*], td[> 0], tdg[Colas pesadas, más valores extremos],
        td[*Platicúrtica*], td[< 0], tdg[Colas ligeras, más valores en el centro],
      )
    ],
    [
      #align(center)[
        #figure(image("images/kurtosis.png", width: 60%))
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 8. DESCRIPCIÓN GRÁFICA
// ════════════════════════════════════════════════════════════════════════════
#section-divider("8", "Descripción gráfica", subtitle: "Histograma · KDE · Boxplot · Scatter · ECDF")

#pagebreak()
#counter-display
#stitle("Descripción gráfica", sub: "Histograma")
#sstitle("Histograma")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        El *histograma* muestra la *distribución de frecuencias* de una variable
        numérica dividiéndola en intervalos (*bins*).
      ]

      #v(6pt)
      #text(fill: gry, size: 14pt)[*Cómo se construye:*]
      #v(4pt)
      #text(size: 15pt)[
        + Dividir el rango en intervalos contiguos.
        + Contar cuántas observaciones caen en cada bin.
        + Dibujar una barra cuya altura es esa frecuencia.
      ]
      #v(6pt)
      #text(fill: gry, size: 14pt)[*¿Qué permite ver?*]
      #v(4pt)
      #text(size: 15pt)[
        - Forma de la distribución (simétrica, sesgada, bimodal)
        - Dispersión y tendencia central
        - Presencia de valores atípicos
      ]
    ],
    [
      #align(center)[
        #figure(image("images/histograma.png", width: 100%))
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Descripción gráfica", sub: "KDE")
#sstitle("KDE — Estimador de densidad por núcleo")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        El *KDE* genera una *curva continua y suave* que aproxima la función
        de densidad de probabilidad de la muestra, sin depender del tamaño de los bins.
      ]

      #v(6pt)
      $ hat(f)(x) = frac(1, n h) sum_(i=1)^n K lr((frac(x - x_i, h))) $

      #v(4pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Parámetro], th[Efecto],
        td[*Kernel (K)*],  tdg[Forma local de suavizado (gauss., epanechnikov...)],
        td[*Bandwidth (h)*], tdg[Si h es pequeño → sigue el ruido. \ Si h es grande → se pierde detalle.],
      )
    ],
    [
      #align(center)[
        #figure(image("images/kde.png", width: 60%))
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Descripción gráfica", sub: "Barplot")
#sstitle("Gráfico de barras (Barplot)")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      El *barplot* compara *categorías o grupos* mediante la altura de las barras.
      Cada barra representa el valor promedio, suma o frecuencia de una categoría.

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Variante], th[Cuándo usar],
        td[*Simple*],   tdg[Una variable categórica vs. un valor numérico.],
        td[*Agrupado*], tdg[Comparar subcategorías dentro de cada grupo.],
        td[*Apilado*],  tdg[Mostrar la composición de cada categoría.],
      )
      #v(8pt)
      #tip-box[
        A diferencia del histograma, el barplot se usa para
        *variables categóricas*, no continuas.
      ]
    ],
    [
      #align(center)[
        #figure(image("images/barplot.png", width: 100%))
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Descripción gráfica", sub: "Scatter")
#sstitle("Diagrama de dispersión (Scatter plot)")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      El *scatter plot* representa la *relación entre dos variables cuantitativas*.
      Cada punto corresponde a una observación.

      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - Posición horizontal (x): primera variable.
        - Posición vertical (y): segunda variable.
      ]
      #v(6pt)
      #text(fill: gry, size: 14pt)[*¿Qué permite ver?*]
      #v(4pt)
      #text(size: 15pt)[
        - La *distribución conjunta* de dos variables.
        - Patrones, *correlaciones* o agrupamientos.
        - Posibles *outliers* o relaciones no lineales.
      ]
      #v(6pt)
      #tip-box[
        Se puede añadir una *tercera dimensión* usando el color, el tamaño
        o la forma del marcador.
      ]
    ],
    [
      #align(center)[
        #figure(image("images/scatter_plot.png", width: 100%))
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Descripción gráfica", sub: "Scatter matrix")
#sstitle("Matriz de dispersión")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
      La *scatter matrix* es una colección de diagramas de dispersión
      entre *todos los pares de variables numéricas*.
      ]

      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - Cada celda → scatter plot entre un par de variables.
        - La diagonal → distribución univariada
        - Permite explorar *relaciones multivariadas*.
      ]
      #v(2pt)
      #code-box[
        ```python
        import pandas as pd
        from sklearn import datasets
        import matplotlib.pyplot as plt
        df = datasets.load_iris(as_frame=True).frame
        pd.plotting.scatter_matrix(
            df.drop(columns="target"), figsize=(8, 8),
            diagonal="kde", alpha=0.5
        )
        plt.suptitle("Scatter matrix — dataset Iris")
        plt.show()
        ```
      ]
    ],
    [
      #align(center)[
        #figure(image("images/scatter_matrix.png", width: 90%))
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Descripción gráfica", sub: "Histograma 2D y Heatmap")
#sstitle("Histograma bivariado y mapa de calor")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Histograma bivariado]
      #v(4pt)
      #text(size: 14pt)[
        Extiende el histograma a *dos variables numéricas*.
        La intensidad del color indica la frecuencia conjunta.
      ]
      #v(4pt)
      #align(center)[
        #figure(image("images/histograma_bivariado.png", width: 75%))
      ]
    ],
    [
      #ssstitle[Mapa de calor (Heatmap)]
      #v(4pt)
      #text(size: 14pt)[
        Representa valores numéricos en una rejilla 2D
        usando colores. Ideal para *matrices de correlación*.
      ]
      #v(4pt)
      #align(center)[
        #figure(image("images/heatmap.png", width: 75%))
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Descripción gráfica", sub: "Boxplot")
#sstitle("Diagrama de caja (Boxplot)")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      El *boxplot* resume la distribución de una variable numérica
      mostrando su tendencia central, dispersión y valores atípicos.

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Componente], th[Qué representa],
        td[*Caja (box)*],    tdg[Rango intercuartílico IQR = Q3 − Q1. Contiene el 50% central de los datos.],
        td[*Línea central*], tdg[Mediana (percentil 50).],
        td[*Whiskers*],      tdg[Se extienden hasta $Q_1 - 1.5 times "IQR"$ y $Q_3 + 1.5 times "IQR"$.],
        td[*Puntos*],        tdg[Valores fuera del rango de los whiskers: *outliers*.],
      )
    ],
    [
      #align(center)[
        #figure(image("images/boxplot.png", width: 100%))
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Descripción gráfica", sub: "ECDF")
#sstitle("Función empírica de distribución acumulada")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      La *ECDF* muestra la *proporción acumulada de observaciones*
      menores o iguales a un valor dado.

      $ F_n(x_i) = frac("observaciones" <= x_i, n) $

      #v(6pt)
      #text(fill: gry, size: 14pt)[
        - Función *no decreciente*, valores entre 0 y 1.
        - No asume ningún modelo probabilístico.
        - Permite comparar distribuciones entre grupos.
        - Útil para identificar asimetrías o colas largas.
      ]
      #v(6pt)
      #tip-box[
        La ECDF es la versión empírica (observada) de la CDF teórica.
        Si la distribución fuera exactamente normal, la ECDF
        seguiría de cerca una sigmoide.
      ]
    ],
    [
      #align(center)[
        #figure(image("images/ecdf.png", width: 100%))
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Descripción gráfica", sub: "Resumen")
#sstitle("¿Qué gráfico usar según la situación?")
#slide[
  #styled-table(
    columns: (auto, 1fr, 1fr),
    th[Gráfico], th[Cuándo usarlo], th[Ejemplo de uso],
    td[*Histograma*],
    tdg[Distribución de una variable continua],
    tdg[Distribución de alturas en una población],
    td[*KDE*],
    tdg[Versión suavizada del histograma, sin bins fijos],
    tdg[Comparar distribuciones superpuestas],
    td[*Barplot*],
    tdg[Comparar valores entre categorías],
    tdg[Media de expresión génica por tejido],
    td[*Scatter plot*],
    tdg[Relación entre dos variables numéricas],
    tdg[Edad vs. presión arterial],
    td[*Scatter matrix*],
    tdg[Relaciones entre múltiples variables a la vez],
    tdg[Explorar el dataset Iris completo],
    td[*Heatmap*],
    tdg[Matriz de correlaciones o valores agregados],
    tdg[Correlación entre variables biométricas],
    td[*Boxplot*],
    tdg[Comparar distribuciones entre grupos],
    tdg[Expresión génica en tres condiciones],
    td[*ECDF*],
    tdg[Distribución acumulada sin supuestos],
    tdg[Comparar dos tratamientos],
  )
]

// ════════════════════════════════════════════════════════════════════════════
// 9. TEORIZACIÓN POST HOC Y DATA FISHING
// ════════════════════════════════════════════════════════════════════════════
#section-divider("9", "Post hoc y data fishing", subtitle: "Sesgos en el análisis exploratorio")

#pagebreak()
#counter-display
#stitle("Sesgos en el análisis", sub: "Post hoc")
#sstitle("Teorización post hoc")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      La *teorización post hoc* ocurre cuando se *formulan hipótesis después de
      analizar los datos*, en lugar de antes.

      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Las conclusiones pueden parecer significativas,
        pero en realidad *solo reflejan patrones accidentales*
        presentes en el conjunto de datos utilizado.
      ]
      #v(8pt)
      #warn-box[
        Las hipótesis generadas en el análisis exploratorio
        *deben validarse de manera independiente* para garantizar su solidez.
      ]
    ],
    [
      #ssstitle[Riesgos principales]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Riesgo], th[Descripción],
        td[*Sesgo de confirmación*],
        tdg[Aceptar hipótesis que solo son válidas para el conjunto analizado.],
        td[*Sobreajuste*],
        tdg[El modelo se adapta al ruido en lugar de a la señal real.],
        td[*Falsa significación*],
        tdg[Los resultados no se replican en nuevos datos o experimentos.],
      )
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Sesgos en el análisis", sub: "Data fishing")
#sstitle("Data fishing y P-hacking")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      El *data fishing* (o *P-hacking*) es la práctica de
      *probar muchas hipótesis o combinaciones de variables*
      hasta encontrar alguna que resulte "significativa".

      #v(8pt)
      #warn-box[
        Cuantas más hipótesis se prueban sobre los mismos datos,
        mayor es la probabilidad de encontrar un resultado significativo
        *por azar* — aunque no haya efecto real.
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        *Ejemplo en bioinformática:* analizar todos los genes de una base
        de datos y reportar solo los que muestran asociación, sin corrección
        por tests múltiples.
      ]
    ],
    [
      #ssstitle[Estrategias para evitar el sesgo]
      #v(6pt)
      #text(size: 15pt)[
        - *Formular hipótesis antes* de explorar los datos.
        - *Separar los datos* en conjuntos de exploración y validación.
        - *Cross-validation:* evaluar el desempeño en distintas particiones.
        - *Corrección por tests múltiples:* Bonferroni, FDR (False Discovery Rate).
        - *Recolección adicional de datos* para verificar los hallazgos.
      ]
      #v(8pt)
      #tip-box[
        El análisis exploratorio es *legítimo y necesario*, pero las
        hipótesis que genera deben considerarse *preliminares*,
        no confirmadas.
      ]
    ]
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
    Unidad I — Análisis descriptivo
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
