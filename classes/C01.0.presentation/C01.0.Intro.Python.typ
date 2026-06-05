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

#let info-box(body) = block(
  width: 100%, fill: rgb("#f0f9ff"),
  stroke: 0.5pt + cm3, inset: (x: 12pt, y: 10pt), radius: 4pt,
  text(size: 13pt, fill: cm2)[#body]
)

// ════════════════════════════════════════════════════════════════════════════
// PORTADA
// ════════════════════════════════════════════════════════════════════════════
#cover(
  "Introducción",
  "a Python",
  "Variables, estructuras, funciones y librerías científicas",
  "Análisis de Datos Cualitativos",
  "2026",
)

// ════════════════════════════════════════════════════════════════════════════
// CONTENIDOS
// ════════════════════════════════════════════════════════════════════════════
#counter-display
#stitle("Introducción a Python", sub: "Contenidos")
#sstitle("Índice")
#slide[
  #set text(size: 17pt)
  #set par(leading: 1.1em)
  + Variables y tipos de datos
  + Estructuras de datos: listas, diccionarios, sets y tuplas
  + Loops y condicionales
  + Funciones y funciones anónimas
  + Clases y objetos
  + Anotaciones de tipos
  + Comprensión de listas, sets y diccionarios
  + `map`, `filter` y `reduce` · Piping
  + NumPy · Pandas · Matplotlib · SciPy · SymPy
]

// ════════════════════════════════════════════════════════════════════════════
// ¿QUÉ ES PYTHON?
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#counter-display
#stitle("Introducción a Python")
#sstitle("¿Qué es Python?")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      Python es un *lenguaje de programación* de propósito general,
      diseñado para ser *fácil de leer y escribir*.

      #v(10pt)
      #text(fill: gry, size: 14pt)[¿Para qué se usa en ciencia de datos?]
      #v(6pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Tarea], th[Herramienta],
        td[Manipular tablas de datos], tdg[Pandas],
        td[Cálculo numérico],          tdg[NumPy],
        td[Gráficos],                  tdg[Matplotlib],
        td[Estadística],               tdg[SciPy],
        td[Machine learning],          tdg[scikit-learn],
      )
    ],
    [
      #tip-box[
        *Analogía:* Python es como un idioma. \
        Las *variables* son sustantivos (guardan cosas). \
        Las *funciones* son verbos (hacen cosas). \
        Las *estructuras de datos* son recipientes (organizan cosas).
      ]
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        Un programa de Python es una *secuencia de instrucciones*
        que la computadora ejecuta de arriba hacia abajo,
        una por vez.
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// INDENTACIÓN
// ════════════════════════════════════════════════════════════════════════════
#pagebreak()
#counter-display
#stitle("Introducción a Python")
#sstitle("Indentación — la regla más importante")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      En la mayoría de los lenguajes, los bloques de código se delimitan
      con llaves `{}`. En Python se delimitan con *espacios al inicio de la línea*
      (indentación). Esto no es opcional: es parte de la *sintaxis*.

      #v(8pt)
      #tip-box[
        *Regla:* todo lo que pertenece a un bloque (el cuerpo de un `if`,
        un `for`, una función) debe estar desplazado hacia la derecha
        exactamente la *misma cantidad de espacios* — convencionalmente *4 espacios*.
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Si la indentación es inconsistente, Python lanza un error
        `IndentationError` y el programa no se ejecuta.
      ]
    ],
    [
      #ssstitle[✓ Correcto]
      #v(4pt)
      #code-box[
        ```python
        temperatura = 38.2

        if temperatura > 37.5:
            print("Hay fiebre")   # 4 espacios
            print("Consultar")    # mismo nivel → mismo bloque

        print("Fin del programa") # sin sangría → fuera del if
        ```
      ]
      #v(8pt)
      #ssstitle[✗ Incorrecto — IndentationError]
      #v(4pt)
      #block(
        width: 100%, fill: rgb("#fff1f2"),
        stroke: 0.5pt + rgb("#e11d48"), inset: (x: 12pt, y: 8pt), radius: 4pt,
        text(size: 13pt)[
          ```python
          if temperatura > 37.5:
          print("Hay fiebre")    # ← falta indentación
            print("Consultar")  # ← indentación distinta
          ```
        ]
      )
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Introducción a Python")
#sstitle("Indentación — bloques anidados")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
      Los bloques pueden *anidarse*: cada nivel agrega 4 espacios más.
      La indentación hace visible la *estructura lógica* del programa.
      ]
      #v(2pt)
      #code-box[
        ```python
        pacientes = ["Ana", "Carlos", "Beatriz"]
        notas = [8.5, 4.0, 9.2]

        for i in range(len(pacientes)):        # nivel 1
            nombre = pacientes[i]
            nota   = notas[i]
            if nota >= 6:                      # nivel 2
                print(f"{nombre}: aprobó")
            else:                              # nivel 2
                print(f"{nombre}: desaprobó")
                if nota < 3:                   # nivel 3
                    print("  → recuperatorio")

        print("Fin de las notas")              # nivel 0
        ```
      ]
    ],
    [
      #ssstitle[¿Qué pertenece a qué bloque?]
      #v(4pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Nivel], th[Pertenece a],
        td[0 espacios], tdg[El programa principal (siempre se ejecuta)],
        td[4 espacios],  tdg[El cuerpo del `for` (una vez por paciente)],
        td[8 espacios],  tdg[El cuerpo del `if` o `else`],
        td[12 espacios], tdg[El `if` anidado dentro del `else`],
      )
      #v(8pt)
      #tip-box[
        *Consejo:* si el código tiene muchos niveles de anidación
        (más de 3 o 4), suele ser señal de que conviene dividirlo
        en funciones más pequeñas.
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// VARIABLES Y TIPOS DE DATOS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("1", "Variables", subtitle: "Guardar y nombrar valores")

