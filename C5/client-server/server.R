#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# load library
library(shiny)

function(input, output, session){
  output$randomNumber = renderText({
    theNumber = sample(1:input$pickNumber, 1)
    session$sendCustomMessage(type = 'sendMessage', message = theNumber)
    return(theNumber)
  })
  
  output$theMessage = renderText({
    return(input$JsMessage)
  })
}