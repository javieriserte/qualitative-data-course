// ── Page & typography ──────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.8cm),
)

#set text(
  font: "Latin Modern Sans",
  size: 11pt,
  lang: "es",
)

#set par(justify: true, leading: 0.65em)

// ── Heading styles ─────────────────────────────────────────────────────────
#show heading.where(level: 1): it => {
  set text(size: 16pt, weight: "bold")
  v(0.5em)
  it
  v(0.4em)
  line(length: 100%, stroke: 0.5pt + luma(160))
  v(0.6em)
}

#show heading.where(level: 2): it => {
  set text(size: 13pt, weight: "bold")
  v(1em)
  it
  v(0.3em)
}

#show heading.where(level: 3): it => {
  set text(size: 11pt, weight: "bold", style: "italic")
  v(0.8em)
  it
  v(0.2em)
}

// ── Numbered lists ─────────────────────────────────────────────────────────
#set enum(indent: 1em, body-indent: 0.5em, spacing: 0.5em)

// ── Document ───────────────────────────────────────────────────────────────

= Maestría en Bioinformática y Biología de Sistemas

== Asignatura

Análisis de datos cualitativos (B4-NÚCLEO MATEMÁTICO).

== Carga horaria teórica y práctica

36hs (Teórica: 18hs; Práctica: 18hs)

== Objetivos

Complementar los conocimientos de estadística de pregrado con el estudio de técnicas de
análisis no paramétrico, otras técnicas de carácter topológico o gráficas para el análisis de
datos cualitativos, y su relación con la inteligencia artificial.

== Contenidos mínimos

Medidas de asociación entre variables con nivel de medición nominal u ordinal. Tablas de
contingencia de dos o más dimensiones. Comparación de dos o más poblaciones con
variables no paramétricas. Regresión lineal multiple y regresión logística. Reducción de
datos, análisis de correspondencia. Técnicas topológicas de agrupación (clustering)
jerárquicas y lineales. Alternativas no paramétricas del análisis discriminante. Modelos
Log-lineales. Técnicas de segmentación (CHAID). Árboles de decisión. Relación con redes
neuronales y bayesianas. Detección de aglomerados.

== Programa analítico

=== Unidad I.

Variables aleatorias y funciones de distribución. Análisis descriptivo de datos.
Independencia de variables y medidas de asociación.
En la actividad se trabaja según el siguiente sumario:

+ Conceptos de variables aleatorias, funciones de distribución, variables aleatorias
  discretas y continuas, niveles de medición.
+ Se detallan algunas distribuciones importantes.
+ Características numéricas de las variables aleatorias.
+ Distribución conjunta de variables aleatorias. Concepto de independencia.
+ Generación de distribuciones a partir de operaciones con variables aleatorias conocidas.
+ Concepto de muestra.
+ Estimación estadística de los parámetros de una distribución a partir de los datos de
  una muestra.
+ Análisis descriptivo de datos con el SPSS/PC. Comandos FREQUENCIES, DESCRIPTIVES y MEANS.
+ Prueba de Hipótesis. Verificación estadística de hipótesis estadística.
+ Prueba de bondad de ajuste a una distribución. Procedimientos no paramétricos
  CHISQUARE y KOLMOGOROV-SMIRNOV.

=== Unidad II.

Comparación de dos poblaciones. Análisis de varianza unifactorial y multifactorial.
En la actividad se trabaja según el siguiente sumario:

+ Esquema general de comparación de dos poblaciones.
+ Test de Student y Fischer para comparar variables independientes con distribución
  normal. Test de Student para comparar variables apareadas.
+ Implementación de los tests de Student en el SPSS/PC. Comando T-test.
+ Alternativas no paramétricas de comparación transversal y longitudinal. Los tests de
  Mann Whitney y Wilcoxon.
+ Subcomandos M-W y WILCOXON de NPAR TEST en el SPSS.
+ Otras pruebas de comparación no paramétricas y su implementación en el SPSS/PC.
  El test de Kolmogorov-Smirnov y de la Mediana. Test de los signos y de McNemar.
+ Solución integral de un problema de comparación de poblaciones. Uso complementario
  de tablas de Contingencia.
