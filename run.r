if (!require("pacman")) install.packages("pacman")

pacman::p_load(pacman, data.table, rio, R.utils, bit64,magrittr, dplyr, modules )

msgw_in <- use( 'lib/data_import_msgw_in.r')$run()

