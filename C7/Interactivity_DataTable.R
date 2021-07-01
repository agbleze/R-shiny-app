library(shiny)
library(DT)

shinyApp(
  ui = fluidPage(DTOutput('tbl')),
  server = function(input, output){
    output$tbl = renderDT(
      iris, options = list(lengthChange = FALSE)
    )
  }
)

### Render DT in client 
DT::renderDataTable(iris, server = FALSE)
