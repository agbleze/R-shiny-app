library(tidyverse)
library(shiny)
library(gapminder)


####### server logic of the app #########
### load data
load("geocodedData.Rdata")
##### define interactive part of the application
function(input, output){
  output$plotDisplay <- renderPlot({
    gapminder %>%
      filter(country == input$country) %>%
      ggplot(aes(x = year, y = lifeExp)) + geom_line()
  })
  
  output$outputLink <- renderText({
    link = "https://en.wikipedia.org/wiki/"
    
    paste0('<form action="', link, input$country, '">
    <input type="submit" value="Go to Wikipedia">
    </form>'
    )
  })
}