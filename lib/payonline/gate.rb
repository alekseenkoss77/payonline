require 'curb'
require 'net/http'

module Payonline
  class Gate
    # TODO: make strong validations
    include ActiveModel::Model


    attr_accessor :order_id, :amount, :lang, :order_description,
                  :valid_until, :return_url, :fail_url, :merchant_id,
                  :private_security_key, :currency, :transaction_id

    #####
    #
    # Payonline::Gate - special payment gateway for payonline.ru service
    # for using this, in your controller you should create new payment object
    # Example for usage:
    # 
    # => in contollers/examples_controller.rb
    # def payment
    #   @order = Order.find params[:id]
    #
    #   @payment = Payonline::Gate.new(
    #     :order_id => @order.id,
    #     :amount => @order.amount,
    #     :currency => "EUR",
    #     :order_description => "Thid is t-short" 
    #   )
    # end
    #
    # => in views/examples/payment.html.erb
    #  <div class="payment">
    #     <a href="<% @payment.link %>"> Payment link </a>
    #  </div>
    #
    # => @payment.currency  may be "RUB", "EUR", "USD"
    # => @payment.amount    decimal value (e.g. 15000)
    # => @payment.order_description   description of order shuld be 100 chars max length
    #
    # TODO: need more documentation =)
    #
    #
    #
    ######


    def initialize(attributes={})
      attributes.each do |key,value|
        send("#{key}=",value)
      end
      @amount = "%.2f"%amount
      @merchant_id = Payonline.configuration.merchant_id
      @private_security_key = Payonline.configuration.private_security_key
      @currency ||= Payonline.configuration.currency
      Payonline.configuration.lang ||= lang
    end

    def link
      link = ""
      [:merchant_id, :order_id, :amount, :currency, :valid_until, :order_description].each_with_index do |method, index|
        if index == 0
          link += "MerchantId=#{send(method)}" 
        else
          val = send(method) if self.class.attribute_method? method
          link += "&#{method.to_s.classify}=#{val}" if val.present? 
        end
      end

      link_private = link + "&PrivateSecurityKey=#{private_security_key}"
      link = Payonline.configuration.url + "?" + link + "&SecurityKey=#{self.security_key(link_private)}"
    end

    def security_key(link)
      p link
      md5 = Digest::MD5
      security_key = md5.hexdigest link
    end

    def check_status
      url_security_key = self.security_key("MerchantId=#{self.merchant_id}&OrderId=#{self.order_id}&PrivateSecurityKey=#{self.private_security_key}")
      params = {
          'MerchantId'  => self.merchant_id,
          'OrderId'     => self.order_id,
          'SecurityKey' => url_security_key,
          'ContentType' => 'xml' 
        }
      # http = Curl.get('https://secure.payonlinesystem.com/payment/search', params)
      # http.body

      uri = URI 'https://secure.payonlinesystem.com/payment/search'
      uri.query = URI.encode_www_form params
      puts uri
      res = Net::HTTP.get_response(uri)
      puts res.body
    end

    class << self
    end
  end
end