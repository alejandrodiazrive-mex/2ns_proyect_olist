# B2B Marketplace Sales Efficiency (Olist GTM Analytics)

## 🎯 Strategic Context
In a marketplace scaling phase, capital efficiency is the priority. This project migrates a legacy SQL analysis to a **Modern Data Stack (dbt + BigQuery)** to optimize **Seller Acquisition Cost (CAC)** and **Time-to-Revenue**. 

The goal is to identify friction in Sales Velocity and misalignments with our **Ideal Seller Profile (ISP)**, moving from "vanity metrics" (lead volume) to "efficiency metrics" (revenue per rep/day).

---

## 📊 High-Level Revenue Insights

### 1. The "Cash Flow" Bottleneck: Social Media
* **The Problem:** Deals from Social Media take **61 days** to close (2x the average).
* **Financial Impact:** This extends the **Payback Period** and increases CAC due to high SDR effort on low-conversion leads.
* **Recommendation:** Shift these leads to an automated nurturing track (HubSpot/Marketo) to protect expensive human sales capacity.

### 2. The Efficiency Engine: Organic Search
* **The Win:** Highest Efficiency Index (**1.6**) with a fast sales cycle (~30 days).
* **Strategic Action:** Reallocate SDR headcount to prioritize these leads immediately (SLA < 2 hours) to maximize conversion on high-intent traffic.

### 3. Data Integrity & "Unknown" Leakage
* **Audit Finding:** Detected 5% of leads with `NULL` origin during the migration.
* **Engineering Fix:** Implemented a `COALESCE` logic in the Staging Layer to tag these as "Unknown" rather than dropping them, preserving funnel integrity for Marketing attribution audits.

---

## 🏗 Analytics Architecture (Modern Data Stack)

This project moves beyond ad-hoc scripts to a production-grade pipeline using **ELT principles**.

### 🔧 Tech Stack
* **Warehouse:** Google BigQuery (Standard SQL)
* **Transformation:** dbt Core (Jinja Templating, Macros)
* **Orchestration:** Directed Acyclic Graph (DAG) via dbt
* **Data Quality:** Automated schema tests (Unique, Not Null, Relationships)

### 🔗 Data Lineage
![Data Lineage](viz/dbt_lineage.png)
*Automated pipeline flow: From Raw Data (BigQuery Source) → Staging (Cleaning/Casting) → Marts (Business Logic).*

---

## 🛠 Strategic Decision Framework

This data product enables the following GTM decisions:

| Scenario (Data Trigger) | Strategic Action |
| :--- | :--- |
| **Velocity Drop:** `days_to_revenue` > 45 days | Trigger "High-Touch" sales intervention for Mid-Market sellers. |
| **ISP Mismatch:** Low conversion in `Enterprise Seller` segment | Review Marketing messaging alignment with platform benefits. |
| **Quality Alert:** `stg_mql` tests fail | Halt downstream reporting updates to prevent polluted dashboards. |

---

## 📂 Repository Structure

| Directory | Layer Type | Description |
| :--- | :--- | :--- |
| `olist_project/models/staging` | **Bronze/Silver** | Cleans raw data, handles NULLs (`COALESCE`), and standardizes dates. |
| `olist_project/models/marts` | **Gold** | Joins tables to calculate `days_to_revenue` and segments by `icp_segment`. |
| `olist_project/tests` | **QA** | Automated assertions to ensure `mql_id` uniqueness and referential integrity between models. |
| `legacy_analysis/` | **Archive** | Original exploratory SQL scripts (kept for historical context). |

---

## 🧠 Why This Matters (The "Senior" Take)
When scaling a B2B Marketplace, **Speed to Revenue** is the ultimate metric. 
By implementing this architecture, we decouple "Data Cleaning" from "Business Analysis," allowing the Revenue Operations team to trust the numbers and focus on closing deals, while the pipeline ensures data quality automatically.