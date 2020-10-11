desc "Sync Shops with intercom"
task intercom_sync_task: :environment do
  Shop.all.each { |shop| IntercomSyncJob.perform_later(shop) }
end
