context("Download")

olddir <- Sys.getenv("CONSTITUCION_BBDD_DIR")
Sys.setenv(CONSTITUCION_BBDD_DIR = normalizePath(file.path(getwd(), "constitucionabierta"),
                                          mustWork = FALSE
))

test_that("Download succeeds", {
  skip_on_cran()
  constitucion_descargar_base()
  expect_true(constitucion_estado())
})

Sys.setenv(CONSTITUCION_BBDD_DIR = olddir)
