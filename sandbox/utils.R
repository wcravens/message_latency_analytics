unzip_msgw_in_data <- function() {
  file <- './Data/eqfa-msgw-in-0709.txt.gz'
  print( paste( "Unpacking ", file, " from dvc data.") )
  
  if ( !file.exists( substr( file, 1, nchar( file ) - 3 ) ) ) {
    print( paste( "Decompressing ", file ) )
    gunzip( file, remove=F )
  } else {
    print( paste( file, " exists; skipping decompression." ) )
  }
}