var visualization = d3plus.viz()
.container("#encuentros_participacion_metropolitana")
.data("encuentros_participacion_metropolitana.json")
.type("scatter")
.width(false)
.height(false)
.resize(true)
.id(["comuna"])
.size("pob14_comuna")
.x("encuentros_poblacion")
.y("indice_participacion")
.color("color")
.format({
  "text": function(text, params) {
    if (text === "pob14_comuna") {
      return "Población de la comuna";
    }
    if (text === "encuentros_poblacion") {
      return "Encuentros locales por cada 10.000 habitantes";
    }
    if (text === "indice_participacion") {
      return "% de participación en elecciones municipales";
    }
    else {
      return d3plus.string.title(text, params);
    }
  },
  "number": function(number, params) {
    var formatted = d3plus.number.format(number, params);
    if (params.key === "indice_participacion") {
      return formatted + "%";
    }
    else {
      return formatted;
    }
  },
  "locale": "es_ES"
})
.font({"family": "Roboto"})
.title("Encuentros locales versus participación en elecciones en las comunas de la RM")
.tooltip(["pob14_comuna","indice_participacion","encuentros_poblacion"])
.aggs({"encuentros_poblacion":"mean"})
.messages({"branding":true})
.draw()