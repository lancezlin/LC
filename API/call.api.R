library(httr)
library(jsonlite)
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
getData <- function(acceptType="application/json"){
  myUrl <- getUrl()
  myJson <- tryCatch(
    GET(myUrl, add_headers(Authorization=.lc.api.key, Accept=acceptType)),
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

###########test##############
# myurl <- getUrl()
# myJson <- GET(myurl, add_headers(Authorization=.lc.api.key, Accept="application/json"), query=list(showAll=TRUE))
# myCsv <- as.data.frame(fromJSON(content(myJson, "text"))$loans)
# mycsv <- getData()
# library(ggplot2)
# p <- ggplot(mycsv, aes(purpose, fundedAmount)) + geom_bar(stat = "sum", show.legend=FALSE)
# p
# ###########test##############

