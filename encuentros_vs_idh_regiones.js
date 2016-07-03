var visualization = d3plus.viz()
.container("#encuentros_vs_idh_regiones")
.data("datos_totales.json")
.type("scatter")
.width(false)
.height(false)
.resize(true)
.id(["region","comuna"])
.size("pob14_comuna")
.x("encuentros_poblacion_10000hab")
.y("idh")
.color("color")
.depth(0)
.format({
  "text": function(text, params) {
    if (text === "pob14_comuna") {
      return "Población";
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
.title("Encuentros locales versus Índice de Desarrollo Humano por región")
.tooltip(["pob14_comuna","idh","encuentros_poblacion_10000hab"])
.aggs({"idh":"mean","encuentros_poblacion_10000hab":"mean"})
.legend(false)
.messages({"branding":true})
.draw()