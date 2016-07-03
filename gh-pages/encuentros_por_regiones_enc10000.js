var data = "datos_totales.json";
var visualization = d3plus.viz()
.container("#encuentros_por_regiones_enc10000")
.data(data)
.type("treemap")
.width(false)
.height(false)
.resize(true)
.id(["region","comuna"])
.size("encuentros_poblacion_10000hab")
.color("color")
.format({
  "text": function(text, params) {
    if (text === "pob14_comuna") {
      return "Población";
    }
    if (text === "encuentros_poblacion") {
      return "Encuentros locales";
    }    
    if (text === "encuentros_poblacion_10000hab") {
      return "Encuentros locales por cada 10.000 habitantes";
    }
    if (text === "idh") {
      return "Índice de Desarrollo Humano"
    }
    else {
      return d3plus.string.title(text, params);
    }
  },
  "locale": "es_ES"
})
.font({"family": "Roboto"})
.title("Encuentros locales en comunas con más de 10.000 habitantes")
.title("Encuentros locales por región")
.title({"sub": "Divisiones de acuerdo a la cantidad de encuentros locales por cada 10.000 habitantes por zona geográfica respecto del total del país"})
.icon({"style": "knockout", "value": "image"})
.tooltip(["pob14_comuna","encuentros_poblacion_10000hab"])
.aggs({"encuentros_poblacion_10000hab":"mean"})
.legend(false)
.messages({"branding":true})
.draw()