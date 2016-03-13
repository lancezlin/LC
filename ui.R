library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("LendingClub Loan Listing Data"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
#     sliderInput("bins",
#                 "Number of bins:",
#                 min = 1,
#                 max = 50,
#                 value = 30)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    #plotOutput("distPlot"),
    tableOutput("dailyLoan")
  )
))
