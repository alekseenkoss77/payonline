module Payonline
  class Gate
    attr_reader :order_id, :amount_id

    def initialize(order_id, amount_id, options={})
      @order_id = order_id
      @amount_id = amount_id
    end

    def link
      link = Payonline.configuration.url
    end

    class << self
    end
  end
end