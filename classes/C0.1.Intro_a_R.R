
#--------------------------------------------------------------------------------------------------------------#
#-------------------------------------------- Elementos b�sicos de R ------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#

# En el d�a de hoy vamos a comenzar viendo los elementos b�sicos de la 
# sintaxis de R. 
# Entre las muchas cosas que podemos con R, lo podemos usar como si 
# fuera una calculadora.

2+10
315/7
89*3
sqrt(99225)
21^pi

#--------------------------------------------------------------------------------------------------------------#
#--------------------------------------------Tipos de Datos----------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#


#En R todo el tiempo vamos a estar trabajando con datos, por lo cual una de las primeras cosas que debemos hacer es
#crear los distintos "objetos" que van a contener nuestros datos. Por ejemplo podemos crear un objeto que se llame 
#"cursos".

cursos <- 3

#en R hay varios tipos de objetos: numeric, integer, character, logical, ... Para saber de qu� clase es un objetos 
#podemos usar la funci�n class.

?class
class(cursos)

#con los objetos en R se pueden realizar una gran cantidad de operaciones. Por ejemplo, imaginen que en la segunda 
#parte del a�o damos 2 cursos m�s, ahora podr�amos crear un segundo objeto cursos2.

cursos2 <- 2

#Si lo que queremos es a partir de los dos objetos anteriores saber cuántos cursos de Bioinformática se dieron en el
#a�o podemos simplemente sumar los objetos "cursos" y "cursos2"

cursos + cursos2
cursos_totales <- cursos + cursos2 

#Por otro lado, podemos convertir los objetos en R de una clase a otra, aunque con algunas excepciones....

as.integer(cursos_totales)
as.character(cursos_totales)
as.logical(cursos_totales)


#--------------------------------------------------------------------------------------------------------------#
#--------------------------------------Estructuras de Datos----------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#


#En R podremos encontrar objetos que contengan más de un dato como puede ser una tabla, una matriz o un vector.

cursos <- c("Linux", "Python", "R")
horas  <- c(8, 12, 20)

#De la misma manera que podemos realizar c�lculos con n�meros tambi�n lo podemos hacer con vectores

horas + 2
2*horas
horas +c(1, 2, 3, 4)

#Los vectores s�lo aceptan que todos los elementos que sean guardados en los mismos sean de la misma clase.

cs <- c("Linux", "Python", "R", 2) #�Qu� ocurri� con el 2?

#En cambio, las listas nos permiten contener elementos de diferentes clases en el mismo objeto.

cs <- list("Linux", "Python", "R", 2)
class(cs[[1]]) #�De que clase es el primer elemento de la lista?
class(cs[[4]]) #�De que clase es el cuarto elemento de la lista?

#En R tambi�n encontramos estructuras de datos que son de dos dimensionen que nos van a permitir trabajar con
#tablas (a las que vamos a llamar data.frames) y matrices.

#A partir de los dos vectores que creamos anteriormente vamos a generar un data.frame

carga_horaria <- data.frame(cursos, horas)

class(carga_horaria)
str(carga_horaria)       #la funci�n str nos permite analizar la estructura de los datos
dim(carga_horaria)       #dim devuelve las dimensiones del data.frame
colnames(carga_horaria)  #colnames nos devuelve los nombres de las columnas, de forma similar existe rownames

#Tambi�n podemos agregar m�s columnas o filas a un dataframe
?cbind
?rbind

profes <- c("eli", "javi", "andr�s")

carga_horaria <- cbind(carga_horaria, profes) #fijense que estoy pisando la variable vieja agregando una nueva columna
                                              #de forma similar puedo agregar filas con rbind 

#Las matrices de forma similar a los vectores, s�lo van a permitir contener un solo tipo de dato
?matrix
?seq

v      <- seq(1, 9)

m1     <- matrix(data = v, nrow = 3, ncol = 3, byrow = TRUE)
m2     <- matrix(data = v, nrow = 3, ncol = 3, byrow = F)


#--------------------------------------------------------------------------------------------------------------#
#----------------------------------------------Subsetting------------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#

#Vamos a trabajar con un dataset que se encuentra dentro del paquete 'datasets' que se llama PlantGrowth, que 
#contiene los datos de peso seco de plantas crecidas bajo distintas condiciones.

plantas <- datasets::PlantGrowth #al dataset lo nombro como "plantas"
head(plantas)         #nos muestra las primeras filas del dataset
colnames(plantas)
dim(plantas)
str(plantas)          
class(plantas$group)  #factor es una clase de escructura de datos similar a un vector que se reserva para asignar 
                      #variables cualitativas
