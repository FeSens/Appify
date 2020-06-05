class MandatoryWebhooksController < ActionController::Base
  include ShopifyApp::WebhookVerification

  def shop_redact
    Shop.find_by(shopify_domain: params[:shop_domain]).destroy
    head :no_content
  end

  def customer_redact
    head :no_content
  end

  def customer_data_request
    head :no_content
  end

  private

  def webhook_params
    params.except(:controller, :action, :type)
  end
end
