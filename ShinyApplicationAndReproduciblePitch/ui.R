library(shiny)
library(quantmod)
library(forecast)
library(plotly)

shinyUI(fluidPage(
    titlePanel("Forecasting Precious Metal Price Trend with Exponential Smoothing (ETS)"),
    a(em("Click Here to View Documentation"),
      href = "documentation.html",
      target = "_blank"),
    sidebarLayout(
        sidebarPanel(
            radioButtons("symbol",
                         "Precious Metal:",
                         c("Gold" = "XAU/USD",
                           "Palladium" = "XPD/USD",
                           "Platinum" = "XPT/USD",
                           "Silver" = "XAG/USD")),
            
            hr(style = "border-color: black"),
            
            h4("Exponential Smoothing Model"),
            
            selectInput("model_error",
                        "Error Type:",
                        c("Additive" = "A",
                          "Multiplicative" = "M",
                          "Automatically Select" = "Z"),
                        selected = "M"),
            
            selectInput("model_trend",
                        "Trend Type:",
                        c("None" = "N",
                          "Additive" = "A",
                          "Multiplicative" = "M",
                          "Automatically Select" = "Z"),
                        selected = "M"),
            
            selectInput("model_season",
                        "Season Type:",
                        c("None" = "N",
                          "Additive" = "A",
                          "Multiplicative" = "M",
                          "Automatically Select" = "Z"),
                        selected = "M"),
            
            checkboxInput("show_model",
                          "Show ETS Model Details"),
            
            hr(style = "border-color: black"),
            
            sliderInput("confidence",
                        "Forecast Confidence Interval:",
                        min = 0,
                        max = 100,
                        value = 95,
                        step = 5),
            
            submitButton("Apply Changes")
        ),
        mainPanel(
            tabsetPanel(
                type = "tabs",
                tabPanel("Forecast",
                         br(),
                         plotlyOutput("plot_fcast"),
                         br(),
                         verbatimTextOutput("ets_model")),
                tabPanel("Chart Series",
                         br(),
                         plotOutput("plot_cs")),
                tabPanel("OHLC Data",
                         br(),
                         dataTableOutput("table_ohlc"))
            )
        )
    ),
    p(em("DISCLAIMER: This Shiny Web App is for educational purposes only. The data and forecast accuracies are not guaranteed."),
      style = "text-align: center")
))
