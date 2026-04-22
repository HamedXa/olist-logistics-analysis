# Olist Logistics Performance Analysis

## Business Problem
A logistics analytics team needs visibility into delivery performance across 
a national fulfillment network. Key questions: Where are delays occurring? 
What is driving the 6.8% late delivery rate? Which regions are 
underperforming, and what operational changes would improve on-time delivery?

## Project Overview
End-to-end logistics analytics project analyzing 96,000+ real Brazilian 
e-commerce orders to identify delivery delay drivers, define operational KPIs, 
and deliver actionable recommendations — structured as an internal analytics 
engagement for a logistics operations team.

## Key Findings
- **On-time delivery rate: 93.2%** across 96,478 delivered orders
- **Last-mile delivery is the primary delay driver** — late orders average 
  27.4 days in last-mile vs 7.9 days for on-time orders (3.5x gap)
- **Carrier pickup compounds delays** — late orders wait 5.8 days for pickup 
  vs 3.0 days for on-time orders
- **March 2018 spike** — late rate hit 18.9%, nearly 3x the baseline, 
  driven by carrier capacity constraints
- **AL, MA, and RJ states** carry the highest late rates (12–21%), driven 
  by geographic distance from distribution centers

## Recommendations
1. Enforce carrier SLA contracts for last-mile delivery — the 27.4 vs 7.9 
   day gap signals a systemic carrier performance issue requiring 
   contract-level intervention
2. Flag orders not picked up within 3 days as high-risk — carrier pickup 
   delay is a leading indicator of late delivery

## Tech Stack
| Layer | Tools |
|---|---|
| Data cleaning & analysis | Python (pandas, NumPy, seaborn, matplotlib) |
| Database & querying | SQL (SQLite), custom KPI queries |
| Visualization | Tableau Public |
| Version control | Git / GitHub |

## Project Structure

olist-logistics-analysis/
├── data/
│   ├── raw/          ← 9 Olist CSV source files (gitignored)
│   └── processed/    ← Cleaned and engineered datasets (gitignored)
├── notebooks/
│   ├── 01_data_exploration.ipynb
│   ├── 02_data_cleaning.ipynb
│   ├── 03_kpi_engineering.ipynb
│   └── 04_root_cause_analysis.ipynb
├── sql/
│   ├── kpi_queries.sql
│   └── run_queries.py
├── dashboard/
│   └── screenshots/
└── README.md

## Dashboard
*Tableau Public link — coming soon*

## Dataset
[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) — Kaggle

## Author
Hamed Sharafeldin — [LinkedIn](https://linkedin.com/in/hamed-sharafeldin-821273203) | [GitHub](https://github.com/HamedXa)