#pagebreak()
#counter-display
#stitle("Python", sub: "Variables")
#sstitle("¿Qué es una variable?")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      Una *variable* es una caja con etiqueta:
      la etiqueta es el *nombre*, el contenido es el *valor*.

      #v(10pt)
      #code-box[
        ```python
        # Crear (asignar) una variable
        nombre = "María"
        edad   = 32
        altura = 1.68
        es_estudiante = True

        # Usar una variable
        print(nombre)    # → María
        print(edad + 1)  # → 33
        ```
      ]
    ],
    [
      #tip-box[
        *Reglas para los nombres:*
        - Solo letras, números y `_`
        - No pueden empezar con un número
        - No usar palabras reservadas \
          (`for`, `if`, `class`, `return`...)
        - Python distingue mayúsculas: \
          `Edad` y `edad` son variables distintas
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        El signo `=` *no* significa "igual" matemático.
        Significa *"guardar el valor de la derecha en la variable de la izquierda"*.
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Python", sub: "Variables")
#sstitle("Tipos de datos básicos")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #styled-table(
        columns: (auto, 1fr, 1fr),
        th[Tipo], th[¿Qué representa?], th[Ejemplos],
        td[`int`],
        tdg[Número entero (sin decimales)],
        td[`5`, `-10`, `1000`],
        td[`float`],
        tdg[Número con decimales],
        td[`3.14`, `-0.5`, `1.0`],
        td[`str`],
        tdg[Texto (cadena de caracteres)],
        td[`"hola"`, `"1234"`],
        td[`bool`],
        tdg[Verdadero o falso],
        td[`True`, `False`],
      )
      #v(8pt)
      #code-box[
        ```python
        # Verificar el tipo de una variable
        type(42)      # → <class 'int'>
        type(3.14)    # → <class 'float'>
        type("hola")  # → <class 'str'>
        type(True)    # → <class 'bool'>
        ```
      ]
    ],
    [
      #ssstitle[Operaciones según tipo]
      #v(6pt)
      #code-box[
        ```python
        # Números: operaciones aritméticas
        10 + 3    # → 13   (suma)
        10 - 3    # → 7    (resta)
        10 * 3    # → 30   (multiplicación)
        10 / 3    # → 3.33 (división)
        10 // 3   # → 3    (división entera)
        10 % 3    # → 1    (resto)
        2 ** 8    # → 256  (potencia)

        # Texto: concatenación y repetición
        "Ana" + " " + "García"  # → "Ana García"
        "ha" * 3                 # → "hahaha"

        # Comparaciones (devuelven bool)
        5 > 3     # → True
        5 == 5    # → True
        5 != 3    # → True
        ```
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Python", sub: "Variables")
#sstitle("Trabajar con texto (str)")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Operaciones útiles con strings]
      #v(6pt)
      #code-box[
        ```python
        nombre = "ana garcía"

        nombre.upper()       # → "ANA GARCÍA"
        nombre.capitalize()  # → "Ana garcía"
        nombre.replace("a", "A")  # → "AnA gArcíA"
        nombre.split(" ")    # → ["ana", "garcía"]
        len(nombre)          # → 10

        # Verificar contenido
        "garcía" in nombre   # → True
        nombre.startswith("ana")  # → True
        ```
      ]
    ],
    [
      #ssstitle[Formatear texto con f-strings]
      #v(6pt)
      #code-box[
        ```python
        especie = "Homo sapiens"
        n_genes = 20000
        pct_codif = 1.5
        # f-string: insertar variables dentro de texto
        mensaje = (
          f"La especie {especie} tiene "
          f"aproximadamente {n_genes} genes, "
          f"que codifican el {pct_codif}% "
          f"del genoma."
        )
        print(mensaje)
        # La especie Homo sapiens tiene
        # aproximadamente 20000 genes,
        # que codifican el 1.5% del genoma.
        ```
      ]
      #v(2pt)
      #text(fill: gry, size: 13pt)[
        La `f` antes de la comilla activa el formato.
        Todo lo que esté entre `{}` se reemplaza por el valor de la variable.
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// ESTRUCTURAS DE DATOS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("2", "Estructuras de datos", subtitle: "Listas · Diccionarios · Sets · Tuplas")

#pagebreak()
#counter-display
#stitle("Python", sub: "Estructuras de datos")
#sstitle("Listas — colecciones ordenadas")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        Una *lista* es como una fila de cajones numerados.
        Cada uno tiene un número (índice) que empieza en *0*.
      ]

      #v(8pt)
      #code-box[
        ```python
        pacientes = ["Ana", "Carlos", "Beatriz", "Diego"]

        # Acceder por índice
        pacientes[0]    # → "Ana"    (primero)
        pacientes[-1]   # → "Diego"  (último)
        pacientes[1:3]  # → ["Carlos", "Beatriz"]

        # Modificar
        pacientes.append("Elena")   # agrega al final
        pacientes.remove("Carlos")  # elimina por valor
        pacientes.insert(1, "Fede") # inserta en posición

        # Información
        len(pacientes)              # → cantidad de elementos
        "Ana" in pacientes          # → True
        ```
      ]
    ],
    [
      #ssstitle[¿Por qué usar listas?]
      #v(2pt)
      #tip-box[
        Cuando tenés *muchos valores del mismo tipo* y el *orden importa*:
        - Secuencia de mediciones
        - Lista de nombres de pacientes
        - Resultados de un experimento
      ]
      #ssstitle[Iterar una lista]
      #v(4pt)
      #code-box[
        ```python
        temperaturas = [36.5, 37.1, 38.2, 36.8]

        for temp in temperaturas:
            if temp > 37.5:
                print(f"{temp} °C — fiebre")
            else:
                print(f"{temp} °C — normal")
        ```
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Python", sub: "Estructuras de datos")
#sstitle("Diccionarios — clave y valor")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
      Un *diccionario* es como una agenda: buscás por *nombre* (clave)
      y encontrás el *dato* (valor).
      ]

      #code-box[
        ```python
        paciente = {
            "nombre":    "Ana Pérez",
            "edad":      34,
            "diagnóstico": "hipertensión",
            "peso_kg":   68.5,
        }

        # Acceder
        paciente["nombre"]          # → "Ana Pérez"
        paciente.get("altura", 0)   # → 0 (no existe)

        # Agregar o modificar
        paciente["altura_cm"] = 162

        # Recorrer
        for clave, valor in paciente.items():
            print(f"{clave}: {valor}")
        ```
      ]
    ],
    [
      #ssstitle[Lista vs. Diccionario]
      #v(6pt)
      #styled-table(
        columns: (1fr, 1fr),
        th[Lista], th[Diccionario],
        tdg[Acceso por posición numérica], tdg[Acceso por nombre (clave)],
        tdg[El orden es parte del significado], tdg[El orden no importa para buscar],
        tdg[`mis_datos[0]`], tdg[`mis_datos["nombre"]`],
      )
      #v(10pt)
      #tip-box[
        *Regla práctica:* si querés acceder a los datos por *nombre* o *etiqueta*,
        usá un diccionario. Si lo que importa es el *orden* o la *posición*, usá una lista.
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Python", sub: "Estructuras de datos")
#sstitle("Sets y Tuplas")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Set — conjunto sin repetidos]
      #v(4pt)
      #code-box[
        ```python
        # Eliminar duplicados de una lista
        mediciones = [1, 3, 2, 3, 1, 4, 2]
        unicos = set(mediciones)   # → {1, 2, 3, 4}

        # Operaciones de conjuntos
        grupo_a = {"Ana", "Carlos", "Beatriz"}
        grupo_b = {"Carlos", "Diego", "Ana"}

        grupo_a & grupo_b   # intersección → {"Ana", "Carlos"}
        grupo_a | grupo_b   # unión → todos
        grupo_a - grupo_b   # diferencia → {"Beatriz"}
        ```
      ]
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Los sets *no tienen orden* y *no admiten duplicados*.
      ]
    ],
    [
      #ssstitle[Tupla — lista inmutable]
      #v(4pt)
      #code-box[
        ```python
        # Coordenadas geográficas (no cambian)
        buenos_aires = (-34.6, -58.4)
        mendoza      = (-32.9, -68.8)

        lat, lon = buenos_aires   # desempaquetar

        # Guardar múltiples resultados de una función
        def min_max(datos):
            return min(datos), max(datos)

        resultado = min_max([3, 1, 7, 2])
        resultado   # → (1, 7)
        ```
      ]
      #v(4pt)
      #tip-box[
        Usá *tuplas* para datos que *no deben modificarse*
        (coordenadas, fechas, parámetros fijos).
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// LOOPS Y CONDICIONALES
// ════════════════════════════════════════════════════════════════════════════
#section-divider("3", "Loops y condicionales", subtitle: "Repetir y decidir")

