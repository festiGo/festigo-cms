CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',       # required
      :aws_access_key_id      => ENV["S3_ACCESS"],       # required
      :aws_secret_access_key  => ENV["S3_SECRET"],       # required
      #:region                 => 'eu-west-1'
  }
  config.fog_directory  = 'festigo' # required

end