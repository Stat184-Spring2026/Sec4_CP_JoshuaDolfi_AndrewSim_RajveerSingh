# Investment Forecasting Dashboard

A data-driven forecasting tool that analyzes historical price data across three major asset classes — Gold, S&P 500, and Cryptocurrency — and recommends where to allocate your money for the best long-term returns.

---

## Project Goal

Forecast future prices for Gold, the S&P 500, and Cryptocurrency using one year of historical data, then provide a clear, data-backed recommendation on which asset offers the best long-term investment opportunity.

---

## Project Structure

```
investment-forecasting/
│
├── data/
│   ├── gold_prices.csv
│   ├── sp500_prices.csv
│   └── crypto_prices.csv
│
├── forecasting/
│   ├── gold_forecast.R
│   ├── sp500_forecast.R
│   └── crypto_forecast.R
│
├── outputs/
│   ├── forecasted_prices.xlsx
│   └── recommendation_report.xlsx
│
├── README.md
```

---

## Data

Each CSV file contains one year of daily historical price data with the following columns:

| Column | Description |
|--------|-------------|
| Date | Trading date |
| Price | Closing price |
| Open | Opening price |
| High | Daily high |
| Low | Daily low |
| Vol. | Trading volume |
| Change % | Daily percentage change |

---

## Forecasting Approach

Each asset is modeled using two basic forecasting techniques trained on the one-year historical CSV data, producing a 30/60/90-day price forecast.

Models used:

- **Linear Regression** — fits a trend line through historical prices and extends it forward
- **Moving Average** — smooths out historical data and projects the continuing trend

---

## Visualizations

Plots are generated in R using `ggplot2` and include:

- Historical price trend over the past year
- Forecasted price trajectory
- Side-by-side comparison of all three assets
- Projected percentage return over the forecast window

Plots are exported to Excel for the final deliverable.

---

## Recommendation Logic

Assets are ranked based on:

1. Projected percentage return
2. Volatility and risk
3. Risk-adjusted return (Sharpe-style score)

A final summary table states which asset is recommended and why.

---

## How to Run

### 1. Install required R packages

```r
install.packages(c("tidyverse", "writexl"))
```

### 2. Add CSV data

Place your data files in the `data/` folder following the column structure above.

### 3. Run the forecasting scripts

Open each script in RStudio and run, or execute from the terminal:

```bash
Rscript forecasting/gold_forecast.R
Rscript forecasting/sp500_forecast.R
Rscript forecasting/crypto_forecast.R
```

### 4. View output

Open `outputs/forecasted_prices.xlsx` for charts and `outputs/recommendation_report.xlsx` for the final recommendation.

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
writexl
```

---

## Disclaimer

This project is for educational and research purposes only. Forecasts are based on historical data and statistical models and do not constitute financial advice. Always do your own research before making investment decisions.

---

## Data Source 

Historical market data for Bitcoin, Gold, and the S&P 500 was collected from Investing.com.

---

## Authors

Rajveer, Andrew, and Joshua  
Pennsylvania State University