#pagebreak()
#counter-display
#stitle("Python", sub: "Loops")
#sstitle("El loop for — repetir una acción")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      Un loop `for` repite un bloque de código *una vez por cada elemento*
      de una colección.

      #v(8pt)
      #code-box[
        ```python
        # Recorrer una lista
        frutas = ["manzana", "pera", "naranja"]

        for fruta in frutas:
            print(f"Me gusta la {fruta}")

        # Recorrer un rango de números
        for i in range(5):
            print(i)   # imprime 0, 1, 2, 3, 4

        # range con inicio y paso
        for i in range(0, 20, 5):
            print(i)   # 0, 5, 10, 15
        ```
      ]
    ],
    [
      #ssstitle[¿Qué pasa en cada vuelta?]
      #v(4pt)
      #tip-box[
        *Analogía:* un loop `for` es como una receta que dice
        "para cada huevo en el cartón: romperlo y batirlo".
        La acción es siempre la misma; lo que cambia es el elemento actual.
      ]
      #v(8pt)
      #code-box[
        ```python
        # Acumular resultados
        notas = [7, 9, 6, 8, 10]
        suma = 0

        for nota in notas:
            suma = suma + nota

        promedio = suma / len(notas)
        print(f"Promedio: {promedio}")  # → 8.0
        ```
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Python", sub: "Loops")
#sstitle("Recorrer diccionarios")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #code-box[
        ```python
        resultados = {
            "glucosa":     92,
            "colesterol": 185,
            "triglicéridos": 130,
        }

        # Opción 1: solo las claves
        for análisis in resultados:
            print(análisis)

        # Opción 2: clave y valor juntos
        for análisis, valor in resultados.items():
            print(f"{análisis}: {valor} mg/dL")

        # Opción 3: con enumerate (índice + valor)
        for i, análisis in enumerate(resultados):
            print(f"{i+1}. {análisis}")
        ```
      ]
    ],
    [
      #ssstitle[Ejemplo práctico]
      #v(4pt)
      #code-box[
        ```python
        referencias = {
            "glucosa":      (70, 100),
            "colesterol":   (0,  200),
            "triglicéridos":(0,  150),
        }

        for analisis, valor in resultados.items():
            minimo, maximo = referencias[analisis]
            if valor < minimo or valor > maximo:
                estado = "⚠ fuera de rango"
            else:
                estado = "✓ normal"
            print(f"{analisis}: {valor} — {estado}")
        ```
      ]
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Salida: `glucosa: 92 — ✓ normal` · `colesterol: 185 — ✓ normal` · etc.
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Python", sub: "Condicionales")
#sstitle("if / elif / else — tomar decisiones")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #code-box[
        ```python
        temperatura = 38.6

        if temperatura >= 39.0:
            print("Fiebre alta — consultar médico")
        elif temperatura >= 37.5:
            print("Febrícula — reposo y control")
        elif temperatura >= 36.0:
            print("Temperatura normal")
        else:
            print("Hipotermia — atención urgente")
        ```
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        - `if` evalúa la primera condición.
        - `elif` evalúa condiciones alternativas (puede haber muchos).
        - `else` se ejecuta si ninguna condición anterior fue verdadera.
      ]
    ],
    [
      #ssstitle[Operadores de comparación]
      #v(4pt)
      #styled-table(
        columns: (auto, 1fr, auto),
        th[Operador], th[Significado], th[Ejemplo],
        td[`==`], tdg[igual a],          td[`x == 5`],
        td[`!=`], tdg[distinto de],      td[`x != 0`],
        td[`>`],  tdg[mayor que],         td[`x > 10`],
        td[`<`],  tdg[menor que],         td[`x < 10`],
        td[`>=`], tdg[mayor o igual que], td[`x >= 18`],
        td[`<=`], tdg[menor o igual que], td[`x <= 100`],
        td[`and`],tdg[ambas verdaderas],  td[`a>0 and b>0`],
        td[`or`], tdg[al menos una],      td[`a>0 or b>0`],
        td[`not`],tdg[negar],             td[`not True`],
      )
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// FUNCIONES
// ════════════════════════════════════════════════════════════════════════════
#section-divider("4", "Funciones", subtitle: "Reutilizar código · Explícitas · Lambda")

