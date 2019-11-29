class CardService
  attr_accessor :client

  def initialize(client)
    @client = client
  end

  def delete(card_token)
    Stripe::Customer.delete_source(
      client.customer_id,
      card_token
    )
  rescue Stripe::CardError => e
    puts "*** Stripe Delete error: #{e}"
    false
  rescue StandardError => e
    puts "*** Stripe Delete error: #{e}"
    false
  end

  def list
    Stripe::Customer.list_sources(
      client.customer_id,
      limit: 20,
      object: 'card'
    )
  rescue Stripe::CardError => e
    puts "*** Stripe List error: #{e}"
    false
  rescue StandardError => e
    puts "*** Stripe List error: #{e}"
    false
  end

  def show(card_token)
    Stripe::Customer.retrieve_source(
      client.customer_id,
      card_token
    )
  rescue Stripe::CardError => e
    puts "*** Stripe List error: #{e}"
    false
  rescue StandardError => e
    puts "*** Stripe List error: #{e}"
    false
  end

  def create(card_token)
    Stripe::Customer.create_source(
      client.customer_id,
      source: card_token
    )
  rescue Stripe::CardError => e
    puts "*** Card Creation error: #{e}"
    e
  rescue StandardError => e
    puts "*** Card Creation error: #{e}"
    e
  end
end
