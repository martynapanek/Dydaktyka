library(shiny)
load('gospodarstwa.rda')

shinyServer(
  function(input,output) {
    woj_value <- reactive({
      
    })
    x <- gosp$dochg
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