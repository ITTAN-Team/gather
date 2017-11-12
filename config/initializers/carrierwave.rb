CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAJEHUIMM5Z7ZRGK2Q',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'gather-photo'
  config.cache_storage = :fog
end
