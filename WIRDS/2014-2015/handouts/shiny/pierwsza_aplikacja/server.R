library(shiny)

shinyServer(
  function(input,output) {
    x <- rnorm(n = 100)
    ### tworzymy wykres
    output$wykres <- renderPlot(
      {
        z <- x[ x>= input$zakres[1] & x <= input$zakres[2]]
        hist(z)
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