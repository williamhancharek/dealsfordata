web: bundle exec puma -C config/puma.rb
webpacker: ./bin/webpack-dev-server
redis: redis-server ./redis.conf
worker: bundle exec sidekiq -q default -q mailers
log: tail -f ./log/development.log
