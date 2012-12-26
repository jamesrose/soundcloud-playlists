config = {
  'development' => {
    client_id: '97522a2c00d248614d25b3f6ceca1688',
    client_secret: '6d0e9e6fae5202025f86bd9e844de5bf',
    client_callback: 'http://localhost:3000/sessions/new'
  },
  'production' => {
    client_id: 'f3acccdf3d32e4e586a40a3bda998228',
    client_secret: ENV['soundcloud_secret'],
    client_callback: ENV['soundcloud_callback']
  }
}

SOUNDCLOUD = config[Rails.env]