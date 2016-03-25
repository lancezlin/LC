load_data_tables <- function(refresh.interval, data.location, logger, app.name=basename(getwd()), post.load.expr=NULL){
  reactive({
    invalidateLater(refresh.interval, session = NULL)
    logger$info("Loading data tables")
    load(file.path(.data.file.location, paste(app.name, "data", "tables", "Rdata", sep = ".")))
    logger$info(paste0("Finshed refresh. Next refresh: ", Sys.time()+refresh.interval/1000))
    if (is.expression(post.load.expr)) {
      logger$info("Perform post load action")
      eval(post.load.expr)
      logger$info("Finished post load action")
    }
    data.list
  }, domain = NULL)
}