var visualization = d3plus.viz()
.container("#siete_conceptos")
.data("graficos/7conceptos_data.json")
.edges("graficos/7conceptos_edges.json")
.nodes("graficos/7conceptos_nodes.json")
.type("network")
.width(800)
.height(500)
.resize(true)
.id(["comuna"])
.size("value")
.font({"family": "Roboto"})
.labels({"align": "center", "valign": "middle"})
.depth(0)
.format({
  "text": function(text, params) {
    
    if (text === "concepto1") {
      return "Concepto 1";
    }
    if (text === "concepto2") {
      return "Concepto 2";
    }
    if (text === "concepto3") {
      return "Concepto 3";
    }
    if (text === "concepto4") {
      return "Concepto 4";
    }
    if (text === "concepto5") {
      return "Concepto 5";
    }
    if (text === "concepto6") {
      return "Concepto 6";
    }
    if (text === "concepto7") {
      return "Concepto 7";
    }
    else {
      return d3plus.string.title(text, params);
    }
  },
  "number": function(number, params) {
    
    var formatted = d3plus.number.format(number, params);
    
    if (params.key === "value") {
      return formatted;
    }
    else {
      return formatted;
    }
  }
})
.color(["color"])
.legend({"tooltip":false, "value":false})
.tooltip(["concepto1","concepto2","concepto3","concepto4","concepto5","concepto6","concepto7"])
.draw();