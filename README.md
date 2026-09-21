# Smart Logistics & Supply Chain Performance Analysis

---

## 📌 Project Overview
This project delivers an end-to-end analytical pipeline evaluating **1,000 logistics tracking records** from a raw Kaggle dataset. The workflow encompasses data cleaning and feature engineering in Python (Pandas), metric extraction and aggregation using MySQL, and interactive visualization via a Power BI Dashboard.

The core objective is to identify key operational trends in asset utilization, inventory management, logistics delay rates, and temporal bottleneck patterns.

---

## 📊 Executive Summary & Key Metrics

* **Total Logistics Records Analyzed:** 1,000[cite: 1]
* **Total Unique Assets Tracked:** 10 Trucks[cite: 1]
* **On-Time Deliveries:** 434 records (**56.60%** Logistics Delay Rate)[cite: 1]
* **Average Asset Utilization:** 79.60%[cite: 1]
* **Average Inventory Level:** 297.92 units[cite: 1]
* **Average Demand Forecast:** 199.28 units[cite: 1]

---

## 🛠️ Data Pipeline & Workflow Architecture

The project execution followed a 4-step pipeline:
[ Kaggle Raw Dataset ] ──> [ Python / Pandas Cleaning ] ──> [ MySQL Querying ] ──> [ Power BI Dashboard ]

1. **Data Ingestion:** Loaded `smart_logistics_dataset.csv` containing 1,000 records and 16 initial columns[cite: 1].
2. **Data Preprocessing & Cleaning (Pandas / Jupyter Notebook):**
   * Imputed missing values in `logistics_delay_reason` (263 missing entries) using mode imputation[cite: 1].
   * Standardized all header names to `lower_snake_case`[cite: 1].
   * Created **Asset Utilization Categories**:
     * `Low Utilization` (60–70%)[cite: 1]
     * `Medium Utilization` (71–85%)[cite: 1]
     * `High Utilization` (86–100%)[cite: 1]
   * Extracted temporal attributes from `timestamp`: `month_name`, `month`, `week`, `day`, `day_of_week`, `hour`, and `date`[cite: 1].
   * Categorized **Purchase Frequency**: Low, Medium, High[cite: 1].
3. **Database Integration & SQL Queries:** Stored clean structured data in MySQL to compute asset rankings and stockout risks[cite: 1].
4. **Data Visualization:** Built an interactive **Power BI Dashboard** summarizing fleet performance, delay drivers, and inventory metrics[cite: 1].

---

## 🔎 SQL Analytical Insights & Query Results

### 1. Fleet Asset Utilization & Performance Ranking

| Asset ID | Avg Asset Utilization (%) | Total Inventory Level | Delay Rate (%) | Performance Rank |
| :--- | :---: | :---: | :---: | :---: |
| **Truck_7** | 80.67% | 29,602 | 58.82% | 1 |
| **Truck_1** | 80.52% | 25,791 | 51.69% | 2 |
| **Truck_8** | 80.24% | 35,192 | 56.88% | 3 |
| **Truck_2** | 80.16% | 30,912 | 53.33% | 4 |
| **Truck_3** | 80.10% | 26,101 | 62.37% | 5 |
| **Truck_9** | 79.94% | 26,791 | 56.38% | 6 |
| **Truck_10** | 79.58% | 32,876 | 64.76% | 7 |
| **Truck_4** | 79.06% | 31,266 | 58.88% | 8 |
| **Truck_6** | 79.03% | 30,618 | 52.43% | 9 |
| **Truck_5** | 76.60% | 28,766 | 49.46% | 10 |

---

### 2. Inventory Distribution & Stockout Risk Analysis

| Inventory Level Category | Inventory Range | Record Share (%) | Delay Rate (%) |
| :--- | :---: | :---: | :---: |
| **High** | 300+ units | 49.50% | 55.76% |
| **Medium** | 151–300 units | 38.50% | 58.44% |
| **Low** | 1–150 units | 12.00% | 54.17% |

* **Stockout Risk:** Evaluated critical records where current inventory levels fell below the forecasted demand[cite: 1].

---

### 3. Temporal & Operational Bottlenecks

* 📅 **Peak Delay Month:** **July** recorded the highest delay occurrences with **54 total delays**[cite: 1].
* 📆 **Peak Delay Day:** **Tuesday** registered the highest average delay rate at **65.00%**[cite: 1].
* ⏰ **Peak Operational Hours:** Delays peaked during morning and midday time blocks:
  * **12:00 PM:** 33 delays[cite: 1]
  * **08:00 AM:** 32 delays[cite: 1]
  * **10:00 AM:** 31 delays[cite: 1]

---

## 💡 Key Takeaways & Actionable Recommendations

1. 🔧 **Service & Reroute High-Stress Trucks:** `Truck_3`, `Truck_7`, and `Truck_8` operate at **>80% utilization** while suffering **>56% delay rates**[cite: 1]. Schedule these vehicles for routine maintenance and reassign them to lighter routes[cite: 1].
2. 📦 **Implement Dynamic Inventory Buffers:** Automatically scale up reorder thresholds whenever forecasted demand exceeds available inventory levels to eliminate stockout risks[cite: 1].
3. 🛑 **Avoid Rush-Hour Dispatches:** Restrict non-urgent shipments during high-delay windows (**8:00 AM – 12:00 PM**) and on **Tuesdays**[cite: 1]. Shift delivery slots to late afternoons or alternative days[cite: 1].

---

## 📁 Repository Structure

```text
.
├── data/
│   ├── raw/                      # Original Kaggle dataset
│   └── processed/                # Cleaned CSV data
├── notebooks/
│   └── data_cleaning.ipynb       # Pandas preprocessing notebook
├── sql/
│   └── queries.sql               # MySQL queries & aggregated views
├── dashboard/
│   └── logistics_dashboard.pbix  # Power BI Dashboard file
└── README.md                     # Project documentation

<FollowUp label="Would you like me to generate the SQL queries corresponding to the analytics section?" query="Can you generate the SQL queries used to compute the asset performance metrics, inventory distribution, and temporal delay bottlenecks from this project?"/>
