require 'pry'

module GeekWeather
  class Forecast::Day
	# {
	#   "date": {
	#     "epoch": "1487268000",
	#     "pretty": "7:00 PM CET on February 16, 2017",
	#     "day": 16,
	#     "month": 2,
	#     "year": 2017,
	#     "yday": 46,
	#     "hour": 19,
	#     "min": "00",
	#     "sec": 0,
	#     "isdst": "0",
	#     "monthname": "February",
	#     "monthname_short": "Feb",
	#     "weekday_short": "Thu",
	#     "weekday": "Thursday",
	#     "ampm": "PM",
	#     "tz_short": "CET",
	#     "tz_long": "Europe/Berlin"
	#   },
	#   "period": 1,
	#   "high": {
	#     "fahrenheit": "59",
	#     "celsius": "15"
	#   },
	#   "low": {
	#     "fahrenheit": "39",
	#     "celsius": "4"
	#   },
	#   "conditions": "Rain",
	#   "icon": "rain",
	#   "icon_url": "http://icons.wxug.com/i/c/k/rain.gif",
	#   "skyicon": "",
	#   "pop": 90,
	#   "qpf_allday": {
	#     "in": 0.09,
	#     "mm": 2
	#   },
	#   "qpf_day": {
	#     "in": null,
	#     "mm": null
	#   },
	#   "qpf_night": {
	#     "in": 0.13,
	#     "mm": 3
	#   },
	#   "snow_allday": {
	#     "in": 0.0,
	#     "cm": 0.0
	#   },
	#   "snow_day": {
	#     "in": null,
	#     "cm": null
	#   },
	#   "snow_night": {
	#     "in": 0.0,
	#     "cm": 0.0
	#   },
	#   "maxwind": {
	#     "mph": 9,
	#     "kph": 15,
	#     "dir": "NNW",
	#     "degrees": 0
	#   },
	#   "avewind": {
	#     "mph": 3,
	#     "kph": 5,
	#     "dir": "South",
	#     "degrees": 0
	#   },
	#   "avehumidity": 94,
	#   "maxhumidity": 0,
	#   "minhumidity": 0
	# },
  	def initialize(json)
  		@json = json
  	end

  	def date
  		# binding.pry
  		@date ||= begin
  			day = @json["date"]["day"]
  			month = @json["date"]["month"]
  			year = @json["date"]["year"]
  			Date.parse("#{day}/#{month}/#{year}")
  		end
  	end

  	def high(scale = "celsius")
  		@json["high"][scale]
  	end

  	def low(scale = "celsius")
  		@json["low"][scale]
  	end

  	def maxwind(scale = "kph")
  		@json["maxwind"][scale]
  	end

  	# docs: https://www.wunderground.com/weather/api/d/docs?d=resources/icon-sets
  	def icon_url
  		icon = @json["icon"]
  		icon_set = "i"
  		"https://icons.wxug.com/i/c/#{icon_set}/#{icon}.gif"
  	end

  	def to_s
  		<<~EOS
  			#{date}
  			max: #{high} C
  			min: #{low} C
  			wind: #{maxwind} km/h
  		EOS
  	end
  end
end
