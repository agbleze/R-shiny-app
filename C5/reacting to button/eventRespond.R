library(shiny)


## UI.R
ui <- fluidPage(
  titlePanel("Javascript Events"),
  sidebarLayout(
    sidebarPanel(
      actionButton("redraw", "Redraw plot")
    ),
    
    mainPanel(
      plotOutput("testPlot"),
      includeHTML("event.js")
    )
  )
)


server <- function(input, output){
  
  output$testPlot <- renderPlot({
    input$redraw
    Sys.sleep(5)
    plot(1:10)
  })
}

shinyApp(ui = ui, server = server)