class AddEmitterToWebhook < ActiveRecord::Migration[6.0]
  def change
    add_column :webhooks, :emitter, :string
  end
end
