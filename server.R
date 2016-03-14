library(shiny)
library(ggplot2)
library(logging)
library(magrittr)
source("API/call.api.R")
source("app.properties")
source("Common/load.data.R")
source("Common/backend.log.R")

REFRESH_INTERVAL <- 60*60*1000
logging.initial("LC data loading")
LC.logger <- getLogger("LC")
loaded.Data <- load.data.tables(REFRESH_INTERVAL, .data.file.location, LC.logger)

shinyServer(function(input, output, session) {
  loan.data <- reactive({
    tryCatch(
      loaded.Data()$loanData,
      error = function(e) e
    )
  })

observe({
  how_many_terms <- unique(loan.data()$term)
  updateSelectInput(session, "terms", choices = how_many_terms, selected = "")
})

output$dailyLoan <- renderTable({
  loan.data() %>%
    subset(., term==input$terms)
})

})
