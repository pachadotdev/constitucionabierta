#' Descarga la Base de Datos de Constitucion Abierta a tu Computador
#'
#' Este comando descarga la base de datos completa como un unico archivo bz2 que
#' se descomprime para dejar disponible la base de datos local. La descarga son 15 MB
#' y la base de datos usa 65 MB en disco.
#'
#' @param ver La version a descargar. Por defecto es la ultima version disponible en GitHub. 
#' Se pueden ver todas las versiones en
#' <https://github.com/pachamaltese/constitucionabierta/releases>.
#' @param borrar Borrar o no el archivo zip luego de cargar la base de datos.
#'
#' @return NULL
#' @export
#'
#' @examples
#' \donttest{
#' \dontrun{
#' constitucion_descargar_base()
#' }
#' }
constitucion_descargar_base <- function(ver = NULL, borrar = TRUE) {
  msg("Descargando la base de datos desde GitHub...")
  
  dir <- constitucion_path()
  try(dir.create(dir))
  
  zfile <- get_gh_release_file("pachamaltese/constitucionabierta",
                               tag_name = ver,
                               dir = dir
  )
  ver <- attr(zfile, "ver")
  
  msg("Descomprimiendo la base de datos local...")
  
  dfile <- gsub(".bz2", "", zfile)
  if (file.exists(dfile)) constitucion_borrar_base()
  suppressWarnings(try(constitucion_desconectar_base()))
  R.utils::gunzip(zfile, dfile, overwrite = TRUE, remove = borrar)
  
  suppressWarnings(constitucion_desconectar_base())
  invisible(DBI::dbListTables(constitucion_bbdd()))
  
  update_constitucion_pane()
  constitucion_panel()
  constitucion_estado()
}


#' @importFrom httr GET stop_for_status content accept write_disk progress
#' @importFrom purrr keep
get_gh_release_file <- function(repo, tag_name = NULL, dir = tempdir(),
                                overwrite = TRUE) {
  releases <- GET(
    paste0("https://api.github.com/repos/", repo, "/releases")
  )
  stop_for_status(releases, "buscando versiones")
  
  releases <- content(releases)
  
  if (is.null(tag_name)) {
    release_obj <- releases[1]
  } else {
    release_obj <- purrr::keep(releases, function(x) x$tag_name == tag_name)
  }
  
  if (!length(release_obj)) stop("No se encuenta una version disponible \"", tag_name, "\"")
  
  if (release_obj[[1]]$prerelease) {
    msg("Estos datos aun no se han validado.")
  }
  
  download_url <- release_obj[[1]]$assets[[1]]$url
  filename <- basename(release_obj[[1]]$assets[[1]]$browser_download_url)
  out_path <- normalizePath(file.path(dir, filename), mustWork = FALSE)
  response <- GET(
    download_url,
    accept("application/octet-stream"),
    write_disk(path = out_path, overwrite = overwrite),
    progress()
  )
  stop_for_status(response, "downloading data")
  
  attr(out_path, "ver") <- release_obj[[1]]$tag_name
  return(out_path)
}

#' Elimina la Base de Datos de Constitucion Abierta de tu Computador
#'
#' Elimina el directorio `constitucionabierta` en el directorio de datos de usuario.
#'
#' @return NULL
#' @export
#'
#' @examples
#' \donttest{
#' \dontrun{
#' constitucion_borrar_base()
#' }
#' }
constitucion_borrar_base <- function() {
  suppressWarnings(constitucion_desconectar_base())
  try(
    file.remove(paste0(constitucion_path(), "/constitucionabierta.sqlite"), 
                recursive = TRUE)
  )
  update_constitucion_pane()
  constitucion_panel()
}
