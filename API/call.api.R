library(httr)
library(jsonlite)
source("app.properties")

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

myurl <- getUrl()
###########test##############
myJson <- GET(myurl, add_headers(Authorization=.lc.api.key, Accept="text/plain"))
mycsv <- content(myJson)
myjs <- fromJSON(content(myJson))
###########test##############