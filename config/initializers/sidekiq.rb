# sidekiq.rb
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/0' }
end
# sudo iptables -A DOCKER -p tcp --dport 6379 -j ACCEPT
# sudo iptables -L -n
