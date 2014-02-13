require 'rubygems'
require 'selenium-webdriver'
require 'CSV'

driver = Selenium::WebDriver.for :firefox
upctoasin = "http://upctoasin.com/"
amazon = "http://www.amazon.com/exec/obidos/ASIN/"

CSV.foreach ("upcs.csv") do |upc|
	driver.get "#{upctoasin}#{upc[0]}"
	element = driver.find_element :tag_name => "body"
	asin = element.text
	if asin != 'UPCNOTFOUND'
		begin
			driver.get "#{amazon}#{asin}"
			element = driver.find_element :css => ".selection"
			puts element[0].text
		rescue
			element = driver.find_element :id => "title"
			titles = element.text.split("-")
			puts titles.last
		end
	end
end
driver.quit