#pagebreak()
#counter-display
#stitle("Python", sub: "Funciones")
#sstitle("¿Por qué usar funciones?")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #tip-box[
        *Analogía:* una función es como una *receta de cocina*.
        Definís los pasos una sola vez y los podés ejecutar
        cuantas veces quieras, con distintos ingredientes (parámetros).
      ]
      #v(10pt)
      #text(size: 16pt)[Sin función — código repetido:]
      #v(4pt)
      #code-box[
        ```python
        imc_ana = 68 / (1.65 ** 2)   # 24.98
        imc_bea = 55 / (1.58 ** 2)   # 22.05
        imc_car = 90 / (1.80 ** 2)   # 27.78
        ```
      ]
    ],
    [
      #text(size: 16pt)[Con función — una sola definición:]
      #v(4pt)
      #code-box[
        ```python
        def calcular_imc(peso_kg, altura_m):
            imc = peso_kg / altura_m ** 2
            return round(imc, 2)

        # Usarla cuantas veces se quiera
        calcular_imc(68, 1.65)   # → 24.98
        calcular_imc(55, 1.58)   # → 22.05
        calcular_imc(90, 1.80)   # → 27.78
        ```
      ]
      #v(6pt)
      #text(fill: gry, size: 14pt)[
        Si algún día hay que corregir la fórmula,
        solo se cambia *en un lugar*.
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Python", sub: "Funciones")
#sstitle("Definir y usar funciones")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #code-box[
        ```python
        # Estructura básica
        def nombre_de_la_función(parámetro1, parámetro2):
            # cuerpo de la función
            resultado = parámetro1 + parámetro2
            return resultado

        # Parámetros con valor por defecto
        def saludar(nombre, saludo="Hola"):
            return f"{saludo}, {nombre}!"

        saludar("Ana")           # → "Hola, Ana!"
        saludar("Ana", "Buenos días")
        # → "Buenos días, Ana!"
        ```
      ]
    ],
    [
      #ssstitle[Ejemplo completo]
      #v(4pt)
      #code-box[
        ```python
        def clasificar_imc(peso_kg, altura_m):
            imc = peso_kg / altura_m ** 2

            if imc < 18.5:
                categoria = "Bajo peso"
            elif imc < 25:
                categoria = "Peso normal"
            elif imc < 30:
                categoria = "Sobrepeso"
            else:
                categoria = "Obesidad"

            return imc, categoria

        imc, cat = clasificar_imc(68, 1.65)
        print(f"IMC: {imc:.1f} — {cat}")
        # → IMC: 25.0 — Sobrepeso
        ```
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Python", sub: "Funciones")
#sstitle("Funciones anónimas — lambda")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      Una *función lambda* es una función corta, de una sola expresión,
      que se escribe en el lugar donde se necesita.

      #v(8pt)
      #code-box[
        ```python
        # Función normal
        def al_cuadrado(n):
            return n ** 2

        # Equivalente con lambda
        al_cuadrado = lambda n: n ** 2

        al_cuadrado(5)   # → 25
        ```
      ]
      #v(6pt)
      #code-box[
        ```python
        # Lambda con múltiples parámetros
        area_rectangulo = lambda base, alto: base * alto
        area_rectangulo(4, 3)   # → 12
        ```
      ]
    ],
    [
      #ssstitle[Uso típico: ordenar con criterio propio]
      #v(2pt)
      #code-box[
        ```python
        pacientes = [
            {"nombre": "Ana",    "edad": 34},
            {"nombre": "Carlos", "edad": 28},
            {"nombre": "Beatriz","edad": 41},
        ]
        # Ordenar por edad (de menor a mayor)
        ordenados = sorted(
            pacientes,
            key=lambda p: p["edad"]
        )
        # → Carlos (28), Ana (34), Beatriz (41)
        # Ordenar de mayor a menor
        sorted(pacientes, key=lambda p: p["edad"], reverse=True)
        ```
      ]
      #v(0pt)
      #text(fill: gry, size: 13pt)[
        `lambda p: p["edad"]` le dice a `sorted` *cómo comparar* cada elemento.
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// CLASES Y OBJETOS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("5", "Clases y objetos", subtitle: "Modelar entidades del mundo real")

#pagebreak()
#counter-display
#stitle("Python", sub: "Clases y objetos")
#sstitle("¿Qué es una clase?")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #tip-box[
        *Analogía:* una clase es un *molde*. \
        Los objetos son las *piezas* fabricadas con ese molde. \
        Cada pieza tiene los mismos atributos (forma) \
        pero con valores distintos (tamaño, color).
      ]
      #v(10pt)
      #text(fill: gry, size: 14pt)[
        Los objetos combinan:
        - *Atributos* — datos que describen al objeto \
          (nombre, edad, peso)
        - *Métodos* — acciones que puede realizar \
          (presentarse, calcular, comparar)
      ]
    ],
    [
      #code-box[
        ```python
        class Muestra:
            # El constructor define los atributos
            def __init__(self, id_muestra, organismo,
                         concentracion_ug_ml):
                self.id          = id_muestra
                self.organismo   = organismo
                self.conc        = concentracion_ug_ml

            # Método: acción que puede hacer la muestra
            def es_valida(self, umbral=10):
                return self.conc >= umbral

            def describir(self):
                estado = "válida" if self.es_valida() \
                          else "por debajo del umbral"
                print(f"Muestra {self.id} "
                      f"({self.organismo}): "
                      f"{self.conc} µg/mL — {estado}")
        ```
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Python", sub: "Clases y objetos")
#sstitle("Crear instancias y usar métodos")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Crear objetos (instancias)]
      #v(4pt)
      #code-box[
        ```python
        # Cada objeto es una "muestra" diferente
        m1 = Muestra("M-001", "E. coli",   45.2)
        m2 = Muestra("M-002", "S. aureus",  8.1)
        m3 = Muestra("M-003", "B. subtilis",22.7)

        # Usar los métodos
        m1.describir()
        # Muestra M-001 (E. coli): 45.2 µg/mL — válida

        m2.describir()
        # Muestra M-002 (S. aureus): 8.1 µg/mL
        # — por debajo del umbral

        # Acceder a los atributos directamente
        print(m1.organismo)   # → E. coli
        print(m3.conc)        # → 22.7
        ```
      ]
    ],
    [
      #ssstitle[Procesar una colección de objetos]
      #v(4pt)
      #code-box[
        ```python
        muestras = [m1, m2, m3]
        # Filtrar las muestras válidas
        validas = [
            m for m in muestras if m.es_valida()
        ]
        print(f"{len(validas)} de {len(muestras)} "
              f"muestras son válidas.")

        # Calcular concentración promedio
        promedio = (
            sum(m.conc for m in validas)
            / len(validas)
        )
        print(f"Concent. media: {promedio:.1f} µg/mL")
        ```
      ]
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Al usar una clase, el código que *usa* las muestras
        no necesita saber cómo están implementadas internamente.
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// ANOTACIONES DE TIPOS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("6", "Anotaciones de tipos", subtitle: "Claridad y detección temprana de errores")

