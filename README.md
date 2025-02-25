# sql-basics
This training project was completed in an interactive simulator on Yandex Practicum. It includes 23 tasks on writing PostgreSQL queries for a database of venture funds and startup investments. The database is based on the Startup Investments dataset from Kaggle (https://www.kaggle.com/justinas/startup-investments).

Database ER diagram:
![Image (1)](https://github.com/user-attachments/assets/751792db-9aff-4299-8e14-248a6ceee6de)

**Table Structure Translation:**

**acquisition**
Stores information about company acquisitions.

- **Primary Key**: `id` – Unique acquisition identifier.
- **Foreign Key**: `acquiring_company_id` – References company table, indicating the acquiring company.
- **Foreign Key**: `acquired_company_id` – References company table, indicating the acquired company.
- `term_code` – Payment method:
- `cash` – Cash payment.
- `stock` – Payment with company shares.
- `cash_and_stock` – Mixed payment (cash + shares).
- `price_amount` – Acquisition price (USD).
- `acquired_at` – Acquisition date.
- `created_at`, `updated_at` – Record creation and update timestamps.

**company**
Contains information about startup companies.

- **Primary Key**: `id` – Unique company identifier.
- `name` – Company name.
- `category_code` – Industry category (e.g., `news`, `social`).
- `status` – Company status:
-`acquired` – Acquired.
-`operating` – Active.
-`ipo` – Public (IPO).
-`closed` – No longer exists.
- `founded_at`, `closed_at` – Founding and closure dates.
- `domain` – Company website domain.
- `network_username` – Corporate network profile.
- `country_code` – Country code (e.g., USA, GBR).
- `investment_rounds` – Number of rounds as an investor.
- `funding_rounds` – Number of rounds raising investment.
- `funding_total` – Total funding raised (USD).
- `milestones` – Key milestones.
- `created_at`, `updated_at` – Record timestamps.

**education**
Stores employee education details.

- **Primary Key**: id – Unique education record identifier.
- **Foreign Key**: person_id – References people table.
- `degree_type` – Degree type (e.g., BA, MS).
- `institution` – University name.
- `graduated_at` – Graduation date.
- `created_at`, `updated_at` – Record timestamps.

**fund**
Contains information about venture funds.

- **Primary Key**: `id` – Unique fund identifier.
- `name` – Fund name.
- `founded_at` – Fund founding date.
- `domain` – Fund website domain.
- `network_username` – Corporate network profile.
- `country_code` – Country code.
- `investment_rounds` – Investment rounds participated in.
- `invested_companies` – Number of invested companies.
- `milestones` – Key milestones.
- `created_at`, `updated_at` – Record timestamps.

**funding_round**
Stores information about investment rounds.

- **Primary Key**: `id` – Unique round identifier.
- **Foreign Key**: `company_id` – References company table.
- `funded_at` – Round date.
- `funding_round_type` – Round type (e.g., venture, angel, series_a).
- `raised_amount` – Investment amount (USD).
- `pre_money_valuation` – Pre-investment company valuation (USD).
- `participants` – Number of investors.
- `is_first_round`, `is_last_round` – First/last round indicators.
- `created_at`, `updated_at` – Record timestamps.

**investment**
Stores venture fund investments in startups.

- **Primary Key**: `id` – Unique investment identifier.
- **Foreign Keys**:
- `funding_round_id` – References funding_round table.
- `company_id` – References company table.
- `fund_id` – References fund table.
- `created_at`, `updated_at` – Record timestamps.

**people**
Contains startup employees' information.

- **Primary Key**: `id` – Unique employee identifier.
- `first_name`, `last_name` – Employee name.
- **Foreign Key**: `company_id` – References company table.
- `network_username` – Corporate network profile.
- `created_at`, `updated_at` – Record timestamps.
