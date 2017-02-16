require 'pry'
require 'thor'
require_relative "./forecast" 

module GeekWeather
  class CLI < Thor
	option :api_key, required: false, type: :string
	option :country_code, required: true, type: :string
	option :city_name, required: true, type: :string
	desc "forecast DAYS_OFFSET", "Show weather forecast."
	def forecast(days_offset=0)
		ENV['WUNDERGROUND_API_KEY'] = options[:api_key] if options.has_key?("api_key")#"d5343d7f721568c4"
		day_forecast = Forecast.new.call(country_code: options[:country_code], city_name: options[:city_name], forecast_offset: days_offset.to_i)
		print day_forecast.to_s
	end

	option :api_key, required: false, type: :string
	option :country_code, required: true, type: :string
	option :city_name, required: true, type: :string
	desc "forecast_icon DAYS_OFFSET", "Show weather forecast."
	def forecast_icon(days_offset=0)
		ENV['WUNDERGROUND_API_KEY'] = options[:api_key] if options.has_key?("api_key")#"d5343d7f721568c4"
		day_forecast = Forecast.new.call(country_code: options[:country_code], city_name: options[:city_name], forecast_offset: days_offset.to_i)
		print day_forecast.icon_url
	end
  end
end