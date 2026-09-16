# Olist Logistics Performance Analysis

I analyzed 96,000+ real orders from Olist, a Brazilian e-commerce marketplace, to figure out what was driving late deliveries and what to do about it.

## What I found
- **93.2% on-time delivery** across 96,478 delivered orders. The other 6.8% arrived late.
- **Last-mile delivery is the main problem.** Late orders spent 27.4 days in last-mile vs 7.9 for on-time ones. That's a 3.5x gap.
- **Slow pickup makes it worse.** Late orders waited 5.8 days for carrier pickup vs 3.0 for on-time orders.
- **March 2018 was rough.** The late rate spiked to 18.9%, nearly 3x baseline, when carrier capacity tightened.
- **Distance hurts.** AL, MA, and RJ had the highest late rates (12-21%), mostly because of distance from distribution centers.

## What I'd recommend
1. Hold carriers to their SLAs on last-mile. A 27.4 vs 7.9 day gap is a carrier problem, not a warehouse problem.
2. Flag any order not picked up within 3 days. Pickup delay is the earliest warning sign of a late delivery.

## How it's built
| Layer | Tools |
|---|---|
| Analysis | Python (pandas, NumPy, seaborn, matplotlib) |
| Queries | SQL (SQLite), custom KPI queries |
| Dashboard | Tableau (previews in `dashboard/screenshots/`) |

The notebooks walk through the whole thing in order: exploration, cleaning, KPI engineering, root-cause analysis. SQL queries are in `sql/`.

## Data
The Olist Brazilian E-Commerce public dataset on Kaggle. Raw CSVs are gitignored, so download them from Kaggle if you want to reproduce the analysis.

## Author
Hamed Sharafeldin — [LinkedIn](https://www.linkedin.com/in/hamed-sharafeldin-821273203/) | [GitHub](https://github.com/HamedXa)
