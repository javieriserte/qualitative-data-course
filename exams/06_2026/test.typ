// ─── Configuración global ────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 3cm),
)
#set text(font: "Arial", size: 11pt, lang: "es", fill: rgb("#032e35"))
#set par(justify: true, leading: 0.75em)

// ─── Paleta ──────────────────────────────────────────────────────────────────
#let cm1 = rgb("#a3804c")
#let cm2 = rgb("#032e35")
#let cm3 = rgb("#00a1ae")
#let gry = rgb("#6B7280")

// ─── Componentes ─────────────────────────────────────────────────────────────
#let var-name(body) = text(font: "Courier New", size: 10pt, fill: cm2)[#body]

#let note-box(body) = block(
  width: 100%,
  fill: rgb("#fffbeb"),
  stroke: 0.5pt + cm1,
  inset: (x: 12pt, y: 10pt),
  radius: 4pt,
  text(size: 10pt, fill: cm2)[#body]
)

// ════════════════════════════════════════════════════════════════════════════
// ENCABEZADO
// ════════════════════════════════════════════════════════════════════════════
#block(width: 100%)[
  #text(fill: cm2, weight: "bold", size: 20pt)[Trabajo Final]
  #h(1fr)
  #text(fill: gry, size: 10pt)[Análisis de Datos Cualitativos · 2026]
  #v(2pt)
  #line(length: 100%, stroke: 2pt + cm1)
]

#v(6pt)
#text(fill: gry, size: 10pt)[
  La resolución de los ejercicios debe entregarse en un documento junto con el
  código fuente en Python para resolverlo.
  La *fecha límite de entrega* es el lunes *18 de julio de 2026*.
]

#v(16pt)

// ════════════════════════════════════════════════════════════════════════════
// EJERCICIO 1
// ════════════════════════════════════════════════════════════════════════════
#block(width: 100%)[
  #text(fill: cm1, weight: "bold", size: 14pt)[Ejercicio 1]
  #v(2pt)
  #line(length: 100%, stroke: 0.5pt + cm1)
]

#v(8pt)

El archivo #var-name["exercise_one_data.csv"] contiene un dataset de datos cualitativos sobre pacientes diagnosticados con cáncer de mama. El objetivo es crear un predictor que pueda estimar la sobrevida de un paciente luego de cinco años del momento del diagnóstico positivo.

#v(10pt)

Las variables utilizadas para describir los datos son:

#v(6pt)

#table(
  stroke: none,
  inset: (x: 6pt, y: 5pt),
  fill: (col, row) => if calc.odd(row) { rgb("#f0f4f4") } else { white },
  columns: (auto, 1fr),
  [#text(weight: "bold", size: 10pt, fill: cm2)[Variable]],
  [#text(weight: "bold", size: 10pt, fill: cm2)[Descripción]],

  var-name[provincia],
  [Provincia de origen del paciente.],

  var-name[centro_de_salud_cercano],
  [`True` si el paciente tiene un centro médico de atención disponible a 10 km o menos; `False` en caso contrario.],

  var-name[estadio_al_momento_de_diagnostico],
  [Estadio del tumor, desde `I` hasta `IV`.],

  var-name[consulta_en_el_ano_previo_al_diagnostico],
  [`True` si el paciente realizó una consulta oncológica en el año previo al diagnóstico.],

  var-name[cobertura_de_salud],
  [`Publico`: diagnosticado en centro público. `Proveedor A`: centro privado del tercio superior en precio. `Proveedor B`: segundo tercio. `Proveedor C`: tercer tercio.],

  var-name[edad],
  [Rango de edad del paciente.],

  var-name[comorbilidad_cardiaca],
  [`True` si el paciente tiene diagnóstico positivo para una afección cardíaca al momento del diagnóstico.],

  var-name[comorbilidad_sistema_digestivo],
  [`True` si el paciente tiene diagnóstico positivo para una afección del sistema digestivo al momento del diagnóstico.],

  var-name[comorbilidad_sistema_endocrino],
  [`True` si el paciente tiene diagnóstico positivo para una afección del sistema endócrino al momento del diagnóstico.],

  var-name[tamano_tumor],
  [`pequeno`: ≤ 2 cm. `mediano`: 2–5 cm. `grande`: > 5 cm.],

  var-name[estado_nodos_linfatico],
  [`positivo` si se encontraron células tumorales en los nodos linfáticos; `negativo` de lo contrario.],

  var-name[estado_receptor_hormonas],
  [`ER`: expresa receptor de estrógeno. `PR`: receptor de progesterona. `ER/PR`: ambos. `Ninguno`: ninguno.],

  var-name[grado_diferenciacion_tumor],
  [Grado de diferenciación de las células del tumor: `bajo`, `medio`, `alto`.],

  var-name[sobrevida_a_cinco_anos],
  [`True` si el paciente tuvo una sobrevida mayor a 5 años del momento del diagnóstico; `False` de lo contrario.],
)

#v(10pt)

#note-box[
  *Nota:* Los datos de este ejercicio son simulados y no guardan ninguna relación con pacientes reales, ni tienen valor diagnóstico.
]

