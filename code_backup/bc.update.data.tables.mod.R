.social.kpo.aws.bucket.name = "production2-basevpc-mainbucket-h5gtbg60xrua"

readPerfDataFromAWS <- function(date){
  aws_file <- paste("https://s3.amazonaws.com/", .social.kpo.aws.bucket.name, "/portfolioReportExport/Social+Portfolios+90+days+(",
                    date,").csv",sep="")
  perf_data <- tryCatch(
    {
      perf_data_inner <- read.csv(aws_file, sep="\t")
      maxDate <- max(as.Date(perf_data_inner$Date))
      filter(perf_data_inner, as.Date(Date)!=maxDate)
    },
    error=function(e) e
  )
  perf_data
}

today <- Sys.Date() + 2
testfunc <- function(){
  
    # flag_no_report <- FALSE
    while (TRUE) {
      perf_data <- readPerfDataFromAWS(today)
      #updateDataLogger$info(paste0("Trying to import" , today, " file from server"))
      if (inherits(perf_data, "error")) {
        today <- today - 1
      }
      else {
        print(today)
        break
      }
      filename <- paste("Social+Portfolios+90+days+(",today,").csv",sep="")
    }
    print(filename)
    perf_data  
}
test_perf <- testfunc()
