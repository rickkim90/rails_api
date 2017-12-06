require 'jwt'

payload = {:user_id => '1'}

# IMPORTANT: set nil as password parameter
token = JWT.encode payload, nil, 'none'
#payload = 요청하는 body requrest.body
# encode 암호화

# eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0.eyJkYXRhIjoidGVzdCJ9.
puts token

# Set password to nil and validation to false otherwise this won't work
decoded_token = JWT.decode token, nil, false
#decode 복호화

# Array
# [
#   {"data"=>"test"}, # payload
#   {"alg"=>"none"} # header
# ]
puts decoded_token
