📊 Olist Marketing Funnel: Conversion Optimization
🎯 Business Case

Olist aims to understand which marketing channels are truly profitable.
This analysis identifies bottlenecks in the sales funnel by comparing lead generation performance against actual deal closures.

🛠️ Tools Used

SQL (PostgreSQL): Data cleaning and relational modeling between MQLs and closed deals.

Google Sheets: Quick validation of data volume and quality.

Power BI: Interactive dashboard for monitoring conversion KPIs.

📈 Key Findings (Data Insights)

Channel Efficiency: Paid Search and Organic Search lead conversion performance, with conversion rates above 11%.

Budget Leakage: Social Media generates the highest volume of leads but shows the weakest performance, with only a 5.5% conversion rate and an average 61-day sales cycle (the slowest across the company).

Sales Velocity: Leads from Direct Traffic close deals 30% faster than those from paid advertising channels.

📁 Repository Structure

olist_analysis.sql: Core query implementing funnel logic and deal closing time calculations.

data/: Original datasets for Marketing Qualified Leads (MQLs) and Closed Deals.

README.md: Project documentation.

💡 Strategic Recommendation

It is recommended to reduce investment in Social Media advertising and reallocate budget toward Paid Search. Additionally, the sales process for social media leads should be audited due to their significantly longer response and closing times.