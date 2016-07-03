var visualization = d3plus.viz()
.container("#cuenta_actas")
.data("cuenta_actas.json")
.type("line")
.width(false)
.height(false)
.resize(true)
.id(["name"])
.x({"value":"fecha","grid": false})
.time("fecha")
.y("cuenta")
.color("color")
.format({
  "text": function(text, params) {
    if (text === "fecha") {
      return "Fecha";
    }
    if (text === "cuenta") {
      return "Cuenta";
    }
    else {
      return d3plus.string.title(text, params);
    }
  },
  "locale": "es_ES"
})
.font({"family": "Roboto"})
.title("Cuenta de actas")
.tooltip(["fecha","cuenta"])
.messages({"branding":true})
.draw()