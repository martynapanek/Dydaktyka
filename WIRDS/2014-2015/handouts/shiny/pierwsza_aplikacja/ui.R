
shinyUI(
  fluidPage(
    
    titlePanel('Testowa aplikacja'),
    
    sidebarLayout(
      ### określamy jakie elementy może użytkownik wybrać
      sidebarPanel(
        selectInput(
          inputId = 'woj',
          label = 'Wybierz województwo',
          choices = c(
            'dolnośląskie'='02',
            'kujawsko-pomorskie'='04',
            'lubelskie'	='06',
            'lubuskie'='08',
            'łódzkie'='10',
            'małopolskie'	= '12',
            'mazowieckie'='14',
            'opolskie'='16',
            'podkarpackie'='18',
            'podlaskie'='20',
            'pomorskie'='22	',
            'śląskie'='24',
            'świętokrzyskie'	='26',
            'warmińsko-mazurskie'	='28',
            'wielkopolskie'	='30',
            'zachodniopomorskie'	='32'
          ),
          selected = '02'
        ),
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