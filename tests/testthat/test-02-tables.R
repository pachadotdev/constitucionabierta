context("Tables")

olddir <- Sys.getenv("CONSTITUCION_BBDD_DIR")
Sys.setenv(CONSTITUCION_BBDD_DIR = normalizePath(file.path(getwd(), "constitucionabierta"),
                                          mustWork = FALSE
))

test_that("constitucion_datos returns tbl_df", {
  skip_on_cran()
  skip_if_not(constitucion_estado())
  
  expect_is(constitucion_bbdd(), "SQLiteConnection")
  
  for (t in c("comunas", "regiones")) {
    expect_is(constitucion_tabla(t), "tbl_df")
  }
})

test_that("constitucion_datos returns tbl_lazy", {
  skip_on_cran()
  skip_if_not(constitucion_estado())
  
  expect_is(constitucion_bbdd(), "SQLiteConnection")
  
  for (t in c("comunas", "regiones")) {
    expect_is(dplyr::tbl(constitucion_bbdd(), t), "tbl_lazy")
  }
})

Sys.setenv(CONSTITUCION_BBDD_DIR = olddir)
