load <- function() {
  if (!file.exists( './Data/eqfa-msgw-in-0709.txt' ) ) {
    print( "Decompressing ./Data/eqfa-msgw-in-0709.txt.gz" )
    gunzip( './Data/eqfa-msgw-in-0709.txt.gz', remove=F )
  } else {
    print( "./Data/eqfa-msgw-in-0709.txt exists; skipping decompression." )
  }
  print( "Loading ./Data/eqfa-msgw-in-0709.txt into dataframe." )
  return( rio::import( './Data/eqfa-msgw-in-0709.txt' ) )
}

# str( msgw_in )
# typeof( msgw_in )
# head(msgw_in)

supplement <- function( msgw_in ) {
  ## Duplicate ts_ns
  msgw_in_length <- length( msgw_in$ts_ns )
  msgw_in_unique_length <- length( unique( msgw_in$ts_ns ) )
  print( paste( "msgw_in$ts_nw is Unique:", msgw_in_length == msgw_in_unique_length ) )
  print( paste( "Percent of msgw_in Unique ts_ns: ", msgw_in_unique_length / msgw_in_length ) )
  
  ## msgw_in_duplicated_ts_ns <- msgw_in[duplicated(msgw_in$ts_ns),]
  ## Visual inspection of the observations with duplicate time stamps did not reviel any obvious patters.  We will leave the duplicate timestamps as they are.
  
  # Normalize Timestamps to start at T0 and coerce into double (instead of bit64)
  msgw_in$t0 <- as.double( msgw_in$ts_ns - data.table::first(msgw_in$ts_ns) )
  
  # Calculate interevent delta_t and coerce into double (instaead of bit64)
  msgw_in$delta_t <- as.double( msgw_in$t0 - data.table::shift( msgw_in$t0, n=1, fill=0, type="lag") )
  return (msgw_in)
}

validate <- function( msgw_in ) {
  print( paste( "ts_ns is Monotonic: ", all(msgw_in$ts_ns == cummax(msgw_in$ts_ns) ) ) )
  print( paste( "t0 is Monotonic: ", all(msgw_in$t0 == cummax(msgw_in$t0) ) ) )
  return (msgw_in)
}
export( "run" )
run <- function() {
  return ( validate ( supplement( load() ) ) ) 
}