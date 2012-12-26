ENV['soundcloud_client_id'] = '97522a2c00d248614d25b3f6ceca1688'
ENV['soundcloud_client_secret'] = '6d0e9e6fae5202025f86bd9e844de5bf'

if Rails.env.production?
  ENV['soundcloud_callback_url'] = ENV['URL'] + '/sessions/new'
else
  ENV['soundcloud_callback_url'] = 'http://localhost:3000/sessions/new'
end
