var visualization = d3plus.viz()
.container("#encuentros_vs_idh_comunas")
.data("datos_10000hab.json")
.type("scatter")
.width(false)
.height(false)
.resize(true)
.id(["region","comuna"])
.size("pob14_comuna")
.x("encuentros_poblacion_10000hab")
.y("idh")
.color("color")
.depth(1)
.format({
  "text": function(text, params) {
    if (text === "pob14_comuna") {
      return "Población de la comuna";
    }
    if (text === "encuentros_poblacion_10000hab") {
      return "Encuentros locales por cada 10,000 habitantes mayores de 14 años";
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
.font({"family": "Lato"})
.title("Encuentros locales versus Índice de Desarrollo Humano por comuna")
.title({"sub": "Considerando comunas con más de 10.000 habitantes mayores de 14 años"})
.tooltip(["pob14_comuna","idh","encuentros_poblacion_10000hab"])
.legend(false)
.draw()