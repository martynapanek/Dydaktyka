
shinyUI(
  fluidPage(
    
    titlePanel('Testowa aplikacja'),
    
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