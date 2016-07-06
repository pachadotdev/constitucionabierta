var visualization = d3plus.viz()
.container("#encuentros_vs_participacion_regiones_active")
.data("datos_totales.json")
.type("scatter")
.width(false)
.height(false)
.resize(true)
.id(["region","comuna"])
.size("poblacion")
.x("encuentros_10000hab")
.y("pcent_votos")
.color("color")
.depth(0)
.format({
  "text": function(text, params) {
    if (text === "poblacion") {
      return "Población";
    }
    if (text === "encuentros") {
      return "Encuentros locales";
    }    
    if (text === "encuentros_10000hab") {
      return "Encuentros locales por cada 10.000 habitantes";
    }
    if (text === "idh") {
      return "Índice de Desarrollo Humano";
    }
    if (text === "pcent_votos") {
      return "Porcentaje de votos";
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
    var numberFormat = localeFormatter.numberFormat(",.2r");
    var formatted = d3plus.number.format(number, params);
      if (params.key === "encuentros") {
        return numberFormat(number);
      }
      if (params.key === "poblacion") {
        return numberFormat(number);
      }
      if (params.key === "pcent_votos") {
        return numberFormat(number) + "%";
      }
      else {
        return formatted;
      }
  },
  "locale": "es_ES"
})
.font({"family": "Roboto"})
.title("Encuentros locales versus participación en elecciones presidenciales por regiones")
/*.title({"sub":"Considerando comunas con población de más de 10.000 habitantes"})*/
.tooltip(["encuentros"])
.tooltip({"share": false})
.legend(false)
.messages({"branding":true})
.aggs({"idh":"mean","encuentros_10000hab":"mean"})
.active({"value": function(d){ return d["poblacion"] > 10000; }, "spotlight":true})
.draw();