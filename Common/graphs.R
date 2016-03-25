library(dygraphs)

source("Common/load_data.R")

# dygraphs application
  #
oneSeriesPlot <- function(dataInput, shinyInput){
  dygraph(dataInput, main = "plot") %>%
    dyLegend(show = "auto", labelsSeparateLines = TRUE) %>%
    dyAxis("x", drawGrid = FALSE) %>%
    dyRangeSelector(height = 20)
}



######################test########################

hw <- HoltWinters(ldeaths)
predicted <- predict(hw, n.ahead = 72, prediction.interval = TRUE)

dygraph(predicted, main = "Predicted Lung Deaths (UK)") %>%
  dyAxis("x", drawGrid = TRUE) %>%
  dySeries(c("lwr", "fit", "upr"), label = "Deaths") %>%
  dyOptions(colors = RColorBrewer::brewer.pal(3, "Set1"))

lungDeaths <- cbind(mdeaths, fdeaths)
dygraph(lungDeaths) %>%
  dySeries("mdeaths", label = "Male") %>%
  dySeries("fdeaths", label = "Female") %>%
  dyOptions(stackedGraph = TRUE) %>%
  dyRangeSelector(height = 20)

######################test########################
