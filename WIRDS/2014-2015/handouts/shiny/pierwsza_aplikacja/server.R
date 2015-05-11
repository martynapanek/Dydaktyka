library(shiny)

shinyServer(
  function(input,output) {
    x <- rnorm(n = 100)
    ### tworzymy wykres
    output$wykres <- renderPlot(
      {
        hist(x)
      }
    )
    ### tworzymy podsumowanie
    output$podsumowanie <- renderPrint(
      {
        y <- summary(x)
        print(y)
      }
    )
  }
)