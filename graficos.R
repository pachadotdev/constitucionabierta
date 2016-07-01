setwd("~/constitucionabierta")
library(XLConnect)

encuentros_participacion <- readWorksheetFromFile("encuentros_participacion.xlsx", sheet = "Sheet1", region = "A1:D53")
encuentros_participacion_json <- toJSON(encuentros_participacion, pretty=TRUE)

encuentros_idh <- readWorksheetFromFile("encuentros_idh.xlsx", sheet = "Sheet1", region = "A1:D39")
encuentros_idh_json <- toJSON(encuentros_idh, pretty=TRUE)

setwd("~/constitucionabierta/gh-pages")
library(d3plus)
d3plus()
write(encuentros_participacion_json, "encuentros_participacion.json")
write(encuentros_idh_json, "encuentros_idh.json")
