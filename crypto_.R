library(dplyr)
library(lubridate)
library(ggplot2)

## Read in the Data
btc_data <- read.csv("https://raw.githubusercontent.com/Stat184-Spring2026/Sec4_CP_JoshuaDolfi_AndrewSim_RajveerSingh/refs/heads/main/BTC_USD%20Bitfinex%20Historical%20Data-2.csv")

## Tidy the Data
btc_data <- btc_data %>% select(-"Vol.")

## Clean and Parse Columns (from original pipeline)
btc_data <- btc_data %>%
  mutate(
    Date        = as.Date(Date, format = "%m/%d/%Y"),
    Price       = as.numeric(gsub(",", "", Price)),
    Open        = as.numeric(gsub(",", "", Open)),
    High        = as.numeric(gsub(",", "", High)),
    Low         = as.numeric(gsub(",", "", Low)),
    `Percent Change` = as.numeric(gsub("%", "", Change..))
  ) %>%
  select(-Change..) %>%
  arrange(Date) %>%
  mutate(
    day_index        = row_number(),
    daily_return     = Price / lag(Price) - 1,
    daily_volatility = (High - Low) / Open,
    rolling_30_day_mean = stats::filter(Price, rep(1/30, 30), sides = 1) %>% as.numeric()
  )

## Forecast Function
forecast_asset <- function(asset_df, horizon_days = c(30, 60, 90), ma_window = 30) {
  fit        <- lm(Price ~ day_index, data = asset_df)
  last_day   <- max(asset_df$day_index)
  last_date  <- max(asset_df$Date)
  last_price <- asset_df$Price[asset_df$day_index == last_day][[1]]
  ma_change  <- mean(tail(asset_df$daily_return, ma_window), na.rm = TRUE)
  
  future_df <- tibble(
    horizon_days = horizon_days,
    day_index    = last_day + horizon_days,
    Date         = last_date + days(horizon_days)
  )
  
  linear_forecast <- future_df %>%
    mutate(
      Model           = "Linear Regression",
      Forecast_Price  = as.numeric(predict(fit, newdata = future_df)),
      Projected_Return = Forecast_Price / last_price - 1
    )
  
  moving_average_forecast <- future_df %>%
    mutate(
      Model           = "Moving Average",
      Forecast_Price  = last_price * (1 + ma_change)^horizon_days,
      Projected_Return = Forecast_Price / last_price - 1
    )
  
  bind_rows(linear_forecast, moving_average_forecast) %>%
    mutate(Asset = "Bitcoin")
}

## Aggregate to Monthly
btc_monthly <- btc_data %>%
  mutate(Month = format(Date, "%Y-%m")) %>%
  group_by(Month) %>%
  summarise(`Percent Change` = mean(`Percent Change`, na.rm = TRUE)) %>%
  mutate(Month = as.Date(paste0(Month, "-01")))

## Plot Monthly Avg Percent Change
btc_plot <- ggplot(btc_monthly, aes(x = Month, y = `Percent Change`)) +
  geom_col(fill = "green", width = 20) +
  labs(
    title = "BTC/USD Monthly Avg Percent Change",
    x     = "Month",
    y     = "Percent Change"
  ) +
  theme_minimal()

btc_plot

## Run Forecast
btc_forecast <- forecast_asset(btc_data)
print(btc_forecast)

## Summary Statistics
summary(btc_monthly$`Percent Change`)
