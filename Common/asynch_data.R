if (file.exists("Common/update_data.R")) {
  source("Common/update_data.R")
  source("Common/backend_log.R")
  
  app.name <- basename(getwd())
  logging.initial(paste(app.name, "asynch", "data", sep = "-"))
  data.list <- update_data()
  dir.create(.data.file.location, showWarnings = FALSE)
  save(data.list, file = file.path(.data.file.location, 
                                   paste(app.name, "data", "tables", "Rdata", sep = ".")))
  
  logging.close()
}