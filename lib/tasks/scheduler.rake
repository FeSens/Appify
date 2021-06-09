desc "Sync Shops with intercom"
task intercom_sync_task: :environment do
  Shop.all.each { |shop| 
    IntercomSyncJob.perform_later(shop) 
    BillingCheckJob.perform_later(shop)
  }
end

desc "Update cached counters"
task update_cached_counters: :environment do
  CachedCountableJob.perform_now 
end