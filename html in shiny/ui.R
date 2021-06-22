## working with html and shinny
library(shiny)

##### designing the UI of the app
fluidPage(
  tags$head(HTML("<link href='http://fonts.googleapi.com/css?family=Jura' rel='stylesheet' type='text/css'>")),
  
  h2("Custom HTML", style = "font-family: 'Jura';
     color: red; font-size: 64px;"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("country", "Country", 
                   c("Afghanistan", "Bahrain", "Cambodia")
    )
  ),
  
  mainPanel(
    h3("Time series"),
    HTML("<p><em>Life expectancy</em> over time</p>"),
    plotOutput("plotDisplay"),
    htmlOutput("outputLink")
  )
  )
)



