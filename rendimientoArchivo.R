
# To call the libraries 
library(readxl)
library(stringr)
library(stringi)

## 1. Preparar los datos de rendimiento para el análisis

#### Fijar el espacio de trabajo y conocer el nombre de las hojas que contiene el archivo
        
##### To set the work directory
setwd('C:/Users/LVARGAS/Documents/CIMMYT/dataBase/2017/limpieza_Datos_2017')

##### To call the name of the sheet in the workbook
riegos <- read_excel('basedatosBem2017.xlsx', '20_riegos_Descripcion')
caracteristicasBitNA <- read_excel('basedatosBem2017.xlsx', '01_caracteristicas Bitácora')
parcelasNA <- read_excel('basedatosBem2017.xlsx', '04_parcelas')

##### Obtener los datos de la tabla de rendimiento

rendimientoRaw <- read_excel('basedatosBem2017.xlsx', '24_rendimiento')
names(rendimientoRaw)
dim(rendimientoRaw)
tail(rendimientoRaw)

##### Eliminar registros NA y los registros de Áreas de Impacto

valoresNA <- is.na(rendimientoRaw[,1])
rendimientoNA <- rendimientoRaw[!valoresNA,]
dim(rendimientoNA)
rendimiento <- rendimientoNA[rendimientoNA$`Tipo de parcela (testigo o innovación)` != 'Parcela Área de Impacto',]
unique(rendimiento$`Tipo de parcela (testigo o innovación)`)

#####Filtrar por nombre de cultivos y realizar el subset de los datos del cultivo

#*************************************************************
#*************************************************************
# ESCRIBIR ABAJO EL NOMBRE DEL CULTIVO
cultivos <- c('Maiz', 'Trigo', 'Cebada', 'Frijol', 'Sorgo')
#*************************************************************
#*************************************************************

