var visualization = d3plus.viz()
.container("#encuentros_vs_participacion_regiones_active")
.data("datos_totales.json")
.type("scatter")
.width(false)
.height(false)
.resize(true)
.id(["region","comuna"])
.size("pob14_comuna")
.x("encuentros_poblacion_10000hab")
.y("pcent_votos")
.color("color")
.depth(0)
.format({
  "text": function(text, params) {
    if (text === "pob14_comuna") {
      return "Población";
    }
    if (text === "encuentros_poblacion") {
      return "Encuentros locales";
    }    
    if (text === "encuentros_poblacion_10000hab") {
      return "Encuentros locales por cada 10,000 habitantes";
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
.title("Encuentros locales versus participación en elecciones por región")
.tooltip(["pob14_comuna","pcent_votos","encuentros_poblacion_10000hab"])
.aggs({"encuentros_poblacion_10000hab":"mean"})
.legend(false)
.active({"value": function(d){ return d["pob14_comuna"] > 10000; }, "spotlight":true})
.messages({"branding":true})
.draw()