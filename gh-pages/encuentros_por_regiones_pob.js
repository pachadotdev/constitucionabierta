var data = "datos_totales.json";
var visualization = d3plus.viz()
.container("#encuentros_por_regiones_pob")
.data(data)
.type("treemap")
.width(false)
.height(false)
.resize(true)
.id(["region","comuna"])
.size("pob14_comuna")
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
.title("Encuentros locales por región")
.title({"sub": "Divisiones de acuerdo a la población por zona geográfica respecto del total del país"})
.icon({"style": "knockout", "value": "image"})
.tooltip(["pob_region","encuentros_poblacion","encuentros_poblacion_10000hab"])
.aggs({"encuentros_poblacion_10000hab":"mean"})
.legend(false)
.messages({"branding":true})
.draw()