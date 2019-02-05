# Name: dashboard_page.rb
# Copyright 2015, Opex Software
# Apache License, Version 2.0
# This is a page object file for Magento Dashboard page containing web-elements and its interactive methods
require 'page-object'

class DashboardPage
  include PageObject
  
  def initialize(page_driver)
    @driver = page_driver
  end
end