module Payonline
  class Gate

    def initialize(order_id, amount_id)
      @order_id = order_id
      @amount_id = amount_id
    end

    class << self
    end
  end
end