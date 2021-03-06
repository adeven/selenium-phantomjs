require 'selenium-webdriver'

require 'selenium/phantomjs/version'
require 'selenium/phantomjs/instance'
require 'selenium/phantomjs/web_driver'

Selenium::Phantomjs::WebDriver.new('tmp/pids/phantomjs.pid').run

module Selenium
  module Phantomjs
    extend self

    def register_driver
      begin
        require 'selenium/webdriver'
      rescue LoadError
      end

      if defined? Selenium::WebDriver
        Capybara.register_driver :selenium_phantomjs do |app|
          Capybara::Selenium::Driver.new(app, options)
        end
      end
    end

    def options
      {
        browser: :remote, 
        url:     "#{WebDriver::SELENIUM_GRID_URL}/wd/hub", 
        desired_capabilities: {
          browserName: :phantomjs
        }
      }
    end
  end
end

Selenium::Phantomjs.register_driver
