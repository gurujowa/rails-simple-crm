CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAJWJIT4JE7LRSVUSQ',
    :aws_secret_access_key  => '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',
    :region                 => 'ap-northeast-1'
  }

  config.fog_directory = 'deppu' if Rails.env.production?
  config.fog_directory = 'deppu-dev' if Rails.env.development?

end
