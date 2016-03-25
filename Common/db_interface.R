library(RMySQL)

getDataFromDB <- function(query){
  conn <- dbConnect(MySQL(),
                    user = .lc.db.user, password = .lc.db.pass, 
                    dbname = .lc.db.name, host = .lc.db.host)
  reponse <- dbSendQuery(conn, query)
  results <- fetch(response)
  dbDisconnect(conn)
}

writeDataToDB <- function(db.table, df, expr){
  conn <- dbConnect(MySQL(),
                    user = .lc.db.user, password = .lc.db.pass, 
                    dbname = .lc.db.name, host = .lc.db.host)
  dbWriteTable(con, name=db.table, value=df, 
               field.types=list(dte="date", val="double(20,10)"), 
               row.names=FALSE)
  dbDisconnect(conn)
}
