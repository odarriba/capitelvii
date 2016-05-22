CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Rails.application.secrets.aws['access_key_id'],
    aws_secret_access_key: Rails.application.secrets.aws['secret_access_key'],
    host:                  "http://s3-#{Rails.application.secrets.aws['region']}.amazonaws.com/",
    region:                Rails.application.secrets.aws['region']
  }
  config.fog_directory  = Rails.application.secrets.aws['bucket']
end
