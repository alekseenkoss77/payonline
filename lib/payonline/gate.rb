module Payonline
  class Gate
    include ActiveModel::Model

    attr_accessor :order_id, :amount, :lang, :order_description,
                  :valid_until, :return_url, :fail_url, :merchant_id,
                  :private_security_key

    def initialize(attributes={})
      attributes.each do |key,value|
        send("#{key}=",value)
      end
      amount = "%.2f" % amount || "0.00" 
      merchant_id = Payonline.configuration.merchant_id
      private_security_key = Payonline.configuration.private_security_key
      Payonline.configuration.lang ||= lang
    end

    def link
      link = Payonline.configuration.url
      [:merchant_id, :order_id, :amount, :currency, :valid_until, :order_description, :private_security_key].each_with_index do |method, index|
        if index == 0
          link += "?MerchantId=#{send(method)}" 
        else
          link += "&#{method.to_s.classify}=#{send(method)}" if self.class.attribute_method? method
        end
      end
      link
    end

    class << self
    end
  end
end