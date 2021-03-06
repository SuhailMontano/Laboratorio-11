# Hecho con gusto por Suhail Monta�o S�nchez (UAEH)

# LABORATORIO - Tidy data -datos ordenados- PARTE 1,2 y 3.

# Objetivo: Introducci�n pr�ctica a los datos ordenados (o tidy data) y a las herramientas que provee el paquete tidyr.
# --------------------------------------------------------------------------------------------------------------------
# En este ejercicio vamos a:
# 1. Cargar datos (tibbles)
# 2. Converir nuestros tiblles en dataframes (para su exportaci�n)
# 3. Exportar dataframes originales
# 4. Pivotar tabla 4a
# 5. Exportar resutltado (TABLA PIVOTANTE)
# 6. Separar y unir tablas



#############################################
#LABORATORIO: Tidy data (datos ordenados) 1 #
#############################################
#Prerrequisitos
#instalar paquete tidyverse
#install.packages("tidyverse")


#instalar paquete de datos

#install.packages("remotes")
#remotes::install_github("cienciadedatos/datos")
#install.packages("datos")

#Cargar paquete tidyverse
library(tidyverse)

#Cargar paquete de datos
library(datos)


#tabla 1 hasta tabla 4b
#ver datos como tibble 
datos::tabla1
datos::tabla2
datos::tabla3
datos::tabla4a
datos::tabla4b


#ver datos como dataframe 
df1<-data_frame(tabla1)
df2<-data_frame(tabla2)
df3<-data_frame(tabla3)
df4a<-data_frame(tabla4a)
df4b<-data_frame(tabla4b)
view(df1)
view(df2)
view(df3)
view(df4a)
view(df4b)


#exportar los dataframes originales
write.csv(df1, file="df1.csv")
write.csv(df2, file="df2.csv")
write.csv(df3, file="df3.csv")
write.csv(df4a, file="df4a.csv")
write.csv(df4b, file="df4b.csv")




vignette("tibble")
#explicaci�n de tibble




# Ordenar datos con la tabla4a (PIVOTAR)
t4a_PIVOTANTE=tabla4a %>% 
  pivot_longer(cols=c ('1999','2000'), names_to="anio", "values_to=casos")


# Exportar resultado: tabla ordenada
write.csv(t4a_PIVOTANTE, file="t4a_PIVOTANTE.csv")

######PARTE 2######
####################
#                  #
#     Tidy data    #
#                  #
####################


#EJERCICIO 2: PIVOTAR Y UNIR TABLAS
#PARTE 2
# ver tabla4b

view(df4b)

# 1. Pivotar tabla 4b "A LO LARGO"

t4b_PIVOTANTE=tabla4b %>% 
  pivot_longer(cols=c ('1999','2000'), names_to="anio", "values_to=casos")

# Unir tablas ordenadas

union_t4=left_join(t4a_PIVOTANTE, t4b_PIVOTANTE)
View(union_t4)

# Exportar resultado: tabla4a + tabla4b (ordenada)

write.csv(union_t4,file="union_t4.csv")

#EJERCICIO 3: DATOS ANCHOS CON TABLA 2
# 1. Pivotar tabla 2 "A LO ANCHO"


#VER TABLA 2
view(df2)

# Ordenar datos con la tabla 2 (PIVOTAR a lo ANCHO)

t2_ancha=tabla2 %>% 
  pivot_wider(names_from = tipo, values_from=cuenta)

view(t2_ancha)
view(df2)

# Exportar resultado: tabla ordenada
write.csv(t2_ancha, file="t2_ancha.csv")

######PARTE 3######
####################
#                  #
#     Tidy data    #
#                  #
####################

#La tabla3, que tiene un problema diferente:
#tenemos una columna (tasa) que contiene dos variables (casos y poblacion).

#vER TABLA 3
view(df3)

#Separaci�n 1
# Separar casos y poblaci�n por default
SEPARADO_1<-tabla3 %>% 
  separate(tasa, into = c("casos", "poblacion"))


view(SEPARADO_1)
# separaci�n 2
# Separar casos y poblaci�n por caracter "/" "*" "-"
view(df3)

SEPARADO_2<-tabla3 %>% 
  separate(tasa, into = c("casos", "poblacion"),sep="/")

view(SEPARADO_2)
#separaci�n 3
# Separar siglo y a�o de la columna "anio" 
view(df3)


SEPARADO_3<-tabla3 %>% 
  separate(anio, into = c("siglo", "anio"), sep = 2)



# AHORA VAMOS A UNIR LA TABLA GENERADA ANTERIORMENTE
# VER TABLA "SEPARADO 3"
view(SEPARADO_3)

#Podemos usar unite() para unir las columnas siglo y anio creadas en el ejemplo anterior

UNION_1=SEPARADO_3 %>% 
  unite(nueva, siglo, anio)

view(UNION_1)
# En este caso tambi�n necesitamos el argumento sep. Por defecto,
#pondr� un gui�n bajo (_) entre los valores de las distintas columnas. Si no queremos ning�n separador usamos ""

UNION_2=SEPARADO_3 %>% 
  unite(nueva, siglo, anio, sep="")

view(UNION_2)


