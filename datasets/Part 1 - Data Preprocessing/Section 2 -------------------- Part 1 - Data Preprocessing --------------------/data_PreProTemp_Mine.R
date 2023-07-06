#Plantilla para el pre procesado de datos

#Importar el dataset
dataset = read.csv(file = "Data.csv")

#Tratamiento de los valores NA

dataset$Age  = ifelse(is.na(dataset$Age), 
                      ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                      dataset$Age)

dataset$Salary = ifelse(is.na(dataset$Salary), 
                      ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
                      dataset$Salary)

#Codificar las variables categoricas

dataset$Country = factor(dataset$Country,
                         levels = c("France","Spain","Germany"),
                         labels = c(1,2,3))

dataset$Purchased = factor(dataset$Purchased,
                         levels = c("No","Yes"),
                         labels = c(0,1))
#Dividir los datos en conjunto de entrenamiento y test

#instalar caTools
# sample.split() : está pensado para dividir un vector en 2 conjuntos preservando un ratio entre uno y otro
set.seed(123) #para configurar semilla aleatoria
split =  sample.split(dataset$Purchased, SplitRatio = 0.8)
# devuelve un vector del mismo tamaño q la variable a predecir,indicando si debe formar parte
# o no del conjunto de entrenamiento, TRUE = entrenar, FALSE = testing
#Una vez hecho el split, hay q dividir el datset en 2

training_set = subset(dataset, split==TRUE) #Conjunto de entrenamiento
testing_set = subset(dataset, split == FALSE) #Conj. de Testing

#Escalado de valores

training_set[,2:3 ] = scale(training_set[,2:3])
testing_set[,2:3 ] = scale(testing_set[,2:3 ])
