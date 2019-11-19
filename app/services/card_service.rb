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
      puts "*** Stripe Delete error: #{e}"
      false
    rescue => e
      puts "*** Stripe Delete error: #{e}"
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
      puts "*** Stripe List error: #{e}"
      false
    rescue => e
      puts "*** Stripe List error: #{e}"
      false
    end
  end

  def create(card_token)
    begin
      card = Stripe::Customer.create_source(
        client.customer_id,
        {
          source: card_token,
        }
      )
    rescue Stripe::CardError => e
      puts "*** Card Creation error: #{e}"
      false
    rescue => e
      puts "*** Card Creation error: #{e}"
      false
    end
  end
end