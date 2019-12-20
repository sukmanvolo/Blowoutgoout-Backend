class StripeCharge
  prepend SimpleCommand

  attr_accessor :customer_id, :amount, :card_token, :description, :receipt_email

  def initialize(customer_id, amount, card_token, description, receipt_email)
    @customer_id = customer_id
    @amount = (amount * 100).round
    @card_token = card_token
    @description = description
    @receipt_email = receipt_email
  end

  def call
    Stripe::Charge.create(amount: amount,
                          currency: 'usd',
                          customer: customer_id,
                          description: description,
                          receipt_email: receipt_email,
                          source: card_token,
                          statement_descriptor: 'Blowout Go Out')
  rescue Stripe::CardError => e
    errors.add('StripeCharge', e)
    false
  rescue StandardError => e
    errors.add('StripeCharge', e)
    false
  end
end
