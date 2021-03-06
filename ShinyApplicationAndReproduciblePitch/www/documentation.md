# Documentation: Forecasting Precious Metal Price Trend with Exponential Smoothing (ETS)

## Overview

Precious metals offer insights into economic health and are often viewed as a safe haven during times of economic turmoil. The objective of this Shiny Web App is to forecast precious metal price trend for the next 24 months with exponential smoothing (ETS). The data is sourced from [**OANDA**](https://www.oanda.com).

## Sidebar Panel

1. **Precious Metal:** Select the precious metal you would like to forecast from the radio-buttons-list. The available options are "Gold", "Palladium", "Platinum", and "Silver".

2. **Exponential Smoothing Model**

    - **Error Type:** Choose the error type of your exponential smoothing model. The available options are "Additive", "Multiplicative", and "Automatically Select".
    
    - **Trend Type:** Choose the trend type of your exponential smoothing model. The available options are "None", "Additive", "Multiplicative", and "Automatically Select".
    
    - **Season Type:** Choose the season type of your exponential smoothing model. The available options are "None", "Additive", "Multiplicative", and "Automatically Select".
    
3. **Show ETS Model Details:** Check the checkbox if you intend to show the exponential smoothing model details. The details include smoothing parameters (alpha, beta, gamma, phi), initial states (l, b, s), sigma, AIC, AICc, and BIC.

4. **Forecast Confidence Interval:** Use the slider to choose the confidence interval level for your forecast.

5. Click on the **Apply Changes** button to apply your selections and see the forecast results.

## Main Panel

- **Forecast Tab:** The observed precious metal price and forecast for the next 24 months will be shown on an interactive chart. If the "*Show ETS Model Details*" checkbox is checked, the details of your model will be shown below the interactive chart.

- **Chart Series Tab:** A simple financial chart for the chosen precious metal will be shown.

- **OHLC Data Tab:** The monthly Open, High, Low, and Close price of the chosen precious metal will be shown. Each column can be sorted according to your viewing preferences.

*DISCLAIMER: This Shiny Web App is for educational purposes only. The data and forecast accuracies are not guaranteed.*
