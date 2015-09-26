# Shiny application - User Interface
# 
library(shiny)
library(leaflet)
suppressPackageStartupMessages(library(ggplot2))

# Choices for drop-downs
varsXAxis <- c(
  "Types" = "types",
  "Zones" = "zones"
)

varsYAxis <- c(
  "Count" = "count",
  "Resolution Days" = "resolution"
)

shinyUI(
    navbarPage("Dashboard", id="nav",
        tabPanel("Plot",
            pageWithSidebar(
            # Issues By Type
            headerPanel("Resolved Issues in 2014"),
                # Configuration
                sidebarPanel(
                    
                    # X Axis Selection
                    selectInput("xaxis", "X Axis", varsXAxis),
                    
                    # Y Axis Selection
                    selectInput("yaxis", "Y Axis", varsYAxis),
                    
                    # Choose Zones
                    selectInput("zones", "Zones", c("All Zones"="", structure(zones, names=zones)), multiple=TRUE),
                    
                    # Choose Types
                    selectInput("types", "Types", c("All Types"="", structure(types, names=types)), multiple=TRUE),
                    
                    # Type of Scale
                    checkboxInput("chkByTypeLogScale", "Logarithmic Scale")
                ),
                # Show a plot of the generated distribution
                mainPanel(
                    plotOutput("issuesByType")
                )
            )
        ),
        tabPanel("Prediction",
                 pageWithSidebar(
                     # Predict Resolution time
                     headerPanel("Resolution Time in Days Prediction"),
                     # Configuration
                     sidebarPanel(
                         
                         # Choose Zone
                         selectInput("predZone", "Zone", c("Choose Zone..."="", structure(zones, names=zones)), multiple=FALSE),
                         
                         # Choose Type
                         selectInput("predType", "Type", c("Choose Issue Type.."="", structure(types, names=types)), multiple=FALSE)
                     ),
                     # Show a plot of the generated distribution
                     mainPanel(
                         verbatimTextOutput("prediction")
                     )
                 )
        ),
        tabPanel("Data Table",
            fluidRow(
                column(2, selectInput("tblzones", "Zones", c("All Zones"="", structure(zones, names=zones)), multiple=TRUE)),
                column(2,selectInput("tbltypes", "Types", c("All Types"="", structure(types, names=types)), multiple=TRUE)),
                column(2, numericInput("tblMinDays", "Min Days", min=0, max=100, value=0)),
                column(2, numericInput("tblMaxDays", "Max Days", min=0, max=100, value=100))
            ),
            hr(),
            DT::dataTableOutput("table")
        ),
        tabPanel("Help",
                h2("About the Project"),
                p("This application is part of the Course Project for the Coursera Developing Data Products Course (devdataprod-032). It intends to show a simple dashboard for a company that serves drinking water and process sewer liquids."),
                h3("The Data"),
                p("The sample data was taken form the issue tracker system of the company and anonimized for the purposes of this work. The data.frame has the following structure"),
                verbatimTextOutput("datasummary"),
                h2("How to use the application"),
                p("The application consists of different tabs, each of one demostrates an example application."),
                h3("Plot"),
                p("This panel allows the user to configure a boxplot chart by selecting the X and Y axis. Also, the data frame can be filtered by type and/or zone. Because for some comparissons there are boxplots near zero, it can be selected a logarithmic scale for de Y axis."),
                p("The main purpose of this panel is to play with different configurations and see how the graphic responds."),
                h3("Prediction"),
                p("It allows to predict the time (in days) expected for the issue resolution based on the type and zone. The prediction is made using a linear regression."),
                h3("Data Table"),
                p("This tab allows to browse the data frame in detail filtering by type, zone and/or time of resolution."),
                h3("Help"),
                p("This page.")
        )
    )
)
