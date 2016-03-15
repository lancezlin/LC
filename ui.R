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
    ),
    radioButtons(
      "choose.grade",
      "select grades:",
      choices = ""  
    )
  ),
  
  # Show a table of the active loans
  mainPanel(
    DT::dataTableOutput("dailyLoan")
  )
))