#pagebreak()
#counter-display
#stitle("Python", sub: "Anotaciones de tipos")
#sstitle("Type hints — anotar el tipo esperado")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        Las *anotaciones de tipos* no cambian cómo funciona el programa,
        pero hacen el código más claro y detectan errores antes de ejecutar.
      ]
      #v(2pt)
      #code-box[
        ```python
        # Sin anotaciones (ambiguo)
        def procesar(datos, umbral):
            ...

        # Con anotaciones (claro)
        def procesar(
            datos: list[float],
            umbral: float = 0.05
        ) -> list[float]:
            ...
        ```
      ]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        Al leer la firma anotada sabemos exactamente:
        qué tipo de dato recibe, si tiene valor por defecto, y qué devuelve.
      ]
    ],
    [
      #ssstitle[Tipos comunes]
      #v(4pt)
      #code-box[
        ```python
        # Variables
        nombre: str = "Ana"
        edad: int = 34
        activo: bool = True

        # Colecciones
        notas: list[float] = [7.5, 9.0, 8.0]
        config: dict[str, int] = {"n": 100}

        # Función completa
        def filtrar_positivos(
            valores: list[float]
        ) -> list[float]:
            resultado: list[float] = []
            for v in valores:
                if v > 0:
                    resultado.append(v)
            return resultado
        ```
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// COMPRENSIÓN
// ════════════════════════════════════════════════════════════════════════════
#section-divider("7", "Comprensión", subtitle: "Construir listas, sets y diccionarios en una línea")

#pagebreak()
#counter-display
#stitle("Python", sub: "Comprensión")
#sstitle("List comprehension — el patrón")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        La *comprensión de listas* construye una lista nueva aplicando
        una expresión a cada elemento, con un `for` y opcionalmente un `if`.
      ]
      #v(2pt)
      #info-box[
        `[` *expresión* `for` *elemento* `in` *colección* `if` *condición* `]`
      ]
      #v(2pt)
      #code-box[
        ```python
        # Equivalencia: loop vs. comprensión
        notas = [6, 4, 8, 3, 9, 5, 7]
        # Con loop
        aprobados = []
        for n in notas:
            if n >= 6:
                aprobados.append(n)
        # Con comprensión (una línea)
        aprobados = [n for n in notas if n >= 6]
        # → [6, 8, 9, 7]
        ```
      ]
    ],
    [
      #ssstitle[Más ejemplos]
      #v(4pt)
      #code-box[
        ```python
        # Convertir temperaturas de Celsius a Fahrenheit
        celsius = [0, 20, 37, 100]
        fahrenheit = [(c * 9/5) + 32 for c in celsius]
        # → [32.0, 68.0, 98.6, 212.0]

        # Extraer solo los nombres en mayúsculas
        pacientes = ["ana", "carlos", "beatriz"]
        mayusculas = [p.upper() for p in pacientes]
        # → ["ANA", "CARLOS", "BEATRIZ"]

        # Cuadrados de los impares
        cuadrados = [x**2 for x in range(10)
                     if x % 2 != 0]
        # → [1, 9, 25, 49, 81]
        ```
      ]
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Más legible y eficiente que el loop equivalente para casos simples.
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Python", sub: "Comprensión")
#sstitle("Dict y set comprehension")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Dict comprehension]
      #v(0pt)
      #code-box[
        ```python
        # Construir un diccionario desde dos listas
        nombres = ["Ana", "Carlos", "Beatriz"]
        notas   = [8.5, 7.0, 9.2]
        resultado = {
            nombre: nota
            for nombre, nota in zip(nombres, notas)
        }
        # → {"Ana": 8.5, "Carlos": 7.0, "Beatriz": 9.2}

        # Invertir clave y valor
        invertido = {v: k for k, v in resultado.items()}
        # → {8.5: "Ana", 7.0: "Carlos", ...}

        # Solo los que aprobaron
        aprobados = {
            n: nota for n, nota in resultado.items()
            if nota >= 7
        }
        ```
      ]
    ],
    [
      #ssstitle[Set comprehension]
      #v(4pt)
      #code-box[
        ```python
        muestras = [
            ("M-001", "E. coli"),
            ("M-002", "S. aureus"),
            ("M-003", "E. coli"),
            ("M-004", "B. subtilis"),
        ]
        # Organismos únicos presentes
        organismos = {orgn for _, orgn in muestras}
        # → {"E. coli", "S. aureus", "B. subtilis"}

        # Igual con una lista (habría duplicados)
        con_lista = [orgn for _, orgn in muestras]
        # → ["E. coli", "S. aureus", "E. coli", ...]
        ```
      ]
      #v(4pt)
      #tip-box[
        `{}` con dos puntos → dict comprehension. \
        `{}` sin dos puntos → set comprehension.
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// MAP / FILTER / REDUCE / PIPE
// ════════════════════════════════════════════════════════════════════════════
#section-divider("8", "map · filter · reduce", subtitle: "Transformar datos en cadena")

#pagebreak()
#counter-display
#stitle("Python", sub: "Funcional")
#sstitle("map — transformar cada elemento")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      `map(función, lista)` aplica la función a *cada elemento*
      y devuelve una nueva colección con los resultados.

      #v(8pt)
      #tip-box[
        *Analogía:* una línea de producción donde cada pieza pasa
        por la misma máquina (la función).
      ]
      #v(8pt)
      #code-box[
        ```python
        # Convertir mg/dL a mmol/L (glucosa)
        glucosa_mgdl = [90, 115, 78, 200, 95]

        glucosa_mmol = list(
            map(lambda x: round(x / 18, 2), glucosa_mgdl)
        )
        # → [5.0, 6.39, 4.33, 11.11, 5.28]
        ```
      ]
    ],
    [
      #ssstitle[filter — conservar solo algunos]
      #v(4pt)
      #code-box[
        ```python
        # Mantener solo los valores fuera de rango
        def hiperglucemia(valor_mgdl):
            return valor_mgdl > 100

        altos = list(
            filter(hiperglucemia, glucosa_mgdl)
        )
        # → [115, 200]

        # Con lambda
        altos = list(
            filter(lambda x: x > 100, glucosa_mgdl)
        )
        ```
      ]
      #v(6pt)
      #text(fill: gry, size: 13pt)[
        `filter` devuelve *solo* los elementos para los que
        la función devuelve `True`.
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Python", sub: "Funcional")
#sstitle("reduce — acumular a un solo valor")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        `reduce(función, lista)` aplica la función de a *dos elementos*,
        acumulando el resultado hasta obtener un único valor.
      ]
      #v(2pt)
      #code-box[
        ```python
        from functools import reduce
        # Sumar todos los valores
        valores = [10, 20, 30, 40]
        total = reduce(lambda acc, x: acc + x, valores)
        # → 100  (igual que sum(valores))
        # Calcular el producto
        producto = reduce(lambda acc, x: acc * x, [1,2,3,4,5])
        # → 120  (= 5!)
        # Encontrar el máximo sin usar max()
        maximo = reduce(
            lambda a, b: a if a > b else b,
            valores
        )
        # → 40
        ```
      ]
    ],
    [
      #ssstitle[¿Cómo avanza reduce?]
      #v(4pt)
      #styled-table(
        columns: (auto, auto, auto, 1fr),
        th[Paso], th[acc], th[x], th[resultado],
        td[1], td[10], td[20], tdg[10 + 20 = 30],
        td[2], td[30], td[30], tdg[30 + 30 = 60],
        td[3], td[60], td[40], tdg[60 + 40 = 100],
      )
      #v(8pt)
      #tip-box[
        `reduce` es menos frecuente en la práctica. \
        Para sumar usá `sum()`, para el máximo `max()`. \
        Pero es poderoso cuando necesitás una acumulación personalizada.
      ]
    ]
  )
]


