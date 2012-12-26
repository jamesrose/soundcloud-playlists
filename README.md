# SoundCloud Playlist Creator

The are two parts to this app: the Spine front-end and the Rails backend. You can find the former in `app/assets/javascripts/app`.

## Usage

1. Checkout the Git repository
2. Create a [SoundCloud App](http://soundcloud.com/you/apps) for each `production` and `development` with a callback path of `<host>/sessions/new`. Use the given information to create a config file in `config/soundcloud.yml`:
  ``` yaml
    development:
      client_id: your-client-id
      client_secret: your-client-secret
      client_callback: http://localhost:3000/sessions/new

    production:
      client_id: your-client-id
      client_secret: your-client-secret
      client_callback: http://my-production-app.com/sessions/new
  ```
3. `bundle install && rake db:setup`
4. `rails s`
5. Open [http://localhost:3000](http://localhost:3000)
6. Check out `app/assets/javascripts/app` and `app/` to see how everything works.
