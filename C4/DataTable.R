library(DT)
#### server.R
server = function(input, output){
  output$countryTable <- renderDataTable({
    datatable( mapData %>%
                 filter(year == 2007) %>%
                 select(-c(lon, lat)),
               colnames = c("Country", "Continent", "Year", "Life expectancy", "population", "GDP per capita"),
               caption = "County details", filter = "top",
               options = list(
                 pageLength = 15,
                 lengthMenu = c(10, 20, 50)
               ))
   
  })
}

#### ui.R
ui <-  tabPanel("Table", dataTableOutput("countryTable"), value = "table")

shinyApp(ui, server)
