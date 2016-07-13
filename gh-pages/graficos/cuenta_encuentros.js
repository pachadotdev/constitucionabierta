var visualization = d3plus.viz()
.container("#cuenta_encuentros")
.data("graficos/cuenta_actas.json")
.type("line")
.width(false)
.height(500)
.resize(true)
.id(["name"])
.x({"value":"fecha","grid": false})
.time("fecha")
.timeline(false)
.y("cuenta")
.color("color")
.format({
  "text": function(text, params) {
    if (text === "cuenta") {
      return "Encuentros";
    }
    if (text === "cuenta_acumulada") {
      return "Encuentros a la fecha";
    }
    if (text === "fecha") {
      return "Fecha";
    }    
    else {
      return d3plus.string.title(text, params);
    }
  },
  "number": function(number, params) {
    var myLocale = {
      "decimal": ",",
      "thousands": ".",
      "grouping": [3],
      "currency": ["$", ""],
      "dateTime": "%a %b %e %X %Y",
      "date": "%m/%d/%Y",
      "time": "%H:%M:%S",
      "periods": ["AM", "PM"],
      "days": ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
      "shortDays": ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
      "months": ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
      "shortMonths": ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]
    };
    var localeFormatter = d3.locale(myLocale);
    var numberFormat = localeFormatter.numberFormat(",.3r");
    var formatted = d3plus.number.format(number, params);
      if (params.key === "cuenta_acumulada") {
        return numberFormat(number);
      }
      if (params.key === "cuenta") {
        return numberFormat(number);
      }
      else {
        return formatted;
      }
  },
  "locale": "es_ES"
})
.font({"family": "Roboto"})
.title("Encuentros locales")
.tooltip(["fecha","cuenta"])
.messages({"branding":true})
.draw()