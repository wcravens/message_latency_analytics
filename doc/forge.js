const Metalsmith  = require( 'metalsmith' ),
      layouts     = require( 'metalsmith-layouts' ),
      markdown    = require( 'metalsmith-markdown' ),
      reload      = require( 'metalsmith-browser-sync' )
;

Metalsmith( __dirname )
  .metadata({
    sitename: "MSFE IE522 Statistical Methods Summer Project",
    repository: "https://gitlab.engr.illinois.edu/wbc3/msfe-ie522-statistical-methods-summer-project",
    description: "Supplementary IE522 Summer Project for CME Group",
    generatorname: "Metalsmith",
    generatorurl:   "https://metalsmith.io"
  })
  .source( './src' )
  .destination( './build' )
  .clean( true )
  .use( markdown() )
  .use( layouts({
    directory: "layouts",
    engine: "handlebars",
    default: "default.hbs",
    partials: "partials"
  }) )
  .use( reload() )
  .build( function( err ) {
    if( err ) throw err;
  });