for(cultivo in cultivos){

        #### Conocer el nombre de los cultivos registrados por el usuario
        unique(rendimiento$`Nombre del cultivo cosechado`)
        
        ####^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        #### Obtener el valor de la variable nomCultivo, de acuerdo a los cultivos registrados
        if(cultivo == 'Maiz'){
                nomCultivo <- c('Maíz','MAIZ CRIOLLO', 'maiz amarillo', 'maiz grande', 'Maíz tabasqueña')
                leyenda <- paste('EL cultivo que se analizara es:', cultivo); print(leyenda)
                
        }else if(cultivo == 'Trigo'){
                nomCultivo <- 'Trigo'
                leyenda <- paste('EL cultivo que se analizara es:', cultivo); print(leyenda)
                
        }else if(cultivo == 'Cebada'){
                nomCultivo <- 'Cebada'
                leyenda <- paste('EL cultivo que se analizara es:', cultivo); print(leyenda)
                
        }else if(cultivo == 'Frijol'){
                nomCultivo <- 'Frijol'
                leyenda <- paste('EL cultivo que se analizara es:', cultivo); print(leyenda)
                
        }else if(cultivo == 'Sorgo'){
                nomCultivo <- 'Sorgo'
                leyenda <- paste('EL cultivo que se analizara es:', cultivo); print(leyenda)
                
        }  
        
        #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        
        names(rendimiento)
        renCultivo <- rendimiento[rendimiento[,10] %in% nomCultivo,]
        for(i in renCultivo$`Nombre del cultivo cosechado`) renCultivo$`Nombre del cultivo cosechado` <- cultivo
        dim(renCultivo)
        names(renCultivo)
        
        #### Filtrar los datos de acuerdo al producto de interés económico 
        
        unique(renCultivo$`Nombre del producto de interés económico obtenido`)
        
        ####^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        #### Filtrar el valor de productor de interes economico a GRANO
        
        if(cultivo == 'Maiz'){
                producto <- 'Grano';leyenda <- paste('El producto de interes economico es:', producto); print(leyenda)
                
        }else if(cultivo == 'Trigo'){
                producto <- c('Grano', 'semilla');leyenda <- paste('El producto de interes economico es:', producto); print(leyenda)
                
        }else if(cultivo == 'Cebada'){
                producto <- 'Grano';leyenda <- paste('El producto de interes economico es:', producto); print(leyenda)
                
        }else if(cultivo == 'Frijol'){
                producto <- 'Grano';leyenda <- paste('El producto de interes economico es:', producto); print(leyenda)
                
        }else if(cultivo == 'Sorgo'){
                producto <- 'Grano';leyenda <- paste('El producto de interes economico es:', producto); print(leyenda)
                
        } 
        
        #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        
        renCultivoProductoRaw <- renCultivo[renCultivo[,14] %in% producto,]
        dim(renCultivoProductoRaw)
        unique(renCultivoProductoRaw$`Nombre del producto de interés económico obtenido`)
        for(i in renCultivoProductoRaw$`Nombre del producto de interés económico obtenido`) renCultivoProductoRaw$`Nombre del producto de interés económico obtenido` <- 'Grano'
        
        head(renCultivoProductoRaw)
        
        valoresNA <- is.na(renCultivoProductoRaw[,14])
        renCultivoProducto <- renCultivoProductoRaw[!valoresNA,]
        dim(renCultivoProducto)
        
        #### Filtrar los datos de acuerdo a las unidades de medida en que se reporta el rendimeinto
        
        unique(renCultivoProducto$`Unidad de medida de rendimiento para el producto de interés económico obtenido`)
        names(renCultivoProducto)
        
        ####^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        #### Agregar las respuestas de unidad de medida en que es reportado el rendimiento 
        
        #unique(rendimiento[rendimiento$`Nombre del producto de interés económico obtenido` == 'Grano',15])
        nomUnidad <- c('tonelada/ha','kg/ha', 'kilogramos', 'kg', 'kilogramos/ Ha', 'kilogramos /ha', 
                       '(4) tonelada / ha', 'kg/ha', '(4) tonelada /ha', 'KILOGRAMO', 'kilo')
        
        #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        
        renCultivoProductoUnidadRaw <- renCultivoProducto[renCultivoProducto[,15] %in% nomUnidad,]
        for(i in renCultivoProductoUnidadRaw$`Unidad de medida de rendimiento para el producto de interés económico obtenido`) renCultivoProductoUnidadRaw$`Unidad de medida de rendimiento para el producto de interés económico obtenido` <- 't/ha' 
        dim(renCultivoProductoUnidadRaw)
        names(renCultivoProductoUnidadRaw)
        
        boxplot(renCultivoProducto$`Rendimiento real (unidad/ha)`)
        
        ##### Corregir los datos de rendimiento capturados como kilos en lugar de toneladas. Almacenarlos un una nueva variable
        
        valoresNA <- is.na(renCultivoProductoUnidadRaw[,20])
        renCultivoProductoUnidad <- renCultivoProductoUnidadRaw[!valoresNA,]
        numObservacionesTotal <- dim(renCultivoProductoUnidad)[1]
        ###############################################################################################
        # Funcion para encontrar valores extremo superior y extremo inferior
        
        count = 0  
        
        for(i in renCultivoProductoUnidad$`Rendimiento real (unidad/ha)`){
                
                resultado = i/1000
                #print(resultado)
                
                if(count == 0){
                        
                        if(resultado < 0.09){
                                
                                nRendimiento = i
                                
                        }else{
                                
                                nRendimiento = resultado
                                
                        }
                }else{
                        if(resultado < 0.09){
                                
                                nRendimiento = c(nRendimiento, i)
                                
                        }else{
                                
                                nRendimiento = c(nRendimiento, resultado)
                                
                        }
                        
                }
                
                count = count + 1
                
        }
        
        ###############################################################################################
        
        #print(nRendimiento)
        
        #boxplot(nRendimiento)
        
        length(nRendimiento)
        
        renCultivoProductoUnidad$rendimeintoCorregido <- nRendimiento
        
        head(renCultivoProductoUnidad)
        
        tail(renCultivoProductoUnidad)
        
        boxplot(renCultivoProductoUnidad$rendimeintoCorregido)
        
        
        dim(renCultivoProductoUnidad)
        
        ####^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        #### Eliminar los valores de rendimiento que esten por encima del record mundial
        
        if(cultivo == 'Maiz'){
                rendRecord <- 27.5# http://www.genesis.ag/world-record-corn-yield/ 
                
        }else if(cultivo == 'Trigo'){
                rendRecord <- 16.519 # http://www.guinnessworldrecords.com/world-records/highest-wheat-yield
                
        }else if(cultivo == 'Cebada'){
                rendRecord <- 13.8 # http://esp.greatplainsmfg.com/es/testimonials/9908/la-sembradora-detr%C3%A1s-del-record-mundial-en-rendimiento-de-cebada
                
        }else if(cultivo == 'Frijol'){
                rendRecord <- 11.5 # record soya 
                
        }else if(cultivo == 'Sorgo'){
                rendRecord <- 16.13 # http://www.kylesconverter.com/area-density/tonnes-per-hectare-to-bushels-per-acre
                
        } 
        
        #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        
        renCultivoProductoUnidadv1 <- renCultivoProductoUnidad[renCultivoProductoUnidad$rendimeintoCorregido < rendRecord,]
        boxplot(renCultivoProductoUnidadv1$rendimeintoCorregido ~ renCultivoProductoUnidadv1$`Tipo de parcela (testigo o innovación)`)
        
        numObservacionesFinal <- dim(renCultivoProductoUnidadv1)[1]
        
        ## 2. Agregar datos adicionales a la trabla de rendimeinto
        
        ##### Agregar el tipo de produccion de acuerdo al conteo de número de riegos
        
        tipobitRiegos <- unique(riegos$`ID de tipo de bitácora (clave foránea)`)
        length(tipobitRiegos)
        
        #### Buscar si el id de la bitacora se encuentra en la lista de bitacoras con riego
        #### El resultado se almacena en un vector con los valors TRUE y NA
        count = 0
        for(tipoBitacora in renCultivoProductoUnidadv1$`ID de tipo de bitácora (clave foránea)`){
                resultado = any(tipobitRiegos == tipoBitacora)
                if(count == 0){
                        
                        sumResultado = resultado
                }else{
                        
                        sumResultado = c(sumResultado, resultado)  
                }
                
                count = count + 1
                
                
        }
        
        
        #length(sumResultado)
        #length(renCultivoProductoUnidadv1$`ID de tipo de bitácora (clave foránea)`)
        #### convertir los valores de vector en True = Riego y NA = Temporal
        tipoProduccion <- transform(sumResultado,sumResultado = ifelse(is.na(sumResultado),'Temporal','Riego'))
        
        #### Agregar el tipo de produccion en la tabla renCultivoProductoUnidadv1
        
        renCultivoProductoUnidadv1$tipoProduccion <- tipoProduccion$sumResultado
        
        ##### Agregar los datos de parcelas
        valoresNA <- is.na(caracteristicasBitNA[,1])
        caracteristicasBit <- caracteristicasBitNA[!valoresNA,]
        dim(caracteristicasBit)
        names(caracteristicasBit)
        caracteIdParcela <- caracteristicasBit[,c(1, 4, 6, 9)]
        names(caracteIdParcela)[4] <- 'ID de la parcela'
        dim(caracteIdParcela)
        
        tail(parcelasNA)
        valoresNA <- is.na(parcelasNA[,1])
        parcelasRaw <- parcelasNA[!valoresNA,]
        parcelas <- unique(parcelasRaw)
        names(parcelas)
        dim(parcelas)
        parcelasLoc <- parcelas[,c(1,6,7,8,9,10,11,14,16,17)]
        names(parcelasLoc)[1] <- 'ID de la parcela'
        names(parcelasLoc)
        
        idBitPar <- merge(caracteIdParcela, parcelasLoc, by = 'ID de la parcela', all.x=TRUE)
        dim(idBitPar)
        names(idBitPar)
        
        idBitUbicacion <- idBitPar[,c(2, 1, 3, 4, 6, 8, 11, 12, 13)]
        names(idBitUbicacion)[1] <- 'ID de la bitácora'
        
        #### Agregar datos ubicacion a rendimiento
        names(renCultivoProductoUnidadv1)[1] <- 'ID de la bitácora'
        renCultivoProductoUnidadUbicacion <- merge(renCultivoProductoUnidadv1, idBitUbicacion, by = 'ID de la bitácora', all.x = TRUE)
        
        renCultivoProductoUnidadUbicacion$`¿El cultivo cosechado es activo en la base de datos?` <- NULL
        renCultivoProductoUnidadUbicacion$`¿El cultivo cosechado es aprobado en la base de datos?` <- NULL
        names(renCultivoProductoUnidadUbicacion)
        
        #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        #^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Guardar cada observacion de rendimiento ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        
        renCultivoProductoUnidadUbicacionSD <- renCultivoProductoUnidadUbicacion[!duplicated(renCultivoProductoUnidadUbicacion[,2]), ]
        
        rendimientoCompleto <- renCultivoProductoUnidadUbicacionSD
        
        rendimientoCompleto$`Rendimineto estimado (unidad/ha)` <- NULL
        rendimientoCompleto$`Rendimiento real (unidad/ha)` <- NULL
        
        names(rendimientoCompleto)[20] <- 'Rendimiento (t/ha)'
        names(rendimientoCompleto)
        
        
        ############################################################################
        ##################################### PROMEDIOS ############################
        
        #### Realizar el resumen de rendimiento y conteo de observaciones
        promediosMunicipio <- with(rendimientoCompleto, aggregate(`Rendimiento (t/ha)`, by = list(Estado, Municipio, Año, `Ciclo agronómico`, tipoProduccion), FUN = function(rendimeintoCorregido) c(Promedio = mean(rendimeintoCorregido), Conteo = length(rendimeintoCorregido) )))
        
        names(promediosMunicipio) <- c('Estado', 'Municipio', 'Año', 'Ciclo agrónomico', 'Tipo de producción', 'Rendimiento (t/ha)')
        
        promediosMunicipio <- promediosMunicipio[,c(3, 4, 1, 2, 5, 6)]
        
        promediosEstado <- with(rendimientoCompleto, aggregate(`Rendimiento (t/ha)`, by = list(Estado, Año, `Ciclo agronómico`, tipoProduccion), FUN = function(rendimeintoCorregido) c(Promedio = mean(rendimeintoCorregido), Conteo = length(rendimeintoCorregido) )))
        
        names(promediosEstado) <- c('Estado', 'Año', 'Ciclo agrónomico', 'Tipo de producción', 'Rendimiento (t/ha)')
        
        promediosEstado <- promediosEstado[,c(3, 4, 1, 2, 5)]
        
        promediosHub <- with(rendimientoCompleto, aggregate(`Rendimiento (t/ha)`, by = list(`Nombre del Hub`, Año, `Ciclo agronómico`, tipoProduccion), FUN = function(rendimeintoCorregido) c(Promedio = mean(rendimeintoCorregido), Conteo = length(rendimeintoCorregido) )))
        
        names(promediosHub) <- c('Hub', 'Año', 'Ciclo agrónomico', 'Tipo de producción', 'Rendimiento (t/ha)')
        
        promediosHub <- promediosHub[,c(3, 4, 1, 2, 5)]
        
        
        ##### Almacenar los datos de rendimiento obtenidos
        
        carpetaAlmacenamiento <- './rendimientoArchivo_salida'
        
        if(!dir.exists(carpetaAlmacenamiento)){dir.create(carpetaAlmacenamiento)}
        
        nombreArchivoMunicipio <- paste(carpetaAlmacenamiento, '/', cultivo,'_Municipio','.csv')
        nombreArchivoMunicipio <- str_replace_all(nombreArchivoMunicipio, pattern=" ", repl="")
        write.csv(promediosMunicipio, file = nombreArchivoMunicipio, row.names = FALSE)
        
        nombreArchivoEstado <- paste(carpetaAlmacenamiento, '/', cultivo,'_Estado','.csv')
        nombreArchivoEstado <- str_replace_all(nombreArchivoEstado, pattern=" ", repl="")
        write.csv(promediosEstado, file = nombreArchivoEstado, row.names = FALSE)
        
        nombreArchivoHub <- paste(carpetaAlmacenamiento, '/', cultivo,'_Hub','.csv')
        nombreArchivoHub <- str_replace_all(nombreArchivoHub, pattern=" ", repl="")
        write.csv(promediosHub, file = nombreArchivoHub, row.names = FALSE)
        
        names(rendimientoCompleto)
        rendimientoCompleto <- rendimientoCompleto[,c(1, 2, 4, 10, 12, 13, 18, 20:29)]
        
        nombreArchivoCompleta <- paste(carpetaAlmacenamiento, '/', cultivo,'Completa','.csv')
        nombreArchivoCompleta <- str_replace_all(nombreArchivoCompleta, pattern=" ", repl="")
        write.csv(rendimientoCompleto, file = nombreArchivoCompleta, row.names = FALSE)
        
}


