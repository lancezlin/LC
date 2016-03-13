source("app.properties", local=TRUE)
library(logging)

logging.initial <- function (app_name="noname") {
  dir.create(.logging.file.dir, showWarnings = TRUE)
  logging.filename <<- paste0(.logging.file.dir,.Platform$file.sep,app_name,"_",as.character(Sys.Date()),".log")
  basicConfig(.logging.default.level)
  addHandler(writeToFile, file=logging.filename, formatter=formatter.actualformat,logger="")
}

formatter.actualformat <- function(record) {
  text <- paste(record$timestamp, paste(record$levelname, record$logger,paste(record$msg,"\t",sep="",collapse=""), sep=':'))
}

logging.close <- function() {
  removeHandler(writeToFile,logger="")
}