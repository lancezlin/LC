library(shiny)
library(ggplot2)
library(logging)
library(magrittr)
library(DT)
library(shinyjs)
source("API/call_api.R")
source("app.properties")
source("Common/load_data.R")
source("Common/backend_log.R")
#
REFRESH_INTERVAL <- 60*60*1000
logging.initial("LC data loading")
LC.logger <- getLogger("LC")
loaded.Data <- load_data_tables(REFRESH_INTERVAL, .data.file.location, LC.logger)

shinyServer(function(input, output, session) {
  loan.data <- reactive({
    tryCatch(
      loaded.Data()$loanData,
      error = function(e) e
    )
  })

observe({
  how_many_terms <- sort(unique(loan.data()$term))
  updateSelectInput(session, "terms", choices = how_many_terms, selected = "")
})

observe({
  grades <- sort(unique(loan.data()$grade))
  updateRadioButtons(session, "choose.grade", choices = grades, selected = "")
})

output$dailyLoan <- DT::renderDataTable({
  loan.data() %>%
    subset(., term==input$terms & grade==input$choose.grade)
})

})

logging.close()