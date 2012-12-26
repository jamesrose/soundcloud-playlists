# Soundcloud Playlist Creator

The are two parts to this app: the Spine front-end and the Rails backend. You can find the former in `app/assets/javascripts/app`.

## Usage

1. Checkout the Git repository
2. Create a [http://soundcloud.com/you/apps](SoundCloud App) for your `production` and `development` environments. Use the given information to create a config file in `config/soundcloud.yml`:

  development:
    client_id: your-client-id
    client_secret: your-client-secret
    client_callback: your-callback-url

  production:
    client_id: your-client-id
    client_secret: your-client-secret
    client_callback: your-callback-url
  
3. `bundle install && rake db:setup`
4. `rails s`
5. Open [http://localhost:3000](http://localhost:3000)
6. Check out `app/assets/javascripts/app` and `app/` to see how everything works.
