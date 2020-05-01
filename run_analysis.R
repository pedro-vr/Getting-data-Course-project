#Llammaos a la librería reshape 
library(reshape2)

#Obtenemos la data
rawData <- "/Users/pedrovela/Downloads/Getting-data-Course-project/rawData"
rawDataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
rawDataFile <- paste(rawData, "/", "rawData.zip", sep = "")
data_dir <- "/Users/pedrovela/Downloads/Getting-data-Course-project/data"

#Checamos si existe el directorio sino creamos uno
if (!file.exists(rawData)) {
  dir.create(rawData)
  download.file(url = rawDataURL, destfile = rawDataFile)
}
if (!file.exists(data_dir)) {
  dir.create(data_dir)
  unzip(zipfile = rawDataFile, exdir = data_dir)
}


#Combinamos los datos para el conjunto train
x_tr <- read.table(paste(sep = "", data_dir, "/UCI HAR Dataset/train/X_train.txt"))
y_tr <- read.table(paste(sep = "", data_dir, "/UCI HAR Dataset/train/Y_train.txt"))
s_tr <- read.table(paste(sep = "", data_dir, "/UCI HAR Dataset/train/subject_train.txt"))

#Combinamos los datos para el conjunto train
x_te <- read.table(paste(sep = "", data_dir, "/UCI HAR Dataset/test/X_test.txt"))
y_te <- read.table(paste(sep = "", data_dir, "/UCI HAR Dataset/test/Y_test.txt"))
s_te <- read.table(paste(sep = "", data_dir, "/UCI HAR Dataset/test/subject_test.txt"))

#Combinamos la data train y test
x_d <- rbind(x_tr, x_te)
y_d <- rbind(y_tr, y_te)
s_d <- rbind(s_tr, s_te)

#Cargamos la data del feature y de actividad
feat <- read.table(paste(sep = "", data_dir, "/UCI HAR Dataset/features.txt"))

#Obtenemos las etiquetas de actividad
label_a <- read.table(paste(sep = "", data_dir, "/UCI HAR Dataset/activity_labels.txt"))
label_a[,2] <- as.character(label_a[,2])

#Extraemos las columnas tipo feature y las columnas de la media y la deviación estándar
selected_cols <- grep("-(mean|std).*", as.character(feat[,2]))
selected_col_names <- feat[selected_cols, 2]
selected_col_names <- gsub("-mean", "Mean", selected_col_names)
selected_col_names <- gsub("-std", "Std", selected_col_names)
selected_col_names <- gsub("[-()]", "", selected_col_names)


#Extraemos la data por columnas y usamos nombres lo bastante descriptivos
x_d<- x_d[selected_cols]
combined_data <- cbind(s_d, y_d, x_d)
colnames(combined_data) <- c("Subject", "Activity", selected_col_names)

#Convertimos las variables a factores
combined_data$Activity <- factor(combined_data$Activity, levels = label_a[,1], labels = label_a[,2])
combined_data$Subject <- as.factor(combined_data$Subject)


#Generamos el nuevo conjunto de datos ya limpio
melt_data <- melt(combined_data, id = c("Subject", "Activity"))
tidy_data <- dcast(melt_data, Subject + Activity ~ variable, mean)

#Lo mandamos al escritorio de trabajo
write.table(tidy_data, "/Users/pedrovela/Downloads/Getting-data-Course-project/tidy_dataset.txt", row.names = FALSE, quote = FALSE)