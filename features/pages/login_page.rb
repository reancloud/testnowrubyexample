# Name: login_page.rb
# Copyright 2015, Opex Software
# Apache License, Version 2.0
# This is a page object file for Magento Login page containing web-elements and its interactive methods

require 'page-object'
class LoginPage
  include PageObject

  def initialize(page_driver)
    @driver=page_driver
  end

  def go_to_homepage(portal)
    if portal == "customer"
      driver.get(ENV['TEST_URL'])
      if ENV['BROWSER'] == 'IE'
        begin
          driver.get("javascript:document.getElementById('overridelink').click();")
        rescue
          p "Some Issue related to security certificate..."
        end
      end
      #raise "Not on Magento Homepage" unless is_homepage?
    elsif portal == "admin"
      driver.get("https://104.131.191.140/index.php/admin")
      if ENV['BROWSER'] == 'IE'
        begin
          driver.get("javascript:document.getElementById('overridelink').click();")
        rescue
          p "Some Issue related to security certificate..."
        end
      end
      raise "Not on Magento Admin Page" unless is_admin_page?
    end
  end

  def is_homepage?
    magento_logo.displayed?
  end

  def is_admin_page?
    true
  end

  def login(email,pword)
    @driver.find_element(id: "email").send_keys(email)
    @driver.find_element(id: "pass").send_keys(pword)
    @driver.find_element(id: "send2").click
  end

  def logout
    @driver.find_element(css: "a.skip-account").click
    @driver.find_element(css: "a[title*='Log Out']").click
  end


  def verify_mandatory_fields_message(where)
    message = "This is a required field."
    if where == "login"
      @driver.find_element(id: 'advice-required-entry-email').text.should == message
      @driver.find_element(id: 'advice-required-entry-pass').text.should == message
    elsif where == "registration"
      @driver.find_element(id: 'advice-required-entry-firstname').text.should == message
      @driver.find_element(id: 'advice-required-entry-lastname').text.should == message
      @driver.find_element(id: 'advice-required-entry-email_address').text.should == message
      @driver.find_element(id: 'advice-required-entry-password').text.should == message
      @driver.find_element(id: 'advice-required-entry-confirmation').text.should == message
    end
  end

  def register(user_type)
    if user_type == "new"
      email = Faker::Internet.email
      @driver.find_element(id: "firstname").send_keys(Faker::Name.first_name)
      @driver.find_element(id: "lastname").send_keys(Faker::Name.last_name)
      @driver.find_element(id: "email_address").send_keys(email)
      @driver.find_element(id: "password").send_keys("password123")
      @driver.find_element(id: "confirmation").send_keys("password123")
      return email
    elsif user_type == "existing"
      @driver.find_element(id: "firstname").send_keys(Faker::Name.first_name)
      @driver.find_element(id: "lastname").send_keys(Faker::Name.last_name)
      @driver.find_element(id: "email_address").send_keys("admin@mailinator.com")
      @driver.find_element(id: "password").send_keys("password123")
      @driver.find_element(id: "confirmation").send_keys("password123")
    end
  end
end
