source("../application.properties")
source("helperFunctions.R")
source("queries.R")

update.data.tables <- function(){
  
  today <- Sys.Date()
  yesterday <- today - 1
  stand_alone <- FALSE
  data.tables <- list()
  
  if (stand_alone) {
    data.tables$perf_data <- read.csv("d:/social_data/summary_report.csv", sep="\t")   
    data.tables$portfolio_configuration <- read.csv("d:/social_data/portfolio_configuration.csv")
  } 
  else {
    filename <- paste("Social+Portfolios+90+days+(",today,").csv",sep="")
    if(isFileExistOnDRive(filename)) {
      perf_data <- getFileFromDriveIfExist(filename) 
    } 
    else {
      print("trying to import report file from server")
      flag_no_report <- FALSE
      perf_data <- readPerfDataFromAWS(today)
      if(inherits(perf_data, "error")){
        print(perf_data)
        filename <- paste("Social+Portfolios+90+days+(",yesterday,").csv",sep="")
        perf_data <- readPerfDataFromAWS(yesterday)
        if(inherits(perf_data, "error")){
          print(perf_data)
          flag_no_report <- TRUE
          stop("******** Error, probably no file for last two days ********")
        }
      }
      writeCurrentReport2Drive(filename,perf_data)   
    }
    portfolio_configuration <- getDataFromSocialDB(portfolio_configuration_query)
  }
  
  nice_colnames <- gsub("X..of.","",colnames(perf_data))
  nice_colnames <- gsub("\\.\\.","\\.",nice_colnames)
  colnames(perf_data) <- nice_colnames
  
  perf_data <- mutate(perf_data, 
                      Date = as.Date(Date),
                      CTR = Clicks/Impressions,
                      CPM = Cost/(1000*Impressions),
                      CPC = Cost/Clicks,
                      Conv.Rate = Conversions/Clicks,
                      PortfolioId = Portfolio.ID)
  
  all_data <- merge(perf_data, portfolio_configuration, by = c("PortfolioId"), all.x = TRUE)
  all_data <- arrange(all_data, PortfolioId, Date)
  all_data <- addMovingAverage(all_data)
  
  data.tables$all_data <- all_data
  
  return(data.tables)
  
}