
shinyUI(
  fluidPage(
    
    titlePanel('Testowa aplikacja'),
    
    sidebarLayout(
      ### określamy jakie elementy może użytkownik wybrać
      sidebarPanel(
        sliderInput(
          inputId = 'zakres',
          label = 'Wybierz zakres',
          min = -2,
          max = 2,
          value = c(-1,1),
          step = 0.01
        )
      ),
      ### główny wykres
      mainPanel(
        plotOutput('wykres'),
        verbatimTextOutput('podsumowanie')
      )
    )
  )
)