+ El análisis de varianza unifactorial Paramétrico. Hipótesis necesaria.
+ Complementos del análisis unifactorial. Los tests de rangos, el análisis de contrastes y
  la descomposición polinomial a la suma de cuadrados.
+ Procedimientos del SPSS/PC para el análisis de varianza, MEANS, ONEWAY y ANOVA.
  Sintaxis del ONEWAY.
+ Alternativa no paramétrica del ONEWAY: el análisis de varianza de Kruskal-Wallis y
  el test de la mediana.
+ Análisis de varianza no paramétricos para comparar longitudinalmente k variables
  dependientes: el test de Friedman y el test de Cochran.

=== Unidad III.

Análisis de Regresión Múltiple. Análisis de Regresión Logística.
En la actividad se trabaja según el siguiente sumario:

+ Planteamiento del problema de regresión en forma general.
+ Teoría de la Regresión Lineal Múltiple por el método de los Mínimos Cuadrados.
  Mínimos Cuadrados Ponderados. Examen de los residuos. Observaciones extremas.
  Examen gráfico de los residuos. Prueba de homogeneidad de varianza. Prueba de
  normalidad de los residuales. Búsqueda de la mejor ecuación de regresión.
+ Estudio de regresión en el SPSS/PC. Algunas ventajas y limitaciones.
+ Uso del paquete STEPWISE para la Regresión Lineal Múltiple. Preparación de datos.
  Inicio de la ejecución. Búsqueda de la ecuación. Estimaciones finales.
+ Aplicaciones posibles del programa STEPWISE.
+ Análisis de Regresión Logística.

=== Unidad IV.

Reducción de datos, análisis de correspondencia. Técnicas topológicas de agrupación
(clustering) jerárquicas y lineales. Alternativas no paramétricas del análisis discriminante.
Modelos Log-lineales.
En la actividad se trabaja según el siguiente sumario:

+ Reducción de datos, análisis de correspondencia. Técnicas topológicas de agrupación
  (clustering) jerárquicas y lineales.
+ Comparación de dos o más poblaciones atendiendo a un conjunto de variables
  correlacionadas. El análisis de varianza multivariado.
+ El análisis discriminante de dos poblaciones como método de comparación multivariada
  y técnicas de clasificación. Ideas generales de Fischer.
+ El análisis discriminante de dos poblaciones por técnicas de regresión. Otras técnicas
  paramétricas de análisis discriminante.
+ Generalización del problema de clasificación a más de dos poblaciones.
+ El procedimiento DISCRIMINANT del SPSS/PC.
+ Alternativas no paramétricas del análisis discriminante. Modelos Log-lineales.

=== Unidad V.

Técnicas de segmentación (CHAID). Árboles de decisión. Relación con redes neuronales
y bayesianas. Detección de aglomerados.
En la actividad se trabaja según el siguiente sumario:

+ Técnicas de segmentación CHAID.
+ Árboles de decisión.
+ Relación con redes neuronales y bayesianas.
+ Detección de aglomerados.

== Bibliografía

+ Conferencias del profesor en formato digital.
+ Jobson, _Categorical and Applied Multivariate Data Analysis_, Volume II, Multivariate
  Methods, Springer Verlag, 1992.
+ Donald Michie, David J. Spiegelhalter and Charles C. Taylor, _Machine Learning, Neural,
  and Statistical Classification_, 1996.
+ Fort Collins, _Geographic Information Systems_, CD: GIS World, Inc. 1995.
+ Fotheringham S., Rogerson P., _Spatial Analysis and GIS_. London, Taylor and Francis, 1994.
+ Buja A., Tukey P.A. (Eds). _Computing and Graphics in Statistics_, New York: Springer
  Verlag, 1991.
+ Buja A., Fowlkes E.B., Keramedes E.M., Kettenring J.R., Lee J.C., Swayne D.F., Tukey P.A.,
  "Discovering features of multivariate data through statistical graphics",
  _Proceedings of the Section on Statistical Graphics_, American Statistical Association,
  98--103, 1986.
+ _CHAID for SPSS for Windows, User's Guide_, SPSS Inc., 1995.
+ _SPSS 13.0 for Windows, User's Guide_, 2004.
+ _Handbook of Computational Statistics_, Springer Heidelberg, 2004.
+ Richard Saucier, _Computer Generation of Statistical Distributions_, 2010.
