
# Trabajo Final - Análisis de datos cualitativos

La resolución de los ejercicios debe entregarse en un documento junto con el
código fuente en python para resolverlo. La fecha límite de entrega es el lunes
22 de mayo de 2023 (cuatro semanas desde la entrega del enunciado).

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

- Realizar un análisis de correspondencia múltiple de los datos.
  - Mostrar gráficos (uno por variable aleatoria) donde se puedan observar el
    agrupamiento de los datos distinguiendo los valores de la variable con
    diferentes colores o marcadores.
- Estime las frecuencias de aparición de cada valor para cada variable
  aleatoria.
- Busque posibles asociaciones entre pares de variables aleatorias.

### 1.B - Métodos de predición

Genere tres métodos de predición:

- Uno basado en un modelo lineal logístico.
- Otro basado en Random Forest.
- El último basado en el análisis de discriminantes lineales.

Para los tres casos, muestre la forma de evaluación y el resultado con curvas
ROC y el área bajo la curva ROC.

## Ejercicio 2

En su lugar de trabajo están desarrollando un método de predicción tal que
permita estimar el tamaño de la planta modelo *A. thaliana* en función del
nivel de expresión de cinco genes medidos a nivel cualitativo. Debido a que
hasta el momento tienen pocos datos disponibles, le piden a usted que genere un
conjunto de datos aleatorio para avanzar con el desarrollo del métodos hasta que
nuevos datos experimental estén disponibles.

La expresión de los genes está medida en cinco niveles: "No_expresado",
"Poco_expresado", "Medianamente_expresado", "Bastante_expreado",
"Muy_Expresado". Los genes medidos son: "AT1G01239", "AT2G01130", "AT1G01060",
"AT3G02860" y "AT5G12041". Los datos generados deben respetar ciertas
frecuencias y asociaciones entre variables observadas consitentemente en datos
previos. La tabla resumen las frecuencias.

\footnotesize

| Expr/Gene              |AT1G01239|AT2G01130|AT1G01060|AT3G02860|AT5G12041|
| ----                   | ----    | ----    | ----    | ----    | ----    |
| No_expresado           | 13.2%   |  9.2%   | 15.8%   | 11.2%   | 30.9%   |
| Poco_expresado         | 30.4%   | 60.7%   | 15.9%   | 20.3%   | 25.2%   |
| Medianamente_expresado | 25.3%   | 15.1%   | 17.4%   | 30.4%   | 24.0%   |
| Bastante_expreado      | 20.9%   | 12.4    | 22.5%   | 19.0%   | 19.3%   |
| Muy_Expresado          | 10.2%   |  2.6%   | 28.4%   | 19.1%   |  0.6%   |

\normalsize

La expresión de los genes AT1G01239 y AT1G01060 está asociada, de forma tal que
la alta de expresión de uno de ellos suele estar acompañada con la alta
expresión del otro. Del forma parecida, la expresión de AT3G02860 está asociada
de forma inversa con respecto a AT5G12041, es decir que la expresión alta de uno
de ellos suele estar acompañada con la expresión baja o nula del otro.
