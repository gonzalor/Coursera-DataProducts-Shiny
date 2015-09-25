
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#
#

library(shiny)
library(leaflet)

shinyUI(
  navbarPage("Tab1", id="nav",
    tabPanel("TabPanel",
             pageWithSidebar(
               
               # Application title
               headerPanel("Old Faithful Geyser Data"),
               
               # Sidebar with a slider input for number of bins
               sidebarPanel(
                 sliderInput("bins",
                             "Number of bins:",
                             min = 1,
                             max = 50,
                             value = 30)
               ),
               
               # Show a plot of the generated distribution
               mainPanel(
                 plotOutput("distPlot")
               )
             )
             
             
             
             
             
             
             ),
    tabPanel("TabPanel2"
             ,
             fluidRow(
               column(3,
                      selectInput("states", "States", c("All states"="", structure(state.abb, names=state.name), "Washington, DC"="DC"), multiple=TRUE)
               ),
               column(3,
                      conditionalPanel("input.states",
                                       selectInput("cities", "Cities", c("All cities"=""), multiple=TRUE)
                      )
               ),
               column(3,
                      conditionalPanel("input.states",
                                       selectInput("zipcodes", "Zipcodes", c("All zipcodes"=""), multiple=TRUE)
                      )
               )
             ),
             fluidRow(
               column(1,
                      numericInput("minScore", "Min score", min=0, max=100, value=0)
               ),
               column(1,
                      numericInput("maxScore", "Max score", min=0, max=100, value=100)
               )
             ),
             hr(),
             DT::dataTableOutput("ziptable")
             
             )
  )
  
    


#   pageWithSidebar(
#   
#   # Application title
#   headerPanel("Old Faithful Geyser Data"),
#   
#   # Sidebar with a slider input for number of bins
#   sidebarPanel(
#     sliderInput("bins",
#                 "Number of bins:",
#                 min = 1,
#                 max = 50,
#                 value = 30)
#   ),
#   
#   # Show a plot of the generated distribution
#   mainPanel(
#     plotOutput("distPlot")
#   )
# )

)