levels(plantas$group) #levels son los distintos valores que puede tomar los elementos dentro del objeto factor, en 
                      #este caso serían los distintos tratamiento a los que se sometieron las plantas.

plantas$weight       #imprimir en pantalla la primera columna del dataset
plantas[, 1]         #otra forma de hacer lo mismo
plantas[, "weight"]  #y otra más...

plantas[15, 1]  #imprimo en pantalla el valor que toma el peso (primera columna) en la planta número 15
                #el primer valor entre corchetes indica a qué fila quiero acceder, y el segundo valor a qué columna


#�c�mo har�a si quiero que me muestre en pantalla solamente las filas que corresponden al tratamiento 2?

?which
plantas[which(plantas$group == "trt2"), ] #con which le estoy preguntando cu�les son las filas en las que en la columna
                                          #"group" el valor sea igual a "trt2"

#�Y si quiero que me muestre las plantas que pesan m�s que 5.5?

plantas[which(plantas$weight > 5.5), ]

mayor5.5 <- plantas$weight > 5.5 #otra manera de hacer lo mismo, pero antes genero un vector logico que va a evaluar en
                                 #cada fila si el valor de peso es mayor a 5.5 o no
mayor5.5

plantas[mayor5.5, ]              #uso ese vector para subsettear el data.frame

#ahora vamos a hacer lo mismo pero con dos condiciones: voy a querer imprimir en pantalla las plantas que pertenecen
#al tratamiento 2 y que pesan más de 5.5

plantas[which(plantas$weight > 5.5 & plantas$group == "trt2"), ]

#tambi�n puedo guardar la tabla subseteada como un nuevo objeto
plantas2 <- plantas[which(plantas$weight > 5.5 & plantas$group == "trt2"), ]


#Ahora vamos a ver c�mo se subsetea una lista. En las listas, al poder contener objetos muy variados, hay que tener 
#ciertas consideraciones a la hora de subsetear

tecnicas_BioMol <- list("Southern", "Western" , c("Northern", "RNASeq", "RTPCR"))

length(tecnicas_BioMol)     #�cu�ntos elementos tiene la lista? �por qu�?

tecnicas_BioMol[1]          #quiero imprimir el primer elemento de la lista...
class(tecnicas_BioMol[1])   #pero...

tecnicas_BioMol[[1]]        #�cu�l es la diferencias con el paso anterior?
class(tecnicas_BioMol[[1]])

tecnicas_BioMol[[3]]        #�qu� ocurre cuando tengo un vector dentro de una lista?
tecnicas_BioMol[[3]][2]     #para llegar al elemento que se encuentra en la 2da posición en la lista


#tambi�n puedo nombrar a cada elemento de la lista y usarlos para subsetear
tecnicas_BioMol <- list(DNA = "Southern", Proteinas = "Western" , RNA = c("Northern", "RNASeq", "RTPCR"))

tecnicas_BioMol$RNA


#--------------------------------------------------------------------------------------------------------------#
#----------------------------------Estructuras de Control------------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#

#vamos a usar un ejemplo: queremos saber cuanto vale la suma de los primeros 100 n�meros naturales
#para eso tenemos que tener una variable que vaya acumulando el resultado de la suma en cada iteraci�n (n),y otra 
#variable que vaya recorriendo los n�meros desde 1 hasta 100 (i)

n=0
for (i in 1:100){
  n=n+i
}
print(n)

#�Hay alguna forma de hacer lo mismo pero sin utilizar un for?
sum(1:100)

#queremos saber si un n�mero es par o impar, entonces debemos usar la estructura if - else

numero = 10
if (numero%%2 == 0){
  print("El n�mero es par")
}else{
  print("El n�mero es impar")
  }

#esta es otra forma pero imprimiendo de otra manera los resultados
?paste

numero = 10
if (numero%%2 == 0){
  print(paste("El n�mero", numero, "es par"))
}else{
  print(paste("El n�mero", numero, "es impar"))
}


#Ahora queremos guardar en una variable la suma de los n�meros pares desde 1 a 100 y en otra variable la suma de 
#los n�meros impares. En este caso vamos a necesitar un "if" que me permita saber si un n�mero es par o impar
#la expresi�n %% me permite saber el resto de la divisi�n, por ej. 48%%2 va a devolver 0, que 48 es divisible 
#por 2

