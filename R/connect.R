#' @importFrom rappdirs user_data_dir
constitucion_path <- function() {
  sys_constitucion_path <- Sys.getenv("CONSTITUCION_BBDD_DIR")
  sys_constitucion_path <- gsub("\\\\", "/", sys_constitucion_path)
  if (sys_constitucion_path == "") {
    return(gsub("\\\\", "/", paste0(rappdirs::user_data_dir(), "/constitucionabierta")))
  } else {
    return(gsub("\\\\", "/", sys_constitucion_path))
  }
}

constitucion_check_status <- function() {
  if (!constitucion_estado(FALSE)) {
    stop("La base de datos local del Constitucion Abierta esta vacia o daniada. Descargala con constitucion_descargar_base().")
  }
}

#' Conexion a la Base de Datos de Constitucion Abierta
#'
#' Devuelve una conexion a la base de datos local. Esto corresponde a una
#' conexion a una base 'SQLite' compatible con DBI. A diferencia de 
#' [constitucionabierta::constitucion_tabla()], esta funcion es mas flexible y se puede usar con 
#' dbplyr para leer unicamente lo que se necesita o directamente con DBI para
#' usar comandos SQL.
#'
#' @param dir La ubicacion de la base de datos en el disco. Por defecto es
#' `constitucionabierta` en la carpeta de datos del usuario ([rappdirs::user_data_dir()]), 
#' o la variable de entorno `CONSTITUCION_BBDD_DIR`.
#'
#' @export
#'
#' @examples
#' if (constitucion_estado()) {
#'  DBI::dbListTables(constitucion_bbdd())
#'
#'  DBI::dbGetQuery(
#'   constitucion_bbdd(),
#'   'SELECT * FROM conceptos'
#'  )
#' }
constitucion_bbdd <- function(dir = constitucion_path()) {
  db <- mget("constitucion_bbdd", envir = constitucion_cache, ifnotfound = NA)[[1]]
  if (inherits(db, "DBIConnection")) {
    if (DBI::dbIsValid(db)) {
      return(db)
    }
  }
  
  try(dir.create(dir, showWarnings = FALSE, recursive = TRUE))
  
  tryCatch({
    db <- DBI::dbConnect(
      RSQLite::SQLite(),
      paste0(dir, "/constitucionabierta.sqlite")
    )
  },
  error = function(e) {
    if (grepl("(Database lock|bad rolemask)", e)) {
      stop(
        "La base de datos local de Constitucion Abierta esta siendo usada por otro proceso.\nIntenta cerrar otras sesiones de R o desconectar la base usando constitucion_desconectar_base() en las demas sesiones.",
        call. = FALSE
      )
    } else {
      stop(e)
    }
  },
  finally = NULL
  )
  
  assign("constitucion_bbdd", db, envir = constitucion_cache)
  db
}


#' Tablas Completas de la Base de Datos de Constitucion Abierta
#'
#' Devuelve una tabla completa de la base de datos. Para entregar datos
#' filtrados previamente se debe usar [constitucionabierta::constitucion_bbdd()]. Esta funcion puede
#' ser especialmente util para obtener los mapas y usarlos directamente con
#' tm o ggplot2, sin necesidad de transformar las columnas de geometrias.
#'
#' @param tabla Una cadena de texto indicando la tabla a extraer
#' @return Un tibble
#' @export
#'
#' @examples
#' if (constitucion_estado()) {
#'   constitucion_tabla("conceptos")
#' }
constitucion_tabla <- function(tabla) {
  df <- tibble::as_tibble(DBI::dbReadTable(constitucion_bbdd(), tabla)) 
  return(df)
}


#' Desconecta la Base de Datos de Constitucion Abierta
#'
#' Una funcion auxiliar para desconectarse de la base de datos.
#'
#' @examples
#' constitucion_desconectar_base()
#' @export
#'
constitucion_desconectar_base <- function() {
  constitucion_db_disconnect_()
}

constitucion_db_disconnect_ <- function(environment = constitucion_cache) {
  db <- mget("constitucion_bbdd", envir = constitucion_cache, ifnotfound = NA)[[1]]
  if (inherits(db, "DBIConnection")) {
    DBI::dbDisconnect(db)
  }
  observer <- getOption("connectionObserver")
  if (!is.null(observer)) {
    observer$connectionClosed("Constitucion Abierta", "constitucionabierta")
  }
}


#' Obtiene el Estado de la Base de Datos Local de Constitucion Abierta
#'
#' Entrega el estado de la base de datos local. Muestra un mensaje informativo
#' respecto de como obtener la base si esta no se encuentra o esta daniada.
#'
#' @param msg Mostrar o no mensajes de estado. Por defecto es TRUE.
#' 
#' @return TRUE si la base de datos existe y contiene las tablas esperadas, FALSE 
#' en caso contrario (invisible).
#' @export
#' @examples
#' constitucion_estado()
constitucion_estado <- function(msg = TRUE) {
  expected_tables <- sort(constitucion_tables())
  existing_tables <- sort(DBI::dbListTables(constitucion_bbdd()))
  
  if (isTRUE(all.equal(expected_tables, existing_tables))) {
    status_msg <- crayon::green(paste(cli::symbol$tick, "La base de datos local de Constitucion Abierta esta OK."))
    out <- TRUE
  } else {
    status_msg <- crayon::red(paste(cli::symbol$cross, "La base de datos local de Constitucion Abierta esta vacia o daniada. Descargala con constitucion_descargar_base()."))
    out <- FALSE
  }
  if (msg) msg(cli::rule(status_msg))
  invisible(out)
}

constitucion_tables <- function() {
  c("conceptos","ela","memoria","participante")
}

constitucion_cache <- new.env()
reg.finalizer(constitucion_cache, constitucion_db_disconnect_, onexit = TRUE)

