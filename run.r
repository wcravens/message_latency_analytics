if (!require("pacman")) 
  install.packages("pacman")

pacman::p_load(pacman, data.table, rio, R.utils, bit64,magrittr, dplyr, modules )

msgw_in <- use( 'lib/data_import_msgw_in.r')$run()

## Duplicate ts_ns
msgw_in_length <- length( msgw_in$ts_ns )
msgw_in_unique_length <- length( unique( msgw_in$ts_ns ) )
print( paste( "msgw_in$ts_nw is Unique:", msgw_in_length == msgw_in_unique_length ) )
print( paste( "Percent of msgw_in Unique ts_ns: ", msgw_in_unique_length / msgw_in_length ) )
   
## msgw_in_duplicated_ts_ns <- msgw_in[duplicated(msgw_in$ts_ns),]
## Visual inspection of the observations with duplicate time stamps did not reviel any obvious patters.  We will leave the duplicate timestamps as they are.
  
# Normalize Timestamps to start at T0 and coerce into double (instead of bit64)
msgw_in$t0 <- as.double( msgw_in$ts_ns - data.table::first(msgw_in$ts_ns) )

# Calculate intermittent delta_t and coerce into double (instaead of bit64)
msgw_in$delta_t <- as.double( msgw_in$t0 - data.table::shift( msgw_in$t0, n=1, fill=0, type="lag") )
  
latency_in_ms <- as.numeric( msgw_in$`PNQM Latency (ms)` )
latency_null_to_zero <- latency_in_ms[ is.na(latency_in_ms) ] <- 0
latency_in_ns <- latency_in_ms * 1e6
msgw_in$t_exit <- msgw_in$t0 + latency_in_ns 
print( paste( "Data covers ", max( msgw_in$t0), 'ns' ) )
print( paste( "Data covers ", max( msgw_in$t0)/1e6, 'ms' ) )
print( paste( "Data covers ", max( msgw_in$t0)/1e9, 'sec' ) )
print( paste( "Data covers ", max( msgw_in$t0)/1e9/60, 'min' ) )

# Our data covers ~30 minutes.
hist( msgw_in$t0, breaks=30*60*100)

summary( msgw_in$delta_t )

hist( msgw_in$delta_t, breaks = 500 )

