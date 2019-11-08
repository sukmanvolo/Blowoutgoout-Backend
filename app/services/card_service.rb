class CardService
  attr_accessor :client

  def initialize(client)
    @client = client
  end

  def delete(card_token)
    begin
      Stripe::Customer.delete_source(
        client.customer_id,
        card_token
      )
    rescue Stripe::CardError => e
      puts "*** StripeCharge: #{e}"
      false
    rescue => e
      puts "*** StripeCharge: #{e}"
      false
    end
  end

  def list
    begin
      Stripe::Customer.list_sources(
        client.customer_id,
        {
          limit: 20,
          object: 'card',
        }
      )
    rescue Stripe::CardError => e
      puts "*** StripeCharge: #{e}"
      false
    rescue => e
      puts "*** StripeCharge: #{e}"
      false
    end
  end
end