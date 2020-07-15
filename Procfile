web: bin/rails server -p ${PORT:-5000} -e $RAILS_ENV
worker: bundle exec sidekiq -c 10 -q critical,4 -q default,2 -q low,1 -q active_storage_analysis,1 -q active_storage_purge,1