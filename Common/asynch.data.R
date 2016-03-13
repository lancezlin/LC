if (file.exists("Common/update.data.R")) {
  source("Common/update.data.R")
  source("Common/backend.log.R")
  
  app.name <- basename(getwd())
  logging.initial(paste(app.name, "asynch", "data", sep = "-"))
  data.list <- update.data()
  dir.create(.data.file.location, showWarnings = FALSE)
  save(data.list, file = file.path(.data.file.location, 
                                   paste(app.name, "data", "tables", "Rdata", sep = ".")))
  
  logging.close()
}