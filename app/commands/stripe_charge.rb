class StripeCharge
  prepend SimpleCommand

  attr_accessor :customer_id, :amount

  def initialize(customer_id, amount)
    @customer_id = customer_id
    @amount = (amount * 100).round
  end

  def call
    begin
      Stripe::Charge.create(amount: amount,
                            currency: "usd",
                            customer: customer_id)
    rescue Stripe::CardError => e
      errors.add('StripeCharge', e)
      false
    rescue => e
      errors.add('StripeCharge', e)
      false
    end
  end
end