desc "Sync Shops with active payment"
task shopify_sync_task: :environment do
  Shop.all.each do |current_shop|
    next if current_shop.type == "Shop::Devise"
    current_shop.with_shopify_session do
      @plan = ShopifyAPI::RecurringApplicationCharge.all
      @plan = active?(@plan)
    rescue StandardError => e
      @plan = false
    end
  
    current_shop.update(active: @plan)
  end
  
  def active?(p)
    p.map { |pp| pp.status == "active" }.any?
  end
end