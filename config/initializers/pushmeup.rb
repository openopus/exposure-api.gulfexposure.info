# apns.rb: -*- Ruby -*-  DESCRIPTIVE TEXT.
# 
#  Copyright (c) 2016 Brian J. Fox
#  Author: Brian J. Fox (bfox@opuslogica.com) Sun Sep  4 17:30:32 2016.

# These are set in config/environeents/{development.rb,production.rb}
# APNS.host = 'gateway.push.apple.com'
# APNS.host = 'gateway.sandbox.push.apple.com'

# Default port.
# APNS.port = 2195

APNS.pem = "config/TheExposureAPNS.pem"
# APNS.pass = ''

# GCM.host = 'https://android.googleapis.com/gcm/send'
GCM.host = 'https://android.googleapis.com/gcm/send'

# :json is default and only available at the moment
GCM.format = :json

# this is the apiKey obtained from here https://code.google.com/apis/console/
GCM.key = "AIzaSyD9ifQNiQG9APfhy0Fuy8kjfFPLmdks9O0"

