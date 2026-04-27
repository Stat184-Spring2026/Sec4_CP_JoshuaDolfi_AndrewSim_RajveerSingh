# Investment Analysis

Data-driven insight into different markets, able to be traded on.

---

## Project Goal

Analyze the historical data of the S&P 500, Bitcoin, and Gold to see which makes the best investment.

---

## Project Structure

Bitcoin.csv
S&P500.csv
Gold.csv

S&P_Data.R

---

## Data

Each CSV file contains one year of daily historical price data with the following columns:

| Column | Description |
|--------|-------------|
| Date | Trading date (YYYY-MM-DD) |
| Open | Opening price |
| High | Daily high |
| Low | Daily low |
| Close | Closing price |
| Volume | Trading volume |

---

## Visualizations

Plots are generated in R using `ggplot2` and include:

- Historical price trend over the past year

---

## Recommendation Logic

Assets are ranked based on volatility and risk

A final summary table states which asset is recommended and why.

---

## How to Run

### 1. Install required R packages

```r
install.packages(c("tidyverse", "ggplot2", "readr", "writexl"))
```

### 2. Add CSV data

Place your data files in the `data/` folder following the column structure above.

Open each script in RStudio and run

---

## Assets Covered

| Asset | Description | Risk Level |
|-------|-------------|------------|
| Gold | Traditional safe-haven commodity | Low to Medium |
| S&P 500 | Index of 500 large US companies | Medium |
| Crypto | Cryptocurrency (e.g. BTC, ETH) | High |

---

## Dependencies

```
tidyverse
ggplot2
```

---

## Authors

Rajveer, Andrew, and Joshua  
Pennsylvania State University
