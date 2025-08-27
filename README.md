# README

Ruby Checkout System - CLI APP
This is a simple ruby checkout system that allows you to scan products, apply different PRICING RULES, and calculate total directly in the terminal.

📖 Features

🏷 Dynamic Pricing Rules: Easily add or update rules like Buy One Get One Free or bulk discounts.

🛍 Interactive CLI: Scan items, view the total, and remove items if needed.

🧩 Modular Design: Easy to extend for new pricing rules or products.

⚙️ Installation

1. Clone the repository

   git clone <https://github.com/Zainab-5/amenitiz-be-technical-challenge.git>

   cd amenitiz-be-technical-challenge
   
2. Install dependencies

   bundle install

3. Run CLI

   chmod +x bin/cli

   bin/cli

🧪 Running Tests

     bundle exec rspec

🛠 Adding Pricing Rules

    Open bulk_price_rule.rb or buy_one_get_one_rule.rb in app/services/ and define your new rules.
    The Checkout class will automatically apply them when calculating totals.
