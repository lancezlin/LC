library(httr)
library(jsonlite)
library(downloader)
source("app.properties")

## function 1
getUrl <- function(inv_id = NULL, reqType = NULL, version = "v1"){
  base = "https://api.lendingclub.com/api/investor/"
  if (is.null(inv_id)) {
    url.api <- paste0(base, version, "/loans/listing")
    return(url.api)
  }
  else {
    if (is.null(inv_id) | is.null(reqType)) {
      stop("Please input your investor id and request type")
    }
    else {
      url.api <- paste0(base, version, "/accounts/", inv_id, "/", reqType)
      return(url.api)
    }
  }
}

## function 2
getData <- function(myUrl, acceptType="application/json"){
  myJson <- tryCatch(
    GET(myUrl, add_headers(Authorization=.lc.api.key, Accept=acceptType), query=list(showAll=TRUE)),
    error = function(e) e
  )
  if (inherits(myJson, "error")) {
    stop("couldn't fetch lc data from server.")
  }
  else {
    myData <- as.data.frame(fromJSON(content(myJson, "text"))$loans)
  }
  return(myData)
}

## function 3
getHistData <- function(dlUrl, zip.file.name){
  if (dir.exists(paste(getwd(), "rdata",  sep = "/"))) {
    print("rdata dir already exists.")
  }
  else{
    dir.create(paste(getwd(), "rdata", sep = "/"))
  }
  data.path <- paste(getwd(), "rdata", sep = "/")
  if (!file.exists(paste(data.path, zip.file.name, sep = "/"))) {
    setwd(data.path)
    download(dlUrl, zip.file.name, mode = "wb")
    response.data <- read.csv(unzip(zip.file.name, exdir = "./"), skip = 1, header = TRUE)
    file.remove(zip.file.name)
    setwd("..")
  }
  else{
    stop("zip file hasn't been removed last time.")
  }
  return(response.data)
}


###########test##############
# myurl <- getUrl()
# myJson <- GET(myurl, add_headers(Authorization=.lc.api.key, Accept="application/json"), query=list(showAll=TRUE))
# myCsv <- as.data.frame(fromJSON(content(myJson, "text"))$loans)
# mycsv <- getData()
# library(ggplot2)
# p <- ggplot(mycsv, aes(purpose, fundedAmount)) + geom_bar(stat = "sum", show.legend=FALSE)
# p <- getHistData("https://resources.lendingclub.com/LoanStats3a.csv.zip", "LoanStats3a.csv.zip")
# ###########test##############