// ════════════════════════════════════════════════════════════════════════════
// NUMPY
// ════════════════════════════════════════════════════════════════════════════
#section-divider("9", "NumPy", subtitle: "Computación numérica eficiente")

#pagebreak()
#counter-display
#stitle("NumPy", sub: "¿Qué es?")
#sstitle("NumPy — el corazón del cálculo científico")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      NumPy (*Numerical Python*) agrega a Python el tipo *array*,
      una estructura optimizada para cálculo numérico masivo.

      #v(8pt)
      #tip-box[
        *¿Por qué no usar listas de Python?*

        Las listas de Python son lentas para operaciones numéricas
        porque cada elemento es un objeto independiente.
        Los arrays de NumPy guardan números en bloques de memoria
        contiguos — 10 a 100 veces más rápido para cálculos.
      ]
      #v(8pt)
      #text(fill: gry, size: 14pt)[
        Una *lista* de Python multiplica elemento por elemento: \
        hay que escribir un `for`. Con NumPy se hace directamente:
      ]
    ],
    [
      #code-box[
        ```python
        import numpy as np

        # Con lista Python
        datos = [1, 2, 3, 4, 5]
        dobles = [x * 2 for x in datos]

        # Con NumPy — mucho más directo
        datos = np.array([1, 2, 3, 4, 5])
        dobles = datos * 2
        # → array([2, 4, 6, 8, 10])

        # Operaciones sobre todo el array
        datos.mean()   # → 3.0  (promedio)
        datos.std()    # → 1.41 (desviación estándar)
        datos.sum()    # → 15
        datos.max()    # → 5
        datos ** 2     # → array([1, 4, 9, 16, 25])
        ```
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("NumPy", sub: "Arrays")
#sstitle("Crear arrays")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #code-box[
        ```python
        import numpy as np

        # Desde una lista
        arr = np.array([1, 2, 3, 4, 5])

        # Array de ceros y unos
        np.zeros(5)          # [0. 0. 0. 0. 0.]
        np.ones((2, 3))      # matriz 2×3 de unos

        # Rango de valores
        np.arange(0, 10, 2)  # [0 2 4 6 8]

        # Valores equidistantes
        np.linspace(0, 1, 5) # [0. 0.25 0.5 0.75 1.]

        # Matriz identidad
        np.identity(3)
        # [[1. 0. 0.]
        #  [0. 1. 0.]
        #  [0. 0. 1.]]
        ```
      ]
    ],
    [
      #ssstitle[Arrays 2D — matrices]
      #v(4pt)
      #code-box[
        ```python
        # Crear una matriz 3×4 con range(12)
        matriz = np.array(range(12)).reshape(3, 4)
        # [[ 0  1  2  3]
        #  [ 4  5  6  7]
        #  [ 8  9 10 11]]

        # Transponer (filas ↔ columnas)
        matriz.transpose()
        # [[ 0  4  8]
        #  [ 1  5  9]
        #  [ 2  6 10]
        #  [ 3  7 11]]

        # Dimensiones del array
        matriz.shape    # → (3, 4)
        matriz.size     # → 12
        ```
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("NumPy", sub: "Indexación")
#sstitle("Acceder a elementos de un array")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Indexación en 1D y 2D]
      #v(4pt)
      #code-box[
        ```python
        arr = np.array([10, 20, 30, 40, 50])

        arr[0]      # → 10   (primero)
        arr[-1]     # → 50   (último)
        arr[1:4]    # → [20, 30, 40]

        # Array 2D
        mat = np.array([[1,2,3],
                        [4,5,6],
                        [7,8,9]])

        mat[0, 0]   # → 1   (fila 0, columna 0)
        mat[1, :]   # → [4, 5, 6]  (fila 1 completa)
        mat[:, 2]   # → [3, 6, 9]  (columna 2 completa)
        ```
      ]
    ],
    [
      #ssstitle[Filtrar con condiciones]
      #v(4pt)
      #code-box[
        ```python
        glucosa = np.array([90, 115, 78, 200, 95, 130])

        # ¿Cuáles están por encima de 100?
        glucosa > 100
        # → [False True False True False True]

        # Extraer los valores elevados
        glucosa[glucosa > 100]
        # → [115, 200, 130]

        # Extraer y transformar a la vez
        glucosa[glucosa > 100] / 18
        # → [6.39, 11.11, 7.22]  (en mmol/L)
        ```
      ]
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Esta técnica se llama *boolean indexing* y evita tener
        que escribir un loop con `if`.
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// PANDAS
// ════════════════════════════════════════════════════════════════════════════
#section-divider("10", "Pandas", subtitle: "Tablas de datos · Series · DataFrames")

