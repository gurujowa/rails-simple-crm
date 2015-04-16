CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => Rails.application.secrets.aws_access_key_id,
    :aws_secret_access_key  => Rails.application.secrets.aws_secret_access_key,
    :region                 => 'ap-northeast-1'
  }

  config.fog_directory = 'deppu' if Rails.env.production?
  config.fog_directory = 'deppu-dev' if Rails.env.development?

end
