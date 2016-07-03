setwd("~/constitucionabierta/archivos")
library(xlsx)
library(XLConnect)
library(d3plus)
library(plyr)
#d3plus()

colores <- c("#333333",colorRampPalette(c("#0054a4","#ed1c24","#fffa85","#fc7058","#6c82a3","#804a62"))(15))
write.csv(colores,"colores.csv")

datos_finales <- read.csv("sintesis_datos_pacha.csv")

datos_finales_metropolitana = readWorksheetFromFile("participacion_rm.xlsx", sheet = "Sheet1", region = "A1:D53")

encuentros_participacion_metropolitana = subset(datos_finales_metropolitana, pob14_comuna > 10000)
encuentros_participacion_metropolitana$color = "#717290"

datos_10000hab <- datos_finales[,c("region","comuna","pob14_comuna","encuentros_poblacion","encuentros_poblacion_10000hab","pcent_elas","pcent_votos","idh","color")]
datos_10000hab = subset(datos_10000hab, pob14_comuna > 10000)
datos_10000hab = datos_10000hab[order(datos_10000hab$pob14_comuna,decreasing = TRUE),]
datos_10000hab = datos_10000hab[order(datos_10000hab$encuentros_poblacion,decreasing = TRUE),]
datos_10000hab$comuna = ifelse(datos_10000hab$comuna == "Maule","Maule ",as.character(datos_10000hab$comuna))
datos_10000hab$comuna = ifelse(datos_10000hab$comuna == "Coquimbo","Coquimbo ",as.character(datos_10000hab$comuna))
datos_10000hab$comuna = ifelse(datos_10000hab$comuna == "Antofagasta","Antofagasta ",as.character(datos_10000hab$comuna))
datos_10000hab$comuna = ifelse(datos_10000hab$comuna == "Aisén","Aisén ",as.character(datos_10000hab$comuna))
datos_10000hab$comuna = ifelse(datos_10000hab$comuna == "Valparaíso","Valparaíso ",as.character(datos_10000hab$comuna))
datos_10000hab$comuna = as.factor(datos_10000hab$comuna)
datos_10000hab$region = as.factor(datos_10000hab$region)
write.xlsx(datos_10000hab[1:20,],"20_comunas_mas_grandes.xlsx")

datos_totales <- datos_finales[,c("region","comuna","pob14_comuna","encuentros_poblacion","encuentros_poblacion_10000hab","pcent_elas","pcent_votos","idh","color")]
datos_totales$comuna = ifelse(datos_totales$comuna == "Maule","Maule ",as.character(datos_totales$comuna))
datos_totales$comuna = ifelse(datos_totales$comuna == "Coquimbo","Coquimbo ",as.character(datos_totales$comuna))
datos_totales$comuna = ifelse(datos_totales$comuna == "Antofagasta","Antofagasta ",as.character(datos_totales$comuna))
datos_totales$comuna = ifelse(datos_totales$comuna == "Aisén","Aisén ",as.character(datos_totales$comuna))
datos_totales$comuna = ifelse(datos_totales$comuna == "Valparaíso","Valparaíso ",as.character(datos_totales$comuna))
datos_totales$comuna = as.factor(datos_totales$comuna)
datos_totales$region = as.factor(datos_totales$region)

resumen_por_region <- datos_finales[,c("region","pob14_comuna","encuentros_poblacion","pcent_elas","pcent_votos")]
resumen_por_region = aggregate(. ~ region, resumen_por_region, sum)
names(resumen_por_region)[names(resumen_por_region) == "pob14_comuna"] <- "pob_region"
resumen_por_region$encuentros_poblacion_10000hab = 10000*resumen_por_region$encuentros_poblacion/resumen_por_region$pob_region
resumen_por_region = join(resumen_por_region, unique(datos_finales[,c("region","color")]), by="region")
write.xlsx(resumen_por_region,"resumen_por_region.xlsx")

cuenta_actas = readWorksheetFromFile("cuenta_actas.xlsx", sheet="Sheet1", region = "D1:F68")
cuenta_actas$fecha = strptime(cuenta_actas$fecha, "%Y-%m-%d")
cuenta_actas$name = "Cuenta de actas"
cuenta_actas$color = "#0054A4"

#################

setwd("~/constitucionabierta/gh-pages")

encuentros_participacion_metropolitana_json <- toJSON(encuentros_participacion_metropolitana, pretty=TRUE)
write(encuentros_participacion_metropolitana_json, "encuentros_participacion_metropolitana.json")

datos_10000hab_json <- toJSON(datos_10000hab, pretty=TRUE)
write(datos_10000hab_json, "datos_10000hab.json")

datos_totales_json <- toJSON(datos_totales, pretty=TRUE)
write(datos_totales_json, "datos_totales.json")

resumen_por_region_json <- toJSON(resumen_por_region, pretty=TRUE)
write(resumen_por_region_json, "resumen_por_region.json")

cuenta_actas_json <- toJSON(cuenta_actas, pretty=TRUE)
write(cuenta_actas_json, "cuenta_actas.json")