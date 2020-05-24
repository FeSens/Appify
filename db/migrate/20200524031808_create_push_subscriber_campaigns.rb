class CreatePushSubscriberCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :push_subscriber_campaigns do |t|
      t.references :push, null: false, foreign_key: true
      t.references :campaing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
