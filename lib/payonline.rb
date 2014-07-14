module Payonline
  class Configuration
    attr_accessor :merchant_id, :currency, :url, :lang

    def initialize
      merchant_id = 12345
      currency = 'RUB' # 'RUB', 'EUR', 'USD'
      lang = 'ru'
      url = "https://secure.payonlinesystem.com/#{lang}/payment/"
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
