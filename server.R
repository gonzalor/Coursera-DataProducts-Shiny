# Server logic of the Shiny Application

library(shiny)
library(leaflet)
library(DT)

shinyServer(function(input, output) {
    output$issuesByType <- renderPlot({

        # Filter Data
        filtered <- issues %>%
          filter(
            is.null(input$zones) | Zone %in% input$zones,
            is.null(input$types) | Type %in% input$types
        )
    
        # Sumarizes Data
        if (input$xaxis=="types") {
            d <- filtered %>% group_by(Type, Month) %>% summarise(Count = n(), Resolution = mean(ResolutionDays))
            ylabel <- xlab("Issue Type")
        } 
        else {
            d <- filtered %>% group_by(Zone, Month) %>% summarise(Count = n(), Resolution = mean(ResolutionDays))
            ylabel <- xlab("Zone")
        }
    
        # Normalize X Name
        names(d)[1] = "x"
    
        # Boxplot of Issues By Type
        if(input$yaxis == "count") {
            d$y <- d$Count
            xlabel <- ylab("Monthly Count")
        } 
        else 
        {
            d$y <- d$Resolution
            xlabel <- ylab("Resolution Time [Days]")
        }
  
        g <- ggplot(d, aes(x=x, y=y, fill = x)) 
        g <- g + ggtitle("Service Issues Year 2014") + geom_boxplot() 
        g <- g + guides(fill=FALSE) + xlabel + ylabel
    
        # Logarithmic Scale
        if (input$chkByTypeLogScale) {
            g <- g + scale_y_log10()
        }
        
        # Render Graphics
        g
    })

    
    # Prediction
    output$prediction <- renderText({
        
        if (input$predZone=="" || input$predType==""){
            return ("Select Type and Zone to Predict")
        } else {
        
            # Create prediction
            pred <- predict(fit, newdata = data.frame(Type=c(input$predType), Zone=c(input$predZone)))

            # Output Prediction
            sprintf("Resolution time predicted for type %s in zone %s is of %s days", input$predType, input$predZone, round(pred[1],1))
        }
    })
    
    # Data Table
    output$table <- DT::renderDataTable({
        df <- issues %>%
            filter(
                ResolutionDays >= input$tblMinDays,
                ResolutionDays <= input$tblMaxDays,
                is.null(input$tblzones) | Zone %in% input$tblzones,
                is.null(input$tbltypes) | Type %in% input$tbltypes
            )
        DT::datatable(df, escape = FALSE)
    })
    
    # Data Summary
    output$datasummary <- renderPrint({
        str(issues)
    })
    
})
