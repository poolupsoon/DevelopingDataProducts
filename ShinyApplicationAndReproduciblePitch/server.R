library(shiny)
library(quantmod)
library(forecast)
library(plotly)

shinyServer(function(input, output) {
    my_symbol <- reactive({
        getSymbols(input$symbol,
                   src = "oanda",
                   auto.assign = FALSE,
                   from = "2012-01-01")
    })
    
    my_monthly <- reactive({
        to.monthly(my_symbol())
    })
    
    my_ts <- reactive({
        ts(Op(my_monthly()),
           frequency = 12)
    })
    
    my_ets <- reactive({
        my_model <- paste0(input$model_error,
                           input$model_trend,
                           input$model_season)
        ets(my_ts(),
            model = my_model)
    })
    
    my_fcast <- reactive({
        forecast(my_ets(),
                 level = input$confidence)
    })
    
    output$plot_fcast <- renderPlotly({
        plot_ly() %>%
            add_lines(x = time(my_fcast()$fitted),
                      y = my_fcast()$fitted,
                      color = I("black"),
                      name = "Observed") %>%
            add_lines(x = time(my_fcast()$mean),
                      y = my_fcast()$mean,
                      color = I("blue"),
                      name = "Forecast") %>%
            add_ribbons(x = time(my_fcast()$mean),
                        ymin = my_fcast()$lower,
                        ymax = my_fcast()$upper,
                        color = I("gray"),
                        name = paste0(input$confidence,
                                      "% Confidence")) %>%
            layout(title = paste("Precious Metal Price Forecast for",
                                 input$symbol,
                                 "with",
                                 my_ets()$method),
                   xaxis = list(title = "Year"),
                   yaxis = list(title = "Precious Metal Price (in USD)"))
    })
    
    output$ets_model <- renderPrint({
        if(input$show_model) {
            my_ets()
        }
        else {
            invisible(my_ets())
        }
    })
    
    output$plot_cs <- renderPlot({
        chartSeries(my_symbol(),
                    name = input$symbol)
    })
    
    output$table_ohlc <- renderDataTable({
        my_ohlc <- cbind(time(my_monthly()),
                         as.data.frame(my_monthly()))
        names(my_ohlc) <- c("Date",
                            "Open",
                            "High",
                            "Low",
                            "Close")
        my_ohlc[order(my_ohlc$Date,
                      decreasing = TRUE),]
    })
})
