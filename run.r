if (!require("pacman"))
  install.packages("pacman")
pacman::p_load(pacman, modules, data.table, bit64, dplyr, ggplot2, psych, randtests )
#p_unload( all )

## Load
.msgw_in <- use( 'lib/data_import_msgw_in.r')$run()

## Build working data frame
msgw_in <- cbind.data.frame(
  # Normalize Timestamps to start at T0
  "message_arrival_t_ns"  = .msgw_in$ts_ns - first( .msgw_in$ts_ns )
)

# Calculate inter message delta_t
msgw_in$inter_message_delta_t_ns <-  as.numeric( msgw_in$message_arrival_t_ns - shift( msgw_in$message_arrival_t_ns, n=1, fill=NA, type="lag" ) )
msgw_in$inter_message_delta_t_ns[is.na( msgw_in$inter_message_delta_t_ns)] <- 0

tmp <- as.numeric( .msgw_in$`PNQM Latency (ms)` ) * 1e6
tmp[is.na(tmp)] <- 0
msgw_in$message_processing_time_ns <- tmp

msgw_in$message_exit_t_ns = msgw_in$message_arrival_t_ns + msgw_in$message_processing_time_ns

30*60*100
hist( as.numeric( msgw_in$message_arrival_t_ns) , breaks=180000 )

# TODO
# Calculate Queue Size

# Calculate 'Leaky Integrator' or other smoothing window function/kernel

## Analysis

msgw_in_length <- length( msgw_in$message_arrival_t_ns )
msgw_in_unique_length <- length( unique( msgw_in$message_arrival_t_ns ) )
print( paste( "msgw_in$ts_nw is Unique:", msgw_in_length == msgw_in_unique_length ) )
print( paste( "Percent of msgw_in Unique arrival time: ", msgw_in_unique_length / msgw_in_length ) )

msgw_in_duplicate_arrival_time <- msgw_in[duplicated(msgw_in$message_arrival_t_ns),]
## Visual inspection of the observations with duplicate time stamps did not reveal any obvious patters.  We will leave the duplicate timestamps as they are.

print( paste( "t0 is Monotonic: ", all(msgw_in$message_arrival_t_ns == cummax(msgw_in$message_arrival_t_ns) ) ) )

print( paste( "Data covers ", max( msgw_in$message_arrival_t_ns), 'ns' ) )
print( paste( "Data covers ", max( msgw_in$message_arrival_t_ns)/1e6, 'ms' ) )
print( paste( "Data covers ", max( msgw_in$message_arrival_t_ns)/1e9, 'sec' ) )
print( paste( "Data covers ", max( msgw_in$message_arrival_t_ns)/1e9/60, 'min' ) )

# Our data covers ~30 minutes.
ggplot( msgw_in, aes( x = inter_message_delta_t_ns ) ) + geom_histogram()

hist( msgw_in$inter_message_delta_t_ns,
      col="thistle",
      main = "Histogram of Inter-message time Between Message Arrivals",
      xlab = "Nanoseconds between messages"
)
              mean( msgw_in$inter_message_delta_t_ns )
              sd( msgw_in$inter_message_delta_t_ns)

summary( msgw_in$inter_message_delta_t_ns )
describe( msgw_in$inter_message_delta_t_ns )

ggplot( msgw_in, aes( x = message_processing_time_ns )) + geom_histogram() + scale_x_log10()

tmp <- data.frame( message_arrival_t_ns = as.numeric( msgw_in$message_arrival_t_ns ) )
str( tmp )
ggplot( tmp, aes( x = message_arrival_t_ns ) ) + geom_histogram( bins = 30*60*100 ) 
hist( tmp$message_arrival_t_ns, breaks = 30*60*100 )
??runs.test

# H0 (null): The data was produced in a random manner.
# Ha (alternative): The data was not produced in a random manner.

# w/ p-value < 2.2e-16; THere is sufficien evidence to reject the Null Hypothesis. 

result 

d1 <- msgw_in$inter_message_delta_t_ns
d2 <- msgw_in$message_processing_time_ns

runs.test( d1 ) 
chisq.test( d1 )
bartels.rank.test( d1 )
cox.stuart.test( d1 )
difference.sign.test( d1 )
acf( d1 ) 
pacf( d1 )

runs.test( d2 ) 
chisq.test( d2 )
bartels.rank.test( d2 )
cox.stuart.test( d2 )
difference.sign.test( d2 )
acf( d2 ) 
pacf( d2 )
?split
stripchart( as.numeric( msgw_in$message_arrival_t_ns[ msgw_in$message_arrival_t_ns < 1 * 60 * 1e12] ) )

numeric_arrival_times <- as.numeric( msgw_in$message_arrival_t_ns )
hist( numeric_arrival_times, breaks = 30*60*100 )
stripchart( numeric_arrival_times )

arrival_times_slice_labels <- cut( numeric_arrival_times, breaks=30*60, labels=F, include.lowest=T )
arrival_time_slices <- data.frame( numeric_arrival_times, arrival_times_slice_labels )
par(mfrow=c( 30, 1 ), mai=c(0.1, 0.1, 0.1, 0.1) )
loop_count <- 1:30
for( i in loop_count ){
  stripchart( arrival_time_slices$numeric_arrival_times[ arrival_time_slices$arrival_times_slice_labels == i * 60 ], method="stack", pch=19, cex=0.5, col="blue", xlab=NULL, ylab=NULL, main=NULL, axes=F )
}

## hawkes
# https://cran.r-project.org/web/packages/hawkesbow/index.html
# https://cran.r-project.org/web/packages/hawkesbow/hawkesbow.pdf
# https://search.r-project.org/CRAN/refmans/hawkes/html/simulateHawkes.html

# Play with histogram bin count to maximize the min->max bin count

# [Sequential Event Interval Analysis ](https://rdrr.io/cran/eventInterval/man/eventInterval-package.html)