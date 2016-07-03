var visualization = d3plus.viz()
.container("#cuenta_acumulada_actas")
.data("cuenta_actas.json")
.type("line")
.width(false)
.height(false)
.resize(true)
.id(["name"])
.x("fecha")
.time("fecha")
.y("cuenta_acumulada")
.format({
  "text": function(text, params) {
    if (text === "fecha") {
      return "Fecha";
    }
    if (text === "cuenta_acumulada") {
      return "Cuenta acumulada";
    }
    else {
      return d3plus.string.title(text, params);
    }
  },
  "locale": "es_ES"
})
.font({"family": "Roboto"})
.title("Cuenta acumulada de actas")
.tooltip(["fecha","cuenta_acumulada"])
.messages({"branding":true})
.draw()