pares   = 0
impares = 0

for (i in 1:100){
  if (i%%2 == 0)
    pares = pares + i
  else{
    impares = impares +i
  }
}

print(pares)
print(impares)

#�Hay alguna forma de hacer lo mismo pero sin utilizar un for ni un if?

pares = sum(seq(2, 100, by = 2))
impares = sum(seq(1, 100, by = 2))

#--------------------------------------------------------------------------------------------------------------#
#----------------------------------------------Crear Funciones-------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#

#primer ejemplo sencillo para definir una funci�n en R
sumar <- function(x, y){
  print(x+y)
}

sumar(2, 3)

sumar <- function(x, y){
  suma <- x+y
  return(suma)
}

total <- sumar(2, 3)
print(total)

total <- sumar(total, 10)


#otro ejemplo pero usando un for dentro de la funci�n...
sumar_hasta(100)

sumar_hasta <- function(n){
  suma_i <- 0
  for(i in 1:n){
    suma_i = suma_i + i
  }
  return(suma_i)
}

sumar_hasta(100)
sumar_hasta(1010)


#--------------------------------------------------------------------------------------------------------------#
#-------------------------------------------Importaci�n de Paquetes--------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#

#Importaci�n desde CRAN
install.packages("moments")
library(moments)

#--------------------------------------------------------------------------------------------------------------#
#-------------------------------------------Exportaci�n e Importaci�n------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#

#Vamos a exportar la tabla del experimento de crecimiento de plantas filtrada por tipo de tratamiento (trt2) y por 
#peso (plantas con peso mayor a 5.5)

?write.csv
write.csv(x = plantas2, file = "~/plantas_filtradas.csv")

#tambi�n se puede exportar en un tipo de archivo especial que permite guardar en un solo archivo uno o m�s objetos
#de R. Vamos a exportar tanto la tabla original como la tabla filtrada en el archivo "plantas_filtradas.RData"
?save

save(plantas, plantas2, file = "~/plantas_filtradas.RData")

#vamos a borrar los objetos que acabamos de guardar para ver c�mo los importamos de nuevo a nuestra sesi�n

rm(plantas, plantas2)  #este comando eliminar� de nuestra sesi�n estos dos objetos

load("~/plantas_filtradas.RData") #ahora los volvemos a importar desde el archivo plantas_filtradas.RData

#--------------------------------------------------------------------------------------------------------------#
#------------------------------------------------- Ejercicios -------------------------------------------------#
#--------------------------------------------------------------------------------------------------------------#

# 1) A partir del paquete dataset generen un data.frame "air" que contiene datos clim�ticos de la
# ciudad de Nueva York, usando el siguiente comando: air <- datasets::airquality.

# Imprime en pantalla solamente las primeras filas del data.frame y luego las �ltimas.
# Ayuda: ?head, ?tail
# a) Imprime en pantalla todos los valores correspondientes con la Temperatura
# registrada y luego solamente el valor de Temperatura que se registr� el tercer d�a.
# b) Seleccion� todas las filas de air del mes de mayo.
# c) �Qu� d�a fue en el que hubo menor radiaci�n solar? Ayuda: ?which.min
# d) �Cu�l fue la temperatura el 27 de Agosto? Ayuda: ?which, & (and)
# e) Seleccion� todas las filas de air del mes de mayo cuya radiaci�n solar sea mayor a
# 150.
# g) Genera un nuevo data.frame llamado "calor" que contenga la informaci�n de los d�as
# en los que hizo m�s de 90 �F. Utilizando la funci�n table contesta a qu� meses
# pertenecen los d�as m�s calurosos.

# h) La temperatura en el data.frame est� expresada en grados Fahrenheit, convierte la
# columna de temperaturas para que las mismas se expresen en grados Celsius.
# Ayuda: �C = (�F - 32)/1.8
# i) Elimina las filas que tienen al menos un valor NA. (ayuda: na.omit)

# 2) Generar una matriz de 5x10. Colocar dentro de cada posici�n la suma de la fila y de
# la columna de esa posici�n.
# a) Utiliz� un for dentro de otro for.
# b) No utilizar for.

# 3) Generar una matriz de 2x2 con n�meros enteros aleatorios.
# Generar otra matrix de 1x2 con n�meros enteros aleatorios.
# a) Calcular el producto matricial de las dos matrices, usando el operador %*%
# b) Escribir una funci�n que calcule el producto matricial de las dos matrices. Usando for anidados.

