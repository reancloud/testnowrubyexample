# Name: checkout_steps.rb
# Copyright 2015, Opex Software
# Apache License, Version 2.0
# This is a cucumber step-definitions file containing implementations of GWT's feature steps


When /^I do a global search using "([^"]*)" keyword$/ do |keyword|
  checkout = CheckoutPage.new(@driver)
  @driver.find_element(id: "search").send_keys(keyword)
  @driver.find_element(css: "button[title*='Search']").click
  #checkout.search_box.send_keys(:return)
end

Then /^I should see products$/ do
  checkout = CheckoutPage.new(@driver)
  Selenium::WebDriver::Wait.new(timeout: 30).until {@driver.find_element(css: "div.category-products").displayed?}
  @driver.find_element(css: "div.category-products").displayed?.should == true
end

Then /^I add to cart the product (?:based on|number) (RUN_INDEX|\d+)$/ do |index|
  checkout = CheckoutPage.new(@driver)
  checkout.add_product_to_cart(index)
end

Then /^I proceed to checkout$/ do
  checkout = CheckoutPage.new(@driver)
  @driver.find_element(css: "button[title*='Proceed to Checkout']").click
end

When /^I select checkout method as Guest$/ do
  checkout = CheckoutPage.new(@driver)
  @driver.find_element(id: "login:guest").click
  @driver.find_element(id: "onepage-guest-register-button").click
end

When /^I fill all mandatory details in Billing Information as (member|guest)$/ do |type|
  checkout = CheckoutPage.new(@driver)
  checkout.fill_and_submit_billing_information(type)
end

When /^I continue with shipping method$/ do
  checkout = CheckoutPage.new(@driver)
  Selenium::WebDriver::Wait.new(timeout: 30).until {@driver.find_element(css: "#shipping-method-buttons-container button").displayed?}
  @driver.find_element(css: "#shipping-method-buttons-container button").click
end

When /^I select payment method as "(check|credit_card|cash_on_delivery)"$/ do |payment_method|
  checkout = CheckoutPage.new(@driver)
  case payment_method
    when "check"
      @driver.find_element(id: "p_method_checkmo").click
    when "cash_on_delivery"
      @driver.find_element(id: "p_method_cashondelivery").click
    when "credit_card"
      @driver.find_element(id: "p_method_ccsave").click
      sleep(1)
      checkout.fill_credit_card_information
  end 
  @driver.find_element(css: "#payment-buttons-container button").click
end

Then /^I place the order$/ do
  checkout = CheckoutPage.new(@driver)
  @driver.find_element(css: "button.btn-checkout").click
  Selenium::WebDriver::Wait.new(timeout: 60).until {@driver.find_element(css: "button.btn-checkout").displayed?}
  @driver.find_element(css: "button.btn-checkout").click
end 

Then /^I should see order confirmation message$/ do
  checkout = CheckoutPage.new(@driver)
  Selenium::WebDriver::Wait.new(timeout: 60).until {driver.current_url.include?('success')}
  driver.find_element(tag_name: "h1").text.should == "YOUR ORDER HAS BEEN RECEIVED."
  driver.find_element(tag_name: "h2").text.should == "THANK YOU FOR YOUR PURCHASE!"
end