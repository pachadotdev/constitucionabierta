library(DBI)
library(RMariaDB)
library(RSQLite)
library(readr)
library(dplyr)
library(janitor)

# descargue el dump de https://users.dcc.uchile.cl/~jperez/CA/ELA.sql.zip
# e importe localmente en mysql

con <- dbConnect(MariaDB(), 
                 username = "foo", 
                 password = "bar", 
                 dbname = "constitucion", 
                 host = "127.0.0.1")

con2 <- dbConnect(SQLite(), "data-raw/constitucionabierta.sqlite")

tables <- dbListTables(con)

indexes <- list(
  Conceptos = list("id_ela", "concepto")
)

unique_indexes <- list(
  Conceptos = list("id"),
  ELA = list("id_ela")
)

for (table in tables) {
  df <- dbReadTable(con, table) %>% clean_names()
  
  message("Creating table: ", table)
  
  table_name <- tolower(table)
  
  copy_to(
    con2,
    df,
    table_name,
    unique_indexes = unique_indexes[[table]],
    indexes = indexes[[table]],
    temporary = FALSE
  )
}

dbDisconnect(con)
dbDisconnect(con2)
