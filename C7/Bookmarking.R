## bookmarking the shiny app
## encoding the state into a URL
library(shiny)
App <- function(){
  ui <- function(request){
    fluidPage(
      textInput("inputxt", "Enter Number"),
      verbatimTextOutput("outsquare"),
      bookmarkButton()
    )
  }
  
  server <- function(input, output, session){
    output$outsquare <- renderText({
      (as.numeric(input$inputxt) * as.numeric(input$inputxt))
    })
  }
  
  shinyApp(ui, server, enableBookmarking = "url")
  
}
App()