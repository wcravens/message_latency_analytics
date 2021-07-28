if (!require("pacman")) 
  install.packages("pacman")

pacman::p_load(pacman, data.table, rio, R.utils, bit64,magrittr, dplyr, modules)

msgw_in <- use( 'lib/data_import_msgw_in.r')$run()

print( paste( "Data covers ", max( msgw_in$t0), 'ns' ) )
print( paste( "Data covers ", max( msgw_in$t0)/1e6, 'ms' ) )
print( paste( "Data covers ", max( msgw_in$t0)/1e9, 'sec' ) )
print( paste( "Data covers ", max( msgw_in$t0)/1e9/60, 'min' ) )


# Our data covers ~30 minutes.
hist( msgw_in$t0, breaks=30*60*100)

summary( msgw_in$delta_t )

hist( msgw_in$delta_t, breaks = 500 )