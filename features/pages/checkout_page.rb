# Name: checkout_page.rb
# Copyright 2015, Opex Software
# Apache License, Version 2.0
# This is a page object file for Magento Checkout page containing web-elements and its interactive methods

require 'page-object'
class CheckoutPage
  include PageObject


  def initialize(page_driver)
    @driver = page_driver
  end

  def fill_and_submit_billing_information(type)
    select_drop_down_by_text("billing:country_id","India")
    if type == "guest"
      @driver.find_element(id: "billing:firstname").send_keys(Faker::Name.first_name)
      @driver.find_element(id: "billing:lastname").send_keys(Faker::Name.last_name)
      @driver.find_element(id: "billing:email").send_keys(Faker::Internet.email)
    end
      @driver.find_element(id: "billing:street1").send_keys("Turning Point II")
      @driver.find_element(id: "billing:city").send_keys("Pune")
      @driver.find_element(id: "billing:postcode").send_keys("411014")
      @driver.find_element(id: "billing:telephone").send_keys("02026632223")
      @driver.find_element(css: "button[title*='Continue']").click
    
  end
  
  def fill_credit_card_information
    select_drop_down_by_text("ccsave_cc_type","Visa")
    @driver.find_element(id: "ccsave_cc_owner").send_keys("Opex Software")
    @driver.find_element(id: "ccsave_cc_number").send_keys("4111111111111111")
    select_random_value_from_dropdown("ccsave_expiration")
    select_drop_down_by_text("ccsave_expiration_yr","2025")
  end

  def add_product_to_cart(type)
    if type == "RUN_INDEX"
      if ENV['RUN_INDEX'].nil?
        index = rand(3)
      else
        index = ENV['RUN_INDEX'].to_i%3
      end
      index = 3 if index == 0
    else
      index = type.to_i
    end
    @driver.find_element(xpath: "//ul[contains(@class,'products-grid')]/li[#{index}]//button").click
  end

end