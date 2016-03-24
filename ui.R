library(shiny)

shinyUI(fluidPage(
  
  # nav list panel
  navlistPanel(
    "title",
    #tab 1
    tabPanel(
      "subtitle1",
      tabsetPanel(
        "subsubtitle1",
        tabPanel("plot",
                 DT::dataTableOutput("dailyLoan")
                 ),
        tabPanel(""),
        tabPanel("")
      )
    ),
    #tab 2
    tabPanel(
      "subtitle 2"
    ),
    #tab 3
    tabPanel(
      "subtitle3"
    ),
    tabPanel(
      selectInput(
      "terms",
      "Select terms:",
      choices = ""
    )
    ),
    tabPanel(
      radioButtons(
      "choose.grade",
      "select grades:",
      choices = ""  
    )
    )
    
  )
  
)
)
#   # Application title
#   titlePanel("LendingClub Loan Listing Data"),
#   
#   # Sidebar with a slider input for number of bins
#   sidebarPanel(
#     selectInput(
#       "terms",
#       "Select terms:",
#       choices = ""
#     ),
#     radioButtons(
#       "choose.grade",
#       "select grades:",
#       choices = ""  
#     )
#   ),
#   
#   # Show a table of the active loans
#   mainPanel(
#     DT::dataTableOutput("dailyLoan")
#   )
# ))
