if (!require("pacman")) 
  install.packages("pacman")
  
pacman::p_load( pacman, rio )
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

validate <- function( msgw_in ) {
  print( paste( "ts_ns is Monotonic: ", all(msgw_in$ts_ns == cummax(msgw_in$ts_ns) ) ) )
  return ( msgw_in )
}

export( "run" )
run <- function() {
  return ( validate ( load() ) ) 
}