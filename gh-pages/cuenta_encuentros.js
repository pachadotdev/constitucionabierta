var visualization = d3plus.viz()
.container("#cuenta_encuentros")
.data("cuenta_encuentros.json")
.type("line")
.width(false)
.height(false)
.resize(true)
.id(["name"])
.x({"value":"fecha","grid": false})
.time("fecha")
.timeline(false)
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
.title("Encuentros locales")
.tooltip(["fecha","cuenta"])
.messages({"branding":true})
.draw()