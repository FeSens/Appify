class IdentifyCart
  attr_reader :data
  
  def initialize(webhook_data)
    @data = webhook_data
  end

  def call
    return by_cart_token if data[:cart_token].present?
    
    return by_line_items if data[:line_items].present?
    
    return false 
  end

  def by_cart_token
    cart = Cart.find_by(token: data[:cart_token])
    cart.update(abandoned: false) if cart
    return cart.present?
  end

  def by_line_items
    s = ""
    data[:line_items].each do |line_item|
      s += "#{line_item[:id]}#{line_item[:product_id]}#{line_item[:variant_id]}#{line_item[:sku]}#{line_item[:quantity]}"
    end
    hash = Digest::SHA256.hexdigest s
    cart = Cart.where(hash: hash).update_all(abandoned: false)

    return cart > 0
  end
end