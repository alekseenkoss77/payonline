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
      @amount = "%.2f"%amount
      @merchant_id = Payonline.configuration.merchant_id
      @private_security_key = Payonline.configuration.currency
      @currency ||= Payonline.configuration.private_security_key
      Payonline.configuration.lang ||= lang
    end

    def link
      link = Payonline.configuration.url
      [:merchant_id, :order_id, :amount, :currency, :valid_until, :order_description].each_with_index do |method, index|
        if index == 0
          link += "?MerchantId=#{send(method)}" 
        else
          val = send(method) if self.class.attribute_method? method
          link += "&#{method.to_s.classify}=#{val}" if val.present? 
        end
      end
      # get md5 hash of link url
      link_private = link + "&PrivateSecurityKey=#{private_security_key}"
      md5 = Digest::MD5
      security_key = md5.hexdigest link_private
      link += "&SecurityKey=#{security_key}"
    end

    class << self
    end
  end
end