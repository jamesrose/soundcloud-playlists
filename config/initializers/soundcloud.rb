SOUNDCLOUD_CONFIG = YAML.load_file("#{Rails.root}/config/soundcloud.yml")[Rails.env].symbolize_keys