#v(16pt)

// ─── 1.A ─────────────────────────────────────────────────────────────────────
#text(fill: cm2, weight: "bold", size: 12pt)[1.A — Descripción inicial del dataset]

#v(6pt)

- Estime las frecuencias de aparición de cada valor para cada variable aleatoria.
- Busque posibles asociaciones entre pares de variables aleatorias.
- Realice un análisis de correspondencia múltiple de los datos.

#v(4pt)
Explique qué interpreta de los resultados.

#v(14pt)

// ─── 1.B ─────────────────────────────────────────────────────────────────────
#text(fill: cm2, weight: "bold", size: 12pt)[1.B — Métodos de predicción]

#v(6pt)

Se quiere crear un predictor que pueda estimar si un paciente tendrá una expectativa de vida mayor a cinco años luego del momento del diagnóstico positivo.

Se deben construir *tres métodos diferentes* y comparar los resultados obtenidos entre ellos. Los métodos deben estar basados en:

#v(4pt)

- Un modelo lineal logístico.
- Random Forest.
- Análisis de discriminantes lineales o cuadráticos.

#v(4pt)

Para los tres casos, muestre la forma de evaluación y el resultado con *curvas ROC* y el *área bajo la curva ROC*.

En base a la comparación, proponga el mejor candidato. El modelo candidato propuesto será evaluado por el docente con un dataset nuevo obtenido de la misma población.

#v(20pt)

// ════════════════════════════════════════════════════════════════════════════
// EJERCICIO 2
// ════════════════════════════════════════════════════════════════════════════
#block(width: 100%)[
  #text(fill: cm1, weight: "bold", size: 14pt)[Ejercicio 2]
  #v(2pt)
  #line(length: 100%, stroke: 0.5pt + cm1)
]

#v(8pt)

Una empresa semillera evaluó el efecto de tres inoculantes bacterianos sobre el
rinde de maíz en condiciones de campo. El ensayo fue realizado durante tres
temporadas agrícolas consecutivas en seis localidades de la región pampeana,
utilizando cinco variedades comerciales con distintos potenciales de rinde máximo.
Por restricciones de costo, no se evaluaron todas las combinaciones posibles
de factores (diseño incompleto).

#v(8pt)

El archivo #var-name["inoculantes_maiz.csv"] contiene los datos del ensayo.
Las variables registradas son:

#v(6pt)

