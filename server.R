#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(gapminder)
library(leaflet)
library(ggmap)
library(tidyverse)

# load data and process it into a ready format if the data does not already exist
if(!file.exists("geocodeData.Rdata")) { # runs the code in the if function if the data file does not exist in the location
    mapData = gapminder %>%  ## pipe gapminder data to mapData
        mutate(country2 = as.character(country)) %>%  ## add the column country2 and defines its character type as character
        group_by(country) %>%  ## groups data base on country column
        slice(1) %>%  ## select the first row of the data
        mutate_geocode(country2, source = "dsk") %>%  ## adds a geocode column
        select(-country2)  ## select all columns except country
    mapData = left_join(gapminder, mapData) %>% ## joins the mapData to gapminder
        group_by(country) %>%
        fill(lon) %>%  ## fill in the longitudes
        fill(lat)   ## fill in the latitudes
    save(mapData, file = "geocodedData.Rdata")  ## saves the result file in directory
} else {  ## if the data already exist in the directory, it is loaded without all the processes in the if block
    load("geocodedData.Rdata")
}

# Define server logic required for processing data 
shinyServer(function(input, output) {
    theData = reactive({   ## reactive objects allows caching of data and prevent repeated running of same instances to save time
        mapData %>%
            filter(year >= input$year[1], year <= input$year[2])
    })
    
    output$summary = renderText({
        paste0(input$year[2] - input$year[1], "years are selected. There are ",
               length(unique(theData()$country)), "countries in the datset measured at ",
               length(unique(theData()$year)), "occassions.")
    })
    
    output$trend = renderPlot({
        thePlot = theData() %>%
            group_by(continent, year) %>%
            summarise(meanLife = mean(lifeExp)) %>%
            ggplot(aes(x = year, y = meanLife, group = continent, colour = continent)) + geom_line() + ggtitle("Graph to show life expectancy by continent over time")
        if(input$linear){
            thePlot = thePlot + geom_smooth(method = "lm")
        }
        print(thePlot)
    })
    
    output$map = renderLeaflet({
        mapData %>%
            filter(year == input$year[2]) %>%
            leaflet() %>%
            addTiles() %>%
            setView(lng = 0, lat = 0, zoom = 2) %>%
            addCircles(lng = ~ lon, lat = ~lat, weight = 1,
                           radius = ~lifeExp * 5000,
                       popup = ~ paste(country, lifeExp))
    })
})