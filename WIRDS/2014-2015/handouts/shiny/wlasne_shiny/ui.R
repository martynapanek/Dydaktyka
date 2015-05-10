### first moves

shinyUI(
  fluidPage (
    ### title of the panel
    titlePanel('Hello world! I am alive!'),
    ### sidebar
    sidebarLayout(
      ### sidebar
      sidebarPanel(
        textInput('title',
                  'Wpisz tytuł wykresu:',
                  value='Przykładowy tekst'),
        numericInput(
          'n',
          'Wpisz liczbę powtórzeń',
          value = 100
        )
      ),
      ### main panel
      mainPanel(
        h3(textOutput('text')),
        plotOutput('plot')
      )
    )
  )

)