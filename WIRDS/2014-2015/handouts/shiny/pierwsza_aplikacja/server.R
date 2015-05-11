library(shiny)

shinyServer(
  function(input,output) {
    output$wykres <- renderPlot(
      {
        x <- rnorm(n = 100)
        hist(x)
      }
    )
  }
)