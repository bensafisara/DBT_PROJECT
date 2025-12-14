🚲 LocalBike Analytics Project
Welcome to the LocalBike Analytics project! This dbt (data build tool) project transforms raw transactional data into actionable business insights for the LocalBike retail chain.

🏗️ Project Overview
This project implements a three-layer analytics architecture to support data-driven decision making across finance, operations, and marketing departments.

Architecture
text
Raw Sources → Staging (Cleaning) → Intermediate (Enrichment) → Marts (Analysis)
      ↓              ↓                     ↓                      ↓
  Databases      Data Quality       Business Logic         Departmental Dashboards
📊 Data Models
1. Staging Layer (models/staging/localbike/)
Purpose: Raw data ingestion and basic data quality validation

Tables: stg_localbike__customers, stg_localbike__orders, stg_localbike__products, etc.

Features:

59 automated data quality tests

Referential integrity checks

Basic data cleaning (trim, case formatting)

2. Intermediate Layer (models/intermediate/)
Purpose: Centralized business logic and calculations

Key Models:

int_localbike__orders_enriched: Financial metrics at order item level

int_localbike__customer_behavior: Customer RFM segmentation and profiling

int_localbike__staff_enriched: Staff performance aggregations

3. Mart Layer (models/marts/)
Purpose: Department-specific analytics ready for consumption

Analytical Tables:

Finance: mart_finance__monthly_revenue - Monthly performance by store/category/brand

Operations: mart_operations__staff_performance - Staff rankings and KPIs

Marketing: mart_marketing__customer_360 - Customer profiles with marketing recommendations

🚀 Getting Started
Prerequisites
dbt installed and configured

Access to the data warehouse (BigQuery)

Project credentials configured in profiles.yml

First-Time Setup
bash
# Install dependencies
dbt deps

# Build the entire project
dbt build

# Run tests
dbt test
Common Commands
bash
# Build specific layers
dbt build --select stg_localbike__*          # Build staging models
dbt build --select int_localbike__*          # Build intermediate models
dbt build --select mart_*                    # Build mart models

# Run tests
dbt test --select stg_localbike__*           # Test staging models
dbt test                                    # Test all models

# Generate documentation
dbt docs generate
dbt docs serve
📈 Business Insights & Use Cases
For Finance Team
Track monthly revenue trends by store and category

Analyze discount impact on profitability

Monitor average order value over time

For Operations Management
Compare staff performance across stores

Identify training opportunities based on performance gaps

Track delivery efficiency metrics

For Marketing Department
Segment customers by value (VIP, Premium, Regular, Occasional)

Automate campaign recommendations based on customer behavior

Identify at-risk customers for retention campaigns

🔧 Key Features
Data Quality Framework
59 automated tests ensuring data integrity

Referential integrity checks across all relationships

Business rule validation (discount ranges, status codes, etc.)

Performance Optimizations
Incremental models where applicable

Pre-aggregated metrics for fast dashboard queries

Efficient joins with proper indexing considerations

Documentation & Governance
Complete data dictionary in schema.yml files

Column-level descriptions with business context

Model lineage automatically tracked by dbt

📁 Project Structure
text
my_first_dbt_project/
├── models/
│   ├── staging/
│   │   └── localbike/
│   │       ├── schema.yml          # Staging model documentation
│   │       └── stg_localbike__*.sql # Raw data models
│   ├── intermediate/
│   │   ├── schema.yml              # Intermediate model documentation
│   │   └── int_localbike__*.sql    # Business logic models
│   └── marts/
│       ├── schema.yml              # Mart model documentation
│       └── [finance|operations|marketing]/
│           └── mart_*.sql          # Departmental analytics
├── tests/
│   ├── generic/                    # Custom generic tests
│   └── singular/                   # One-off data tests
├── macros/                         # Reusable SQL code
├── dbt_project.yml                 # Project configuration
└── packages.yml                    # dbt package dependencies