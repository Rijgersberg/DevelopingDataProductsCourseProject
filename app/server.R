library(shiny)
library(ggplot2)
# code here only runs a single time, when you run runApp()
degreeday <- function(temperature, heating_temperature) {
    pmax(0,heating_temperature - temperature)
}

temperatures <- read.csv('data/temperature.csv')
temperatures$date <- as.POSIXct(strptime(temperatures$date, format="%Y-%m-%d"))

gasusage <- read.csv('data/Liander_daily.csv')
gasusage$date <- as.POSIXct(strptime(gasusage$date, format="%Y-%m-%d"))

scatter_df <- data.frame(degreedays=degreeday(temperatures$temperature,18), 
                         gasusage=gasusage$Klant.1)

fit1 <- lm(degreedays ~ gasusage, data=scatter_df )


shinyServer(
    function(input, output) {
        #normal code here only runs once every user or refresh of the page
        
        
        #this runs reactively because of the render* functions
        output$out_heating_temperature <- renderPrint({input$heating_temperature})
        output$out_degreeday <- renderPrint({degreeday(15,input$heating_temperature)})
        
        output$linmod <- renderPrint(summary(fit1()))
       
        output$temperaturePlot <- renderPlot({
            ggplot(temperatures, aes(date, temperature)) +
                geom_line()
        })
        output$gasPlot <- renderPlot({
            ggplot(gas_df(), aes(date, y = 'Gas usage (m^3 per day)', color = variable)) +
                geom_line(aes(y = gasusage, color='gasusage')) +
                geom_line(aes(y = prediction, color='prediction'))
        })
        output$gasTempScatter <- renderPlot({
            ggplot(scatter_df(), aes(x=degreedays, y=gasusage)) + 
                geom_point() + geom_smooth(method=lm)
        })
        
        # this code is explictly reactive
        x <- reactive({input$heating_temperature+100})
        
        scatter_df <- reactive({
            data.frame(degreedays=degreeday(temperatures$temperature,input$heating_temperature), 
                       gasusage=gasusage$Klant.1)
        })
        
        fit1 <- reactive({
            lm(gasusage ~ degreedays, data=scatter_df())
        })
        
        prediction <- reactive({
            predict(fit1(), newdata=scatter_df())
        })
        
        gas_df <- reactive({
            data.frame(date=gasusage$date, gasusage=scatter_df()$gasusage,
                       prediction=prediction())
        })
        
    }
    )