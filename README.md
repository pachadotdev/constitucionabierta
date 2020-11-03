<!-- badges: start -->
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#stable)
[![GH-actions](https://github.com/pachamaltese/constitucionabierta/workflows/R-CMD-check/badge.svg)](https://github.com/pachamaltese/constitucionabierta/actions)
[![codecov](https://codecov.io/gh/pachamaltese/constitucionabierta/branch/master/graph/badge.svg?token=8Hv4pwlwBg)](https://codecov.io/gh/pachamaltese/constitucionabierta)
<!-- badges: end -->

# Acerca de

Provee un acceso conveniente a mas de 15 mil actas registradas durante el proceso de Encuentros Locales Autoconvocados en el marco del proceso de consulta de una Nueva Constitucion durante el gobierno de Michelle Bachelet. Los datos fueron importados desde la base de datos MySQL del Instituto Milenio de Fundamentos de los Datos.

# Instalacion

Version de desarrollo
```
# install.packages("remotes")
remotes::install_github("pachamaltese/constitucionabierta")
```

# Valor agregado respecto de la base original

* Esta base fue portada a SQLite para facilitar su uso.
* Arregle los nonbres de las comunas para dejarlos igual que los nombres oficiales de SUBDERE.
* Agregue los codigos de comunas para poder usar, por ejemplo, chilemapas.

# Aportes

Si quieres donar para aportar al desarrollo de este y mas paquetes Open Source, puedes hacerlo en [Buy Me a Coffee](https://www.buymeacoffee.com/pacha/).
