
shinyUI(
  fluidPage(
    
    titlePanel('Testowa aplikacja'),
    
    sidebarLayout(
      ### określamy jakie elementy może użytkownik wybrać
      sidebarPanel(
        sliderInput(
          inputId = 'zakres',
          label = 'Wybierz zakres',
          min = -30000,
          max = 55000,
          value = c(-30000,55000),
          step = 100
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