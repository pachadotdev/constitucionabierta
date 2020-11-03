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

comunas2$comuna[!comunas2$comuna %in% comunas$nombre_comuna]

comunas2 <- comunas2 %>% 
  mutate(
    comunaok = case_when(
      comunaok == "La Calera" ~ "Calera",
      comunaok == "Coyhaique" ~ "Coihaique",
      comunaok == "Padre Las Casas" ~ "Padre las Casas",
      comunaok == "Aysen" ~ "Aisen",
      comunaok == "San Vicente de Tagua Tagua" ~ "San Vicente",
      comunaok == "San Pedro de La Paz" ~ "San Pedro de la Paz",
      comunaok == "Paihuano" ~ "Paiguano",
      comunaok == "O'higgins" ~ "OHiggins",
      TRUE ~ comunaok
    )
  )

# arregla comunas ----

ela <- constitucion_tabla("ela")

comunas <- chilemapas::codigos_territoriales %>% select(nombre_comuna, codigo_comuna)

comunas2 <- tibble(comuna = unique(ela$comuna), comunaok = unique(ela$comuna))

comunas2$comunaok[!comunas2$comunaok %in% comunas$nombre_comuna]

ela <- ela %>% 
  left_join(comunas2)

ela <- ela %>% 
  select(-comuna) %>% 
  rename(comuna = comunaok) %>% 
  left_join(comunas, by = c("comuna" = "nombre_comuna"))

dbWriteTable(constitucion_bbdd(), "ela", ela, overwrite = T)