#pagebreak()
#counter-display
#stitle("Pandas", sub: "¿Qué es?")
#sstitle("Pandas — trabajar con datos tabulares")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      Pandas permite cargar, explorar y transformar datos organizados
      en filas y columnas, como una hoja de cálculo dentro de Python.

      #v(8pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Concepto], th[Descripción],
        td[`DataFrame`], tdg[Tabla completa: filas y columnas con nombres],
        td[`Series`],    tdg[Una sola columna (o fila) de la tabla],
        td[Índice],      tdg[Etiqueta de cada fila (puede ser numérica o de texto)],
      )
      #v(10pt)
      #tip-box[
        *Analogía:* un `DataFrame` es como una hoja de Excel,
        pero con superpoderes: podés filtrar, combinar,
        agrupar y transformar millones de filas al instante.
      ]
    ],
    [
      #code-box[
        ```python
        import pandas as pd

        # Crear desde un diccionario
        df = pd.DataFrame({
            "paciente":    ["Ana", "Carlos", "Bea"],
            "edad":        [34, 28, 41],
            "glucosa_mgdl":[90, 115, 78],
            "colesterol":  [185, 210, 170],
        })

        # Vista rápida
        df.head()         # primeras 5 filas
        df.info()         # tipos de datos y nulos
        df.describe()     # estadísticas básicas
        df.shape          # (3, 4) — filas, columnas
        ```
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Pandas", sub: "Seleccionar datos")
#sstitle("Filtrar filas y seleccionar columnas")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Seleccionar columnas]
      #v(4pt)
      #code-box[
        ```python
        # Una columna → Serie
        df["edad"]
        df.edad            # forma alternativa
        # Varias columnas → DataFrame
        df[["paciente", "glucosa_mgdl"]]
        ```
      ]
      #v(8pt)
      #ssstitle[Filtrar filas por condición]
      #v(4pt)
      #code-box[
        ```python
        # Pacientes con glucosa elevada
        df[df["glucosa_mgdl"] > 100]
        # Pacientes jóvenes con colesterol alto
        df[
          (df["edad"] < 35) &
          (df["colesterol"] > 200)
        ]
        ```
      ]
    ],
    [
      #ssstitle[loc e iloc]
      #v(4pt)
      #code-box[
        ```python
        df = df.set_index("paciente")

        # loc — por nombre de índice
        df.loc["Ana", :]
        df.loc["Ana", "glucosa_mgdl"]
        df.loc[["Ana", "Bea"], ["edad", "glucosa_mgdl"]]

        # iloc — por posición numérica
        df.iloc[0, :]     # primera fila
        df.iloc[-1, :]    # última fila
        df.iloc[0:2, 1:]  # sub-tabla
        ```
      ]
      #v(4pt)
      #styled-table(
        columns: (auto, 1fr),
        th[], th[Cuándo usar],
        td[`loc`],  tdg[Cuando sabés el nombre de la fila o columna],
        td[`iloc`], tdg[Cuando sabés la posición numérica],
      )
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Pandas", sub: "Transformar")
#sstitle("Agregar columnas y combinar tablas")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #ssstitle[Agregar columnas calculadas]
      #v(4pt)
      #code-box[
        ```python
        # Con assign (no modifica el original)
        df2 = df.assign(
            glucosa_mmol=lambda d:
                (d["glucosa_mgdl"] / 18).round(2),
            riesgo=lambda d:
                d["colesterol"].apply(
                    lambda c: "alto" if c > 200
                              else "normal"
                )
        )
        ```
      ]
      #v(6pt)
      #ssstitle[Concatenar tablas]
      #v(4pt)
      #code-box[
        ```python
        # Apilar filas de dos tablas
        todos = pd.concat([df_turno1, df_turno2])
        ```
      ]
    ],
    [
      #ssstitle[Combinar tablas (merge / join)]
      #v(4pt)
      #code-box[
        ```python
        # Tabla 1: datos demográficos
        demo = pd.DataFrame({
            "id":     [1, 2, 3],
            "nombre": ["Ana", "Bea", "Carlos"],
        })

        # Tabla 2: resultados de laboratorio
        lab = pd.DataFrame({
            "id":        [2, 3, 1],
            "glucosa":   [115, 78, 90],
        })

        # Combinar por la columna "id"
        combinado = pd.merge(
            demo, lab, on="id", how="inner"
        )
        # Resultado: tabla con nombre + glucosa
        ```
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Pandas", sub: "Agrupar")
#sstitle("groupby — resumir por categorías")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      `groupby` divide la tabla en grupos según una columna
      y aplica una función a cada grupo.
      #v(8pt)
      #code-box[
        ```python
        datos = pd.DataFrame({
            "servicio":  ["UCI", "UCI", "Clínica",
                          "Clínica", "UCI"],
            "glucosa":   [90, 200, 115, 78, 130],
            "colesterol":[185, 220, 210, 170, 190],
        })
        # Promedio por servicio
        datos.groupby("servicio").mean()

        # Máximo y mínimo por servicio
        datos.groupby("servicio").agg(["min", "max"])

        # Contar registros por servicio
        datos.groupby("servicio").size()
        ```
      ]
    ],
    [
      #ssstitle[Resultado del groupby]
      #v(4pt)
      #styled-table(
        columns: (auto, 1fr, 1fr),
        th[servicio], th[glucosa (mean)], th[colesterol (mean)],
        td[Clínica], tdg[96.5], tdg[190.0],
        td[UCI],     tdg[140.0], tdg[198.3],
      )
      #v(10pt)
      #tip-box[
        *Analogía:* `groupby` es como hacer una tabla dinámica en Excel.
        Definís *por qué columna agrupar* y *qué calcular* en cada grupo.
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// MATPLOTLIB
// ════════════════════════════════════════════════════════════════════════════
#section-divider("11", "Matplotlib", subtitle: "Visualización de datos")

#pagebreak()
#counter-display
#stitle("Matplotlib", sub: "Conceptos")
#sstitle("Figure y Axes — la estructura de un gráfico")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #tip-box[
        *Analogía:* \
        - `Figure` es el *lienzo* (la hoja de papel completa). \
        - `Axes` es cada *panel* o *gráfico* dentro del lienzo. \
          Un lienzo puede tener varios paneles.
      ]
      #v(8pt)
      #code-box[
        ```python
        import matplotlib.pyplot as plt

        # Un solo gráfico
        fig, ax = plt.subplots()
        ax.plot([1, 2, 3], [4, 1, 7])
        ax.set_title("Mi gráfico")
        ax.set_xlabel("Tiempo (h)")
        ax.set_ylabel("Concentración")
        plt.show()
        ```
      ]
    ],
    [
      #ssstitle[Múltiples paneles]
      #v(4pt)
      #code-box[
        ```python
        # 1 fila, 3 columnas de gráficos
        fig, axs = plt.subplots(
            1, 3,
            figsize=(15, 5),
            sharey=True   # comparten eje Y
        )

        # Cada tipo de gráfico en un panel
        axs[0].bar(nombres, valores)
        axs[0].set_title("Barras")
        axs[1].scatter(x, y)
        axs[1].set_title("Dispersión")
        axs[2].plot(tiempo, conc)
        axs[2].set_title("Línea")
        fig.suptitle("Comparación de tipos de gráfico")
        plt.tight_layout()
        ```
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("Matplotlib", sub: "Tipos de gráficos")
#sstitle("¿Qué tipo de gráfico usar?")
#slide[
  #styled-table(
    columns: (auto, 1fr, 1fr),
    th[Función], th[Cuándo usarlo], th[Ejemplo de uso],
    td[`ax.plot()`],
    tdg[Evolución a lo largo del tiempo o de una variable continua],
    tdg[Glucosa a lo largo de 24 horas],
    td[`ax.bar()`],
    tdg[Comparar cantidades entre categorías],
    tdg[Casos por hospital o por servicio],
    td[`ax.scatter()`],
    tdg[Ver la relación entre dos variables numéricas],
    tdg[Edad vs. presión arterial],
    td[`ax.hist()`],
    tdg[Ver la distribución de una variable],
    tdg[Distribución de edades en la muestra],
    td[`ax.boxplot()`],
    tdg[Comparar distribuciones entre grupos],
    tdg[Glucosa en UCI vs. Clínica],
  )
  #v(8pt)
  #text(fill: gry, size: 13pt)[
    Referencia y galería de ejemplos: matplotlib.org/stable/gallery/index.html
  ]
]

