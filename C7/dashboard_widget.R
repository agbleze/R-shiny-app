## app.R ##
## creating dashboard with widgets
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    fileInput("file", label = h3("File input")),
    
    hr(),
    fluidRow(column(4, verbatimTextOutput("value"))),
    
    fluidRow(column(4,
                    passwordInput("password", "Passwrd: "),
                    actionButton("go", "Go"),
                    verbatimTextOutput("passwordDisplay")))
    
  )
  )
)

server <- function(input, output){
  output$value <- renderPrint({
    str(input$file)
  })
  
  output$passwordDisplay <- renderText({
    req(input$go)
    isolate(input$password)
  })
}
shinyApp(ui, server)
