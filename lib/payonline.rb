require 'payonline/gate'

module Payonline
  class Configuration
    attr_accessor :merchant_id, :currency, :url, :lang, :private_security_key

    def initialize
      @merchant_id = 12345
      @currency = 'RUB' # 'RUB', 'EUR', 'USD'
      @lang = 'ru'
      @url = "https://secure.payonlinesystem.com/#{lang}/payment"
      @private_security_key = 'fuuu123'
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||=  Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end
end 
