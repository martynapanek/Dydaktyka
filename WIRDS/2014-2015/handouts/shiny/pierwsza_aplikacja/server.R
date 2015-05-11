library(shiny)
load('gospodarstwa.rda')

shinyServer(
  function(input,output) {
    
    x <-  reactive({ 
      gosp$dochg[gosp$woj == input$woj]
    })
    
    ### tworzymy wykres
    output$wykres <- renderPlot(
      {
        x <- x()
        z <- x[ x>= input$zakres[1] & x <= input$zakres[2]]
        hist(z)
      }
    )
    ### tworzymy podsumowanie
    output$podsumowanie <- renderPrint(
      {
        x <- x()
        y <- summary(x)
        print(y)
      }
    )
  }
)