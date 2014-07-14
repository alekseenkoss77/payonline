module Payonline
  class Configuration
    attr_accessor :merchant_id, :currency,
                  :valid_until, :order_description

    def initialize
      @merchant_id = 12345
      # 'RUB', 'EUR', 'USD'
      @currency = 'RUB'
      # limit of description - 100 chars
      @order_description = 'None'
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
