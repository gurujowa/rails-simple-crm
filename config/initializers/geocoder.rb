# config/initializers/geocoder.rb
Geocoder.configure(

  # geocoding service (see below for supported options):
#  :lookup => :bing,

  # to use an API key:
#  :api_key => "As06qmlmH97BW18YhnVpamsHlQ-TNH4AEYgFK9r2yD4oQWidqCgJAMVxT7mTJBBf",

  # geocoding service request timeout, in seconds (default 3):
  :timeout => 5,

  # set default units to kilometers:
  :units => :km,

)
