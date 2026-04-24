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


View(sp_data)

##Graph the Plot
sp_plot <- ggplot(sp_data, aes(x = `Date`, y = `Percent Change`, color = `Percent Change` > 0)) + 
  geom_col() + 
  scale_color_manual(values = c("red", "green")) + 
  labs(title = "S&P 500 Daily Percent Change",
       x = "Date",
       y = "Percent Change") + 
  theme_minimal()

sp_plot

##Summary Statistics
summary(sp_data$`Percent Change`)