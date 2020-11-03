context("Connection")

olddir <- Sys.getenv("CONSTITUCION_BBDD_DIR")
Sys.setenv(CONSTITUCION_BBDD_DIR = normalizePath(file.path(getwd(), "constitucionabierta"),
                                          mustWork = FALSE
))

test_that("Database is deleted", {
  skip_on_cran()
  skip_if_not(constitucion_estado())
  
  expect_true(constitucion_estado())
  constitucion_borrar_base()
  expect_equal(DBI::dbListTables(constitucion_bbdd()), character(0))
  expect_false(constitucion_estado())
})

unlink(Sys.getenv("CONSTITUCION_BBDD_DIR"), recursive = TRUE)
Sys.setenv(CONSTITUCION_BBDD_DIR = olddir)
