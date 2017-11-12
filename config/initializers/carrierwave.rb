CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    region: 'ap-northeast-1',
    use_iam_profile: true
  }

  config.fog_directory  = 'gather-photo'
  config.cache_storage = :fog
end