#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Crear un solo archivo ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
conteo = 0
for(cultivo in cultivos){
        
        nombreArchivoCompleto <- paste(carpetaAlmacenamiento, '/', cultivo,'Completa','.csv')
        nuevoNombreArchivoCompleto <- str_replace_all(nombreArchivoCompleto, pattern=" ", repl="")
        print(nuevoNombreArchivoCompleto)
       
        cultivoRendimiento <- read.csv(nuevoNombreArchivoCompleto)
        print(dim(cultivoRendimiento))
        
        if(conteo == 0){
                
                rendimientoCultivo <- cultivoRendimiento
                
        }else{
                
                rendimientoCultivo <- rbind(rendimientoCultivo, cultivoRendimiento)
                
        }
        
        conteo = conteo + 1 
        
}


dim(rendimientoCultivo)
names(rendimientoCultivo)
duplicados <- rendimientoCultivo[!duplicated(rendimientoCultivo[,2]), ]
dim(duplicados)


if(!dir.exists(carpetaAlmacenamiento)){dir.create(carpetaAlmacenamiento)}
nombreArchivoCompleto <- paste(carpetaAlmacenamiento,'/','rendimientoCultivosTodos.csv')
nombreArchivoCompleto <- str_replace_all(nombreArchivoCompleto, pattern=" ", repl="")
write.csv(rendimientoCultivo, file = nombreArchivoCompleto , row.names = FALSE)


#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^