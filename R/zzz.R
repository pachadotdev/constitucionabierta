.onAttach <- function(...) {
  if (interactive() && Sys.getenv("RSTUDIO") == "1"  && !in_chk()) {
    constitucion_panel()
  }
  if (interactive()) constitucion_estado()
}

in_chk <- function() {
  any(
    grepl("check",
          sapply(sys.calls(), function(a) paste(deparse(a), collapse = "\n"))
    )
  )
}
