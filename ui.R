library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("LendingClub Loan Listing Data"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    selectInput(
      "terms",
      "Select terms:",
      choices = ""
    )
  ),
  
  # Show a table of the active loans
  mainPanel(
    tableOutput("dailyLoan")
  )
))
