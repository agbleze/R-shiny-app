##ui.R for the interface of the app
# load library
library(shiny)
#### designing the layout
fluidPage(
  # flexible layout function
  h4(HTML("Think of a number: </br>Does Shiny or </br> Javascript rule?")),
  sidebarLayout(
    sidebarPanel(
      # sidebar configuration
      sliderInput("pickNumber", "Pick a number",
                  min = 1, max = 10, value = 5),
      tags$div(id = "output") # tags$xx for holding dropdown
    ),
    
    mainPanel(
      includeHTML("dropdownDepend.js"),  # include JS file
      textOutput("randomNumber"),
      hr(),
      textOutput("theMessage")
    )
  )
)