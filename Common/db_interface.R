library(RMySQL)
source("app.properties")

getDataFromDB <- function(query){
  conn <- dbConnect(MySQL(),
                    user = .lc.db.user, password = .lc.db.pass, 
                    dbname = .lc.db.name, host = .lc.db.host)
  response <- dbSendQuery(conn, query)
  results <- fetch(response)
  dbDisconnect(conn)
  return(results)
}

writeDataToDB <- function(db.table, df, expr){
  df$time_stamp <- Sys.Date()
  conn <- dbConnect(MySQL(),
                    user = .lc.db.user, password = .lc.db.pass, 
                    dbname = .lc.db.name, host = .lc.db.host)
  dbWriteTable(con, name=db.table, value=df, 
               field.types=list(dte="date", val="double(20,10)"), 
               row.names=FALSE)
  dbDisconnect(conn)
}

###################test####################
data <- getDataFromDB("select * from lcLoanListing;")

###################test####################