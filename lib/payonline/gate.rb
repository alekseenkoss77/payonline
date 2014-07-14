module Payonline
  class Gate
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :order_id, :amount, :lang, :order_description,
                  :valid_until, :return_url, :fail_url, :merchant_id

    def initialize(attributes={})
      attributes.each do |key,value|
        send("#{key}",value)
      end
      merchant_id = Payonline.configuration.merchant_id
      Payonline.configuration.lang ||= lang
    end

    def link
      link = Payonline.configuration.url
      
    end

    class << self
    end
  end
end