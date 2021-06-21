#
# This is the user-interface definition of a Shiny web application develop with gapminder. You can
# run the application by clicking 'Run App' above.
#
### install packages
install.packages("devtools")
library(devtools)
devtools::install_github("dkahle/ggmap")
library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
fluidPage(
    titlePanel("Gapminder"),
    sidebarLayout(
        sidebarPanel(
            # input controls in here
            sliderInput(inputId = "year",
                        label = "Years included",
                        min = 1952,
                        max = 2007,
                        value = c(1952, 2007),
                        sep = "",
                        step = 5
                        ),
            checkboxInput("linear", label = "Add trend line?", value = FALSE)
        ),
        mainPanel(
            # outputs here
            tabsetPanel(
                tabPanel("Summary", textOutput("summary")),
                tabPanel("Trend", plotOutput("trend")),
                tabPanel("Map", leafletOutput("map"),
                         p("Map data is from the most recent in the selected range; radius of circle is scaled to life expectancy"))
            )
        )
    )
)