#table(
  stroke: none,
  inset: (x: 6pt, y: 5pt),
  fill: (col, row) => if calc.odd(row) { rgb("#f0f4f4") } else { white },
  columns: (auto, 1fr),
  [#text(weight: "bold", size: 10pt, fill: cm2)[Variable]],
  [#text(weight: "bold", size: 10pt, fill: cm2)[Descripción]],

  var-name[variedad],
  [Variedad de maíz evaluada: Pampeador, Sudestada, Zonda, Pampero, Ñandubay.],

  var-name[ubicacion],
  [Localidad del ensayo: Pergamino, Venado Tuerto, Río Cuarto, Junín, Marcos Juárez, Tandil.],

  var-name[temporada],
  [Temporada agrícola: `2022/23`, `2023/24`, `2024/25`.],

  var-name[riego],
  [`con_riego` o `sin_riego`.],

  var-name[inoculante],
  [Tratamiento aplicado a la semilla: `Control` (sin inoculante), `NitroMax`, `BioRaiz`, `TerraFix`.],

  var-name[aplicacion_fungicida],
  [`True` si se aplicó fungicida foliar durante el ciclo del cultivo; `False` en caso contrario.],

  var-name[lote_numero],
  [Identificador del lote dentro de cada localidad.],

  var-name[rinde_kg_ha],
  [Rinde de maíz en kg por hectárea (variable respuesta).],
)

#v(10pt)

#note-box[
  *Nota:* Los datos de este ejercicio son simulados. Los nombres de variedades e inoculantes son de fantasía y no corresponden a productos reales.
]

#v(14pt)

// ─── 2.A ─────────────────────────────────────────────────────────────────────
#text(fill: cm2, weight: "bold", size: 12pt)[2.A — Análisis exploratorio]

#v(6pt)

- Describa la distribución del rinde para cada nivel de los factores del ensayo.
- Identifique visualmente qué factores parecen tener mayor influencia sobre el rinde.
- Evalúe si existen diferencias entre temporadas y entre localidades. ¿Qué implicancias tiene esto para el modelado?

#v(14pt)

// ─── 2.B ─────────────────────────────────────────────────────────────────────
#text(fill: cm2, weight: "bold", size: 12pt)[2.B — Modelado lineal]

#v(6pt)

Construya un modelo lineal para explicar el rinde en función de los factores disponibles.

- Justifique qué variables incluye en el modelo y cuáles descarta, apoyándose en criterios estadísticos.
- Evalúe los supuestos del modelo (normalidad de residuos, homocedasticidad, independencia).
- Interprete los coeficientes estimados: ¿qué factores tienen efecto significativo sobre el rinde?

#v(14pt)

// ─── 2.C ─────────────────────────────────────────────────────────────────────
#text(fill: cm2, weight: "bold", size: 12pt)[2.C — Evaluación de los inoculantes]

#v(6pt)

El objetivo central del ensayo es determinar si alguno de los tres inoculantes
mejora el rinde respecto al control sin inoculante.

- En base al modelo ajustado, ¿qué inoculante o inoculantes tienen un efecto
  significativo sobre el rinde? ¿Cuánto aportan en kg/ha?
- ¿Existe evidencia de que el efecto del fungicida depende de la localidad?
  Justifique con el modelo o con un análisis complementario.
- Redacte una conclusión breve dirigida al equipo agronómico de la empresa,
  con una recomendación práctica sobre el uso de inoculantes.

#v(20pt)

// ════════════════════════════════════════════════════════════════════════════
// EJERCICIO 3
// ════════════════════════════════════════════════════════════════════════════
#block(width: 100%)[
  #text(fill: cm1, weight: "bold", size: 14pt)[Ejercicio 3]
  #v(2pt)
  #line(length: 100%, stroke: 0.5pt + cm1)
]

#v(8pt)

Un organismo de salud provincial realizó un estudio epidemiológico para evaluar
la asociación entre la fuente de agua de consumo (red pública vs. pozo o cisterna)
y la ocurrencia de episodios de diarrea aguda en población rural.
El estudio se llevó a cabo en tres municipios con distintas condiciones
socioeconómicas. Adicionalmente, un subconjunto de hogares fue monitoreado
*antes y después* de una intervención de mejora del sistema de distribución
de agua potable.

