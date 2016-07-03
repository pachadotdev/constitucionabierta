var visualization = d3plus.viz()
.container("#encuentros_vs_participacion_comunas")
.data("datos_10000hab.json")
.type("scatter")
.width(false)
.height(false)
.resize(true)
.id(["region","comuna"])
.size("pob14_comuna")
.x("encuentros_poblacion_10000hab")
.y("pcent_votos")
.color("color")
.depth(1)
.format({
  "text": function(text, params) {
    if (text === "pob14_comuna") {
      return "Población";
    }
    if (text === "encuentros_poblacion_10000hab") {
      return "Encuentros locales por cada 10.000 habitantes";
    }
    if (text === "pcent_votos") {
      return "% de participación en elecciones presidenciales";
    }
    else {
      return d3plus.string.title(text, params);
    }
  },
  "number": function(number, params) {
    var formatted = d3plus.number.format(number, params);
    if (params.key === "pcent_votos") {
      return formatted + "%";
    }
    else {
      return formatted;
    }
  },
  "locale": "es_ES"
})
.font({"family": "Roboto"})
.title("Encuentros locales versus participación en elecciones por comuna")
.title({"sub":"Considerando comunas con población de más de 10.000 habitantes"})
.tooltip(["pob14_comuna","pcent_votos","encuentros_poblacion_10000hab"])
.aggs({"encuentros_poblacion_10000hab":"mean"})
.legend(false)
.messages({"branding":true})
.draw()