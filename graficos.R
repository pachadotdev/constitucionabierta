setwd("~/constitucionabierta")
library(XLConnect)
library(d3plus)
#d3plus()

colores <- c("#333333",colorRampPalette(c("#0054a4","#ed1c24","#fffa85","#fc7058","#6c82a3","#804a62"))(15))
write.csv(colores,"colores.csv")

datos_finales <- read.csv("sintesis_datos_pacha.csv")

datos_finales_metropolitana = readWorksheetFromFile("participacion_rm.xlsx", sheet = "Sheet1", region = "A1:D53")

encuentros_participacion_metropolitana = subset(datos_finales_metropolitana, pob14_comuna > 10000)
encuentros_participacion_metropolitana$color = "#717290"

comunas_10000hab <- datos_finales[,c("region","comuna","pob14_comuna","encuentros_poblacion_10000hab","color")]
comunas_10000hab = subset(comunas_10000hab, pob14_comuna > 10000)
comunas_10000hab = comunas_10000hab[order(comunas_10000hab$pob14_comuna,decreasing = TRUE),]
comunas_10000hab = comunas_10000hab[order(comunas_10000hab$encuentros_poblacion,decreasing = TRUE),]
comunas_10000hab = comunas_10000hab[1:20,]
comunas_10000hab$comuna = ifelse(comunas_10000hab$comuna == "Maule","Maule ",as.character(comunas_10000hab$comuna))
comunas_10000hab$comuna = ifelse(comunas_10000hab$comuna == "Coquimbo","Coquimbo ",as.character(comunas_10000hab$comuna))
comunas_10000hab$comuna = ifelse(comunas_10000hab$comuna == "Antofagasta","Antofagasta ",as.character(comunas_10000hab$comuna))
comunas_10000hab$comuna = ifelse(comunas_10000hab$comuna == "Aisén","Aisén ",as.character(comunas_10000hab$comuna))
comunas_10000hab$comuna = as.factor(comunas_10000hab$comuna)
comunas_10000hab$region = as.factor(comunas_10000hab$region)

regiones_10000hab <- datos_finales[,c("region","comuna","pob14_comuna","encuentros_poblacion_10000hab","pcent_elas","pcent_votos","color")]
#regiones_10000hab = subset(regiones_10000hab, pob14_comuna > 10000)
regiones_10000hab = regiones_10000hab[order(regiones_10000hab$pob14_comuna,decreasing = TRUE),]
regiones_10000hab = regiones_10000hab[order(regiones_10000hab$encuentros_poblacion,decreasing = TRUE),]
#regiones_10000hab = regiones_10000hab[1:20,]
regiones_10000hab$comuna = ifelse(regiones_10000hab$comuna == "Maule","Maule ",as.character(regiones_10000hab$comuna))
regiones_10000hab$comuna = ifelse(regiones_10000hab$comuna == "Coquimbo","Coquimbo ",as.character(regiones_10000hab$comuna))
regiones_10000hab$comuna = ifelse(regiones_10000hab$comuna == "Antofagasta","Antofagasta ",as.character(regiones_10000hab$comuna))
regiones_10000hab$comuna = ifelse(regiones_10000hab$comuna == "Aisén","Aisén ",as.character(regiones_10000hab$comuna))
regiones_10000hab$comuna = ifelse(regiones_10000hab$comuna == "Valparaíso","Valparaíso ",as.character(regiones_10000hab$comuna))
regiones_10000hab$comuna = as.factor(regiones_10000hab$comuna)
regiones_10000hab$region = as.factor(regiones_10000hab$region)

encuentros_idh_10000hab <- datos_finales[,c("region","comuna","pob14_comuna","encuentros_poblacion_10000hab","idh","color")]
encuentros_idh_10000hab = subset(encuentros_idh_10000hab, pob14_comuna > 10000)

encuentros_participacion_10000hab <- datos_finales[,c("region","comuna","pob14_comuna","encuentros_poblacion_10000hab","pcent_votos","color")]
encuentros_participacion_10000hab = subset(encuentros_participacion_10000hab, pob14_comuna > 10000)

elas_votos_10000hab <- datos_finales[,c("region","comuna","pob14_comuna","pcent_elas","pcent_votos","color")]
elas_votos_10000hab = subset(elas_votos_10000hab, pob14_comuna > 10000)

#################

setwd("~/constitucionabierta/gh-pages")

encuentros_participacion_metropolitana_json <- toJSON(encuentros_participacion_metropolitana, pretty=TRUE)
write(encuentros_participacion_metropolitana_json, "encuentros_participacion_metropolitana.json")

comunas_10000hab_json <- toJSON(comunas_10000hab, pretty=TRUE)
write(comunas_10000hab_json, "comunas_10000hab.json")

regiones_10000hab_json <- toJSON(regiones_10000hab, pretty=TRUE)
write(regiones_10000hab_json, "regiones_10000hab.json")

encuentros_idh_10000hab_json <- toJSON(encuentros_idh_10000hab, pretty=TRUE)
write(encuentros_idh_10000hab_json, "encuentros_idh_10000hab.json")

encuentros_participacion_10000hab_json <- toJSON(encuentros_participacion_10000hab, pretty=TRUE)
write(encuentros_participacion_10000hab_json, "encuentros_participacion_10000hab.json")

elas_votos_10000hab_json <- toJSON(elas_votos_10000hab, pretty=TRUE)
write(elas_votos_10000hab_json, "elas_votos_10000hab.json")
