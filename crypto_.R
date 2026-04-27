library(dplyr)
library(ggplot2)

## Read in the Data
btc_data <- read.csv("https://raw.githubusercontent.com/Stat184-Spring2026/Sec4_CP_JoshuaDolfi_AndrewSim_RajveerSingh/refs/heads/main/BTC_USD%20Bitfinex%20Historical%20Data-2.csv")

## Tidy the Data
btc_data <- btc_data %>% select(-"Vol.")

## Edit the % Change Column
btc_data <- btc_data %>%
  mutate(`Percent Change` = as.numeric(gsub("%", "", `Change..`)),
         Date = as.Date(Date, format = "%m/%d/%Y")) %>%
  select(-`Change..`)

## Aggregate to Monthly
btc_monthly <- btc_data %>%
  mutate(Month = format(Date, "%Y-%m")) %>%
  group_by(Month) %>%
  summarise(`Percent Change` = mean(`Percent Change`, na.rm = TRUE)) %>%
  mutate(Month = as.Date(paste0(Month, "-01")))

View(btc_monthly)

btc_plot <- ggplot(btc_monthly, aes(x = Month, y = `Percent Change`)) + 
  geom_col(fill = "green", width = 20) + 
  labs(title = "BTC/USD Monthly Avg Percent Change",
       x = "Month",
       y = "Percent Change") + 
  theme_minimal()

btc_plot

btc_plot

## Summary Statistics
summary(btc_monthly$`Percent Change`)

