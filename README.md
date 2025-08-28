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

Frontend preview

- There is a very simple html page added to preview the selected products, with total price, after applying pricing rules according to each product.
- This is a very basic level page, not a professional one, just added to show the price calculations


<img width="1130" height="720" alt="Screenshot 2025-08-28 at 2 54 38 PM" src="https://github.com/user-attachments/assets/50378876-a07a-4738-8020-c03020a861f7" />
