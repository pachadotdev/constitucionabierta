var visualization = d3plus.viz()
.container("#encuentros_idh")
.data("encuentros_idh.json")
.type("scatter")
.width(false)
.height(false)
.resize(true)
.id(["comuna"])
.size("pob14_comuna")
.x("encuentros_poblacion")
.y("idh")
.format({
  "text": function(text, params) {
    if (text === "pob14_comuna") {
      return "Población de la comuna";
    }
    if (text === "encuentros_poblacion") {
      return "Encuentros locales por cada 10,000 habitantes mayores de 14 años";
    }
    if (text === "idh") {
      return "Índice de Desarrollo Humano"
    }
    else {
      return d3plus.string.title(text, params);
    }
  }  
})
.font({"family": "Lato"})
.title("Encuentros locales versus Índice de Desarrollo Humano")
.title({"sub": "Comunas con más de 10,000 habitantes mayores de 14 años"})
.tooltip(["pob14_comuna","idh","encuentros_poblacion"])
.ui([
  {
    "method": function(){
      visualization.csv(); // passing no values will download data as csv file
    },
    "value": ["Download as CSV"]
  }
])
.draw()