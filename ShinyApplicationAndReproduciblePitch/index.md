Course Project: Shiny Application and Reproducible Pitch
========================================================
author: Author: Poo, L. S.
date: Date: 21 February 2017
autosize: true

Forecasting Precious Metal Price Trend with Exponential Smoothing (ETS)
========================================================
1. Precious metals offer insights into economic health and are often viewed as a safe haven during times of economic turmoil.
2. The objective of this Shiny Web App is to forecast precious metal price trend for the next 24 months with exponential smoothing (ETS).
3. The data is sourced from [**OANDA**](https://www.oanda.com).
4. The ui.R and server.R files are here: [https://github.com/poolupsoon/DevelopingDataProducts/tree/master/ShinyApplicationAndReproduciblePitch](https://github.com/poolupsoon/DevelopingDataProducts/tree/master/ShinyApplicationAndReproduciblePitch)
5. The Shiny Web App is here: [https://poolupsoon.shinyapps.io/shinyapplicationandreproduciblepitch/](https://poolupsoon.shinyapps.io/shinyapplicationandreproduciblepitch/)

Getting and Processing Data
========================================================

```r
library(quantmod)
library(forecast)
library(plotly)

my_symbol <- getSymbols("XAU/USD",
                        src = "oanda",
                        auto.assign = FALSE,
                        from = "2012-01-01")
 
my_ts <- ts(Op(to.monthly(my_symbol)),
            frequency = 12)

my_ets <- ets(my_ts,
              model = "MMM")

my_fcast <- forecast(my_ets,
                     level = 95)
```

Plotting the Forecast
========================================================

```r
my_plot <- plot_ly() %>%
    add_lines(x = time(my_fcast$fitted),
              y = my_fcast$fitted,
              color = I("black"),
              name = "Observed") %>%
    add_lines(x = time(my_fcast$mean),
              y = my_fcast$mean,
              color = I("blue"),
              name = "Forecast") %>%
    add_ribbons(x = time(my_fcast$mean),
                ymin = my_fcast$lower,
                ymax = my_fcast$upper,
                color = I("gray"),
                name = "95% Confidence") %>%
    layout(title = paste("Precious Metal Price Forecast for XAU/USD with", my_ets$method),
           xaxis = list(title = "Year"),
           yaxis = list(title = "Precious Metal Price (in USD)"))
```

Plotting the Forecast
========================================================

<iframe src = "my_plot.html", style = "position: absolute; width: 100%; height: 100%"></iframe>
