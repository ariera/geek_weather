require 'faraday'
require 'json'
require 'date'

module GeekWeather
  class Forecast
  	def call(country_code:, city_name:, forecast_offset: 0)
  		api_key = ENV['WUNDERGROUND_API_KEY']
  		raise "missing API Key" if api_key.nil?
  		api_url = "http://api.wunderground.com/api/#{api_key}/forecast/q/#{country_code}/#{city_name}.json"
  		response = Faraday.get(api_url)
		json = JSON.parse(response.body)
		days = json["forecast"]["simpleforecast"]["forecastday"].map do	|day_json|
			Day.new(day_json)
		end
		forecast_date = ::Date.today + forecast_offset
		day = days.find{ |day| day.date == forecast_date }
  	end
  end
end
require_relative "./forecast/day"