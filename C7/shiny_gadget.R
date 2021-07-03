## creating shiny gadget
library(shiny)
library(miniUI)
library(ggplot2)
#install.packages("miniUI")

click_gadget <- function(data, xvar, yvar) {
  ui <- miniPage(
    gadgetTitleBar("Drag to select points"),
    miniContentPanel(
      plotOutput("plot", height = "100%", click = "plot_click")
    )
  )
  server <- function(input, output, session){
    #render the plot
    output$plot <- renderPlot({
      # Plot the data with x/y vars indicated by the caller.
      ggplot(data, aes_string(xvar, yvar)) + geom_point()
    })
    # Handle the done button being pressed.
    observeEvent(input$done, {
      # Return the brushed points. 
      stopApp(clickOpts(data, input$plot_click))
    })
  }
  runGadget(ui, server)
}

click_gadget(iris, "Sepal.Length", "Sepal.Width")
