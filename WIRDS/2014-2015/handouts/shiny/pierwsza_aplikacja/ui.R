
shinyUI(
  fluidPage(
    sidebarLayout(
      ### określamy jakie elementy może użytkownik wybrać
      sidebarPanel(),
      ### główny wykres
      mainPanel(
        plotOutput('wykres')
      )
      
    )
  )
)