#v(8pt)

Los datos están organizados en tres archivos:

#v(6pt)

#table(
  stroke: none,
  inset: (x: 6pt, y: 5pt),
  fill: (col, row) => if calc.odd(row) { rgb("#f0f4f4") } else { white },
  columns: (auto, 1fr),
  [#text(weight: "bold", size: 10pt, fill: cm2)[Archivo]],
  [#text(weight: "bold", size: 10pt, fill: cm2)[Contenido]],

  var-name[encuesta_transversal.csv],
  [Encuesta a hogares: fuente de agua, episodio de diarrea en los últimos 30 días, municipio, nivel socioeconómico (`bajo` / `medio` / `alto`).],

  var-name[seguimiento_apareado.csv],
  [Subconjunto de hogares relevados *antes* y *después* de la intervención. Cada fila es un hogar; columnas `diarrea_antes` y `diarrea_despues` indican si hubo episodio en cada período.],

  var-name[tabla_estratificada.csv],
  [Mismos datos de la encuesta transversal reorganizados como tablas 2×2 por municipio, para análisis estratificado.],
)

#v(14pt)

// ─── 3.A ─────────────────────────────────────────────────────────────────────
#text(fill: cm2, weight: "bold", size: 12pt)[3.A — Asociación entre fuente de agua y diarrea (Fisher exacto)]

#v(6pt)

A partir de #var-name["encuesta_transversal.csv"], construya la tabla de
contingencia 2×2 entre fuente de agua y presencia de episodio de diarrea.

- Verifique si se cumplen las condiciones para aplicar el test χ². En caso de
  que no se cumplan, justifique por qué debe usarse el test de Fisher exacto.
- Aplique el test de Fisher exacto e interprete el p-valor obtenido.
- Calcule el *odds ratio* (OR) y su intervalo de confianza al 95%.
  ¿Qué indica el OR sobre la magnitud y dirección de la asociación?

#v(14pt)

// ─── 3.B ─────────────────────────────────────────────────────────────────────
#text(fill: cm2, weight: "bold", size: 12pt)[3.B — Efecto de la intervención (McNemar)]

#v(6pt)

A partir de #var-name["seguimiento_apareado.csv"], evalúe si la intervención
de mejora del agua redujo la proporción de hogares con episodios de diarrea.

- Construya la tabla de contingencia apareada (tabla de discordancias) con los
  pares antes/después.
- Explique por qué en este caso *no* es correcto aplicar un test de Fisher
  estándar y por qué corresponde el test de McNemar.
- Aplique el test de McNemar e interprete el resultado.
  ¿Existe evidencia de un cambio significativo tras la intervención?

#v(14pt)

// ─── 3.C ─────────────────────────────────────────────────────────────────────
#text(fill: cm2, weight: "bold", size: 12pt)[3.C — Control por nivel socioeconómico (Mantel-Haenszel)]

#v(6pt)

El nivel socioeconómico del hogar puede estar asociado tanto con la fuente de
agua utilizada como con la ocurrencia de diarrea, actuando como variable de
confusión.

- A partir de #var-name["tabla_estratificada.csv"], construya una tabla 2×2
  por cada municipio y calcule el OR crudo (sin estratificar) y el
  OR ajustado por Mantel-Haenszel.
- Compare ambos OR. ¿En qué dirección y magnitud modifica la estratificación
  la asociación observada? ¿Se observa algún indicio de paradoja de Simpson?
- Aplique el test de Mantel-Haenszel e interprete el p-valor global.
- Redacte una conclusión integradora sobre la asociación entre fuente de agua
  y diarrea, considerando los resultados de los tres análisis realizados
  (Fisher, McNemar y Mantel-Haenszel).

#v(10pt)

#note-box[
  *Nota:* Los datos de este ejercicio son simulados. Para los tres archivos
  se espera que el análisis incluya el código Python utilizado
  (`scipy.stats`, `statsmodels`).
]
