          var visualization = d3plus.viz()
          .container("#encuentros_participacion")
          .data("encuentros_participacion.json")
          .type("scatter")
          .width(false)
          .height(false)
          .resize(true)
          .id(["comuna"])
          .size("pob14_comuna")
          .x("encuentros_poblacion")
          .y("indice_participacion")
          .format({
            "text": function(text, params) {
              if (text === "pob14_comuna") {
                return "Población de la comuna";
              }
              if (text === "encuentros_poblacion") {
                return "Encuentros locales por cada 10,000 habitantes mayores de 14 años";
              }
              if (text === "indice_participacion") {
                return "Participación";
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
            }  
          })
          .font({"family": "Lato"})
          .title("Encuentros locales versus participación en elecciones en Santiago")
          .tooltip(["pob14_comuna","indice_participacion","encuentros_poblacion"])
          .draw()