class Api::V1::Magazord::PedidoController < ActionController::API
  def create
    dynamodb = Aws::DynamoDB::Client.new(
      region: 'us-east-1',
      access_key_id:  Rails.application.credentials.dig(:amazon, :api_key),
      secret_access_key: Rails.application.credentials.dig(:amazon, :api_secret_key)
    )
    data = { 
      table_name: "webhooks",
      item:  {id: rand(2**31)}.merge(params.to_unsafe_h)
     }
     
    begin
      dynamodb.put_item(data)
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      puts 'Unable to add movie:'
      puts error.message
    end

    head :no_content
  end

  def update
    dynamodb = Aws::DynamoDB::Client.new(
      region: 'us-east-1',
      access_key_id:  Rails.application.credentials.dig(:amazon, :api_key),
      secret_access_key: Rails.application.credentials.dig(:amazon, :api_secret_key)
    )
    data = { 
      table_name: "webhooks",
      item: {id: rand(2**31)}.merge(params.to_unsafe_h)
     }

    
    begin
      dynamodb.put_item(data)
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      puts 'Unable to add movie:'
      puts error.message
    end
      

    head :no_content
  end

  
end
