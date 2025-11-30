
# Trabajo Final - Análisis de datos cualitativos

La resolución de los ejercicios debe entregarse en un documento junto con el
código fuente en python para resolverlo. La fecha límite de entrega es el lunes
9 de diciembre de 2025.

## Ejercicio 1

El archivo "exercise_one_data.csv" contiene un dataset de datos cualitativos
sobre pacientes diagnosticados con cancer de mama. El objetivo es crear
predictor que pueda estimar la sobrevida de un paciente luego de cinco años del
momento del diagnóstico positivo.

Las variables utilizadas para describir los datos son:

- provincia: Provincia de origen del paciente.
- centro_de_salud_cercano: Es "True" si el paciente tiene un centro médico de
  de atención disponible a 10 km o menos, "False" en caso contrario.
- estadio_al_momento_de_diagnostico: El estadio de tumor, desde "I" hasta "IV".
- consulta_en_el_ano_previo_al_diagnostico: "True" si el paciente realizó una
  consulta oncológica en el año previo al diagnóstico.
- cobertura_de_salud: Tipo de cobertura de salud: "Publico" si el paciente se
  fue diagnosticado en un centro de salud público. "Proveedor A" si el paciente
  fue diagnosticado en en centro de salud privado del tercio superior en precio
  promedio. "Proveedor B", si el paciente fue diagnosticado en un centro de
  salud del segundo de tercio en precio promedio y "Proveedor C" si el paciente
  fue diagnosticado en un centro de salud privado del tercer tercio en precio
  promedio.
- edad: rango de edad del paciente.
- comorbilidad_cardiaca: "True" si el paciente tiene un diagnóstico positivo
  para una afección cardíaca al momento de diagnóstico.
- comorbilidad_sistema_digestivo: "True" si el paciente tiene un diagnóstico
  positivo para una afección del sistema digestivo al momento del diagnóstico.
- comorbilidad_sistema_endocrino: "True" si el paciente tiene un diagnóstico
  positivo para una afección del sistema endócrino al momento de diagnóstico.
- tamano_tumor: Tamaño del tumor, "pequeno" si el es de 2cm o menos, "mediano"
  si es de 2 a 5 cm, y "grande" si es de más de 5cm.
- estado_nodos_linfatico: "positivo" si se encontraron células tumorales en los
  nodos linfáticos. "negativo" de lo contrario.
- estado_receptor_hormonas: "ER" si el tumor expresa el receptor de estrógeno,
  "PR" si expresa el receptor de progesterona, "ER/PR" si expresa ambos,
  "Ninguno" si no expresa ninguno de los dos.
- grado_diferenciacion_tumor: Grado de diferenciación de las células del tumor:
  "bajo", "medio", "alto".
- sobrevida_a_cinco_anos: "True" si el paciente tuvo una sobrevida mayor a 5
  años del momento del diagnóstico, "False" de lo contrario.

Nota: Los datos de este ejercicio son simulados y no guardan ninguna relación
con pacientes reales, ni tienen valor diagnótico.

### 1.A - Descripción inicial del data set

- Estime las frecuencias de aparición de cada valor para cada variable
  aleatoria.
- Busque posibles asociaciones entre pares de variables aleatorias.
- Realizar un análisis de correspondencia múltiple de los datos.

Explique que interpreta de los resultados.

### 1.B - Métodos de predicción

Se quiere crear un predictor que pueda estimar si un paciente tendrá un expectativa
de vida mayor a cinco años luego del momento del diagnóstico positivo.

Se deben construir tres métodos diferentes y comparar los resultados obtenidos
entre ellos.

Los métodos deben estár basados en:

- Un modelo lineal logístico.
- Random Forest.
- Análisis de discriminantes lineales o cuadráticos.

Para los tres casos, muestre la forma de evaluación y el resultado con curvas
ROC y el área bajo la curva ROC.

En base a la comparación proponga el mejor candidato.

El modelo candidato propuesto será evaluado por el docente con un dataset nuevo
obtenido de la misma población.

## Análisis Alternativo

Un trabajo alternativo a este trabajo puede ser propuesto por cada alumno
utilizando datos de interés propio. La complejidad del trabajo debe ser similar
a la de este trabajo.
