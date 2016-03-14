source("API/call.api.R")


## update data function
update.data <- function(){
  data.list <- list()
  
  data.list$loanData <- getData()
  loginfo(paste0("update loan data at ", Sys.time()))
  
  return(data.list)
}