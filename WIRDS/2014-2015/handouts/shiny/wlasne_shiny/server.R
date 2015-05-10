### load packages
library(ggplot2)
library(knitr)

### data mungling
shinyServer(
  function(input, output) {
    output$text <- renderText({
      input$text
    })
    output$plot <- renderPlot({
      x <- rnorm(input$n)
      y <- rnorm(input$n)
      plot(x,y)
      title(main = input$title)
    })
  }
)
