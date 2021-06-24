### navbar UI
server = function(input, output){
  output$table = renderTable({
    head(iris)
  })
}

ui = navbarPage("NavbarDemo", 
                tabPanel("Inputs",
                         sliderInput("slider", "Slider", min = 1, max = 100, value = 50),
                         textInput("text", "Text", placeholder =  "text here")),
                tabPanel("Table", tableOutput("table"))
                )
shinyApp(ui, server)
