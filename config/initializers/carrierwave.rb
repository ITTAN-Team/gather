CarrierWave.configure do |config|
  case Rails.env
    when 'production'
      config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['S3_ACCESS_KEY'],
        aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
        region: 'ap-northeast-1'
      }
      config.fog_directory = 'gather-photo'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/gather'
  end
end
