## navlist
server = function(input, output){
  output$table = renderTable({
    head(iris)
  })
}

ui = fluidPage(
  navlistPanel("navlistDemo",
               tabPanel("Inputs",
                        sliderInput("slider", "Slider", min = 1, max = 100, value = 50),
                        textInput("text", "Text")),
               tabPanel("Tabel", tableOutput("table"))
               )
)
shinyApp(ui, server)