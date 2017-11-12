CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'gather-photo'
  config.cache_storage = :fog
end