#pagebreak()
#counter-display
#stitle("Matplotlib", sub: "Ejemplo")
#sstitle("Personalizar un gráfico")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #code-box[
        ```python
        import matplotlib.pyplot as plt
        import numpy as np

        tiempos = [0, 2, 4, 6, 8, 12, 24]
        glucosa = [90, 145, 180, 160, 130, 110, 95]

        fig, ax = plt.subplots(figsize=(8, 5))

        ax.plot(tiempos, glucosa,
                color="steelblue",
                linewidth=2,
                marker="o",
                label="Glucosa (mg/dL)")
        ax.axhline(y=100, color="red",
                   linestyle="--",
                   label="Límite normal")
        ax.fill_between(tiempos, glucosa, 100,
                        where=[g > 100 for g in glucosa],
                        alpha=0.2, color="red")
        ```
      ]
    ],
    [
      #code-box[
        ```python
        ax.annotate(
            "Pico postprandial",
            xy=(4, 180),
            xytext=(10, 175),
            arrowprops=dict(
                arrowstyle="->",
                color="gray"
            ),
            fontsize=11, color="gray"
        )

        ax.set_title("Curva de glucemia")
        ax.set_xlabel("Horas")
        ax.set_ylabel("mg/dL")
        ax.legend()
        ax.grid(alpha=0.3)

        plt.tight_layout()
        plt.savefig("glucemia.png", dpi=150)
        plt.show()
        ```
      ]
    ]
  )
]

// ════════════════════════════════════════════════════════════════════════════
// SCIPY / SYMPY
// ════════════════════════════════════════════════════════════════════════════
#section-divider("12", "SciPy y SymPy", subtitle: "Estadística y cálculo simbólico")

#pagebreak()
#counter-display
#stitle("SciPy", sub: "Estadística")
#sstitle("SciPy — computación científica")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        SciPy extiende NumPy con herramientas para *estadística*,
        *optimización* e *integración numérica*.
      ]
      #v(2pt)
      #styled-table(
        columns: (auto, 1fr),
        th[Módulo], th[¿Para qué sirve?],
        td[`scipy.stats`],    tdg[Distribuciones, tests estadísticos (t, chi², Mann-Whitney...)],
        td[`scipy.optimize`], tdg[Encontrar mínimos, ajustar curvas],
        td[`scipy.integrate`],tdg[Calcular integrales numéricamente],
        td[`scipy.linalg`],   tdg[Álgebra lineal avanzada],
      )
      #v(10pt)
      #text(fill: gry, size: 13pt)[
        `scipy.stats` es el más usado en análisis de datos:
        permite calcular probabilidades, percentiles y aplicar tests
        estadísticos con pocas líneas de código.
      ]
    ],
    [
      #code-box[
        ```python
        from scipy import stats

        # Test t de Student
        # ¿Difieren las glucosas de dos grupos?
        grupo_a = [90, 95, 88, 102, 97]
        grupo_b = [115, 130, 125, 110, 120]

        t_stat, p_valor = stats.ttest_ind(
            grupo_a, grupo_b
        )
        print(f"t = {t_stat:.2f}")
        print(f"p = {p_valor:.4f}")

        # Si p < 0.05 → diferencia significativa

        # Correlación de Pearson
        r, p = stats.pearsonr(grupo_a, grupo_b)
        print(f"r = {r:.2f}, p = {p:.4f}")
        ```
      ]
    ]
  )
]

#pagebreak()
#counter-display
#stitle("SymPy", sub: "Cálculo simbólico")
#sstitle("SymPy — matemática exacta")
#slide[
  #grid(columns: (1fr, 1fr), gutter: 20pt,
    [
      #text(size:14pt)[
        SymPy realiza *cálculo simbólico*: trabaja con expresiones matemáticas
        exactas, no con aproximaciones numéricas.
      ]
      #v(2pt)
      #tip-box[
        Una calculadora da `sin(π) ≈ 1.2e-16` (error de redondeo). \
        SymPy da `sin(π) = 0` (exacto).
      ]
      #v(2pt)
      #code-box[
        ```python
        import sympy as sy
        x = sy.Symbol("x")
        # Derivada
        f = sy.cos(x)
        sy.diff(f, x)       # → -sin(x)
        # Integral
        sy.integrate(f, x)  # → sin(x)
        # Límite
        sy.limit(sy.sin(x)/x, x, 0)  # → 1
        ```
      ]
    ],
    [
      #ssstitle[Resolver ecuaciones]
      #v(4pt)
      #code-box[
        ```python
        import sympy as sy
        x = sy.Symbol("x")
        # Resolver ecuación cuadrática
        eq = x**2 - 5*x + 6
        sy.solve(eq, x)      # → [2, 3]
        # Sistema de ecuaciones
        y = sy.Symbol("y")
        soluciones = sy.solve([
            x + y - 5,   # x + y = 5
            x - y - 1,   # x - y = 1
        ], [x, y])
        # → {x: 3, y: 2}
        # Simplificar expresión
        expr = (x**2 - 1) / (x - 1)
        sy.simplify(expr)    # → x + 1
        ```
      ]
      #v(4pt)
      #text(fill: gry, size: 13pt)[
        Referencia: sympy.org/en/index.html
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
    Introducción a Python
  ]
  #v(12pt)
  #text(fill: cm3, size: 14pt, weight: "light", tracking: 3pt)[
    #upper[Javier Iserte]
  ]
]
