sql_action <- function() {
  if (requireNamespace("rstudioapi", quietly = TRUE) &&
      exists("documentNew", asNamespace("rstudioapi"))) {
    contents <- paste(
      "-- !preview conn=constitucionabierta::constitucion_bbdd()",
      "",
      "SELECT * FROM conceptos",
      "",
      sep = "\n"
    )
    
    rstudioapi::documentNew(
      text = contents, type = "sql",
      position = rstudioapi::document_position(2, 40),
      execute = FALSE
    )
  }
}

#' Abre el Panel de Conexion a la Base de Datos de Constitucion Abierta en RStudio
#'
#' Esta funcion abre el panel "Connections" para explorar la base de datos
#' local de forma interactiva.
#'
#' @return NULL
#' @export
#'
#' @examples
#' if (!is.null(getOption("connectionObserver"))) constitucion_panel()
constitucion_panel <- function() {
  observer <- getOption("connectionObserver")
  if (!is.null(observer) && interactive()) {
    observer$connectionOpened(
      type = "Constitucion Abierta",
      host = "constitucionabierta",
      displayName = "Tablas Constitucion Abierta",
      icon = system.file("img", "cl-logo.png", package = "constitucionabierta"),
      connectCode = "constitucionabierta::constitucion_panel()",
      disconnect = constitucionabierta::constitucion_desconectar_base,
      listObjectTypes = function() {
        list(
          table = list(contains = "data")
        )
      },
      listObjects = function(type = "datasets") {
        tbls <- DBI::dbListTables(constitucion_bbdd())
        data.frame(
          name = tbls,
          type = rep("table", length(tbls)),
          stringsAsFactors = FALSE
        )
      },
      listColumns = function(table) {
        res <- DBI::dbGetQuery(constitucion_bbdd(),
                               paste("SELECT * FROM", table, "LIMIT 1"))
        data.frame(
          name = names(res), type = vapply(res, function(x) class(x)[1], character(1)),
          stringsAsFactors = FALSE
        )
      },
      previewObject = function(rowLimit, table) {
        DBI::dbGetQuery(constitucion_bbdd(),
                        paste("SELECT * FROM", table, "LIMIT", rowLimit))
      },
      actions = list(
        Status = list(
          icon = system.file("img", "cl-logo.png", package = "constitucionabierta"),
          callback = constitucion_estado
        ),
        SQL = list(
          icon = system.file("img", "edit-sql.png", package = "constitucionabierta"),
          callback = sql_action
        )
      ),
      connectionObject = constitucion_bbdd()
    )
  }
}

update_constitucion_pane <- function() {
  observer <- getOption("connectionObserver")
  if (!is.null(observer)) {
    observer$connectionUpdated("Constitucion Abierta", "constitucionabierta", "")
  }
}
