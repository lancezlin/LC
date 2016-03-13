library(shiny)
library(ggplot2)
source("API/call.api.R")
source("app.properties")

loanData <- getData()

shinyServer(function(input, output) {
   
#   output$distPlot <- renderPlot({
#     
#     # generate bins based on input$bins from ui.R
#     x    <- faithful[, 2] 
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)
#     
#     # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white')
#     
#   })

output$dailyLoan <- renderTable({
  loanData
    #ggplot(loanData, aes(purpose, fundedAmount)) + geom_bar(stat = "sum", show.legend=FALSE)
    
})
  
})
