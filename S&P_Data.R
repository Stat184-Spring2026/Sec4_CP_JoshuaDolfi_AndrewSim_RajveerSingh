library(dplyr)
library(ggplot2)

##Read in the Data
sp_data <- read.csv("https://raw.githubusercontent.com/Stat184-Spring2026/Sec4_CP_JoshuaDolfi_AndrewSim_RajveerSingh/refs/heads/main/S%26P%20500%20Historical%20Data.csv")

##Tidy the Data
sp_data <- sp_data %>% select(-"Vol.")

#Edit the % Change Column
sp_data <- sp_data %>%
  mutate(`Percent Change` = as.numeric(gsub("%", "", `Change..`)),
         Date = as.Date(Date, format = "%m/%d/%Y"),) %>%
  select(-`Change..`)

sp_month <- sp_data %>%
  mutate(Month = as.Date(format(Date, "%Y-%m-01"))) %>%
  group_by(Month) %>%
  summarise(`Percent Change` = round(mean(`Percent Change`, na.rm = TRUE), 4), .groups = "drop")

View(sp_month)

##Graph the Plot
sp_plot <- ggplot(sp_month, aes(x = `Month`, y = `Percent Change`)) + 
  geom_col(fill = "green") + 
  labs(title = "S&P 500 Daily Percent Change",
       x = "Month",
       y = "Percent Change") + 
  theme_minimal()
sp_plot

##Summary Statistics
summary(sp_month$`Percent Change`)