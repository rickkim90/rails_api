# 4차산업혁명 선도인재 양성 프로젝트 과정

---
## 1. Week 1 Day 23:   

***



1. #### scaffold에서 만들어진 jbuilder 만들기

posts_controller.rb

```ruby
  def api_index
    @p = {
      title: "test",
      content: "test"
    }
    render json: @p
  end
```

http://localhost:3000/api_index

http://localhost:3000/posts/1.json



2. render를 json 형식으로
3. rails new test_app —api

= middelwared없이 생성

안드로이드에는 cookie없이 jwt json web token 로컬에 미리 저장

처음 등록을 하고 그 후 매번 확인하지 않고

4. ruby-jwt

https://github.com/jwt/ruby-jwt



```ruby
token = JWT.encode payload, hmac_secret, 'HS256'
```

payload => 암호화 하려는 정보

hmac_secret => 암호화 키



```ruby
decoded_token = JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }
```

복호화 하는 알고리즘까지 지정해줘야 하며 나 자신만 당연히 알고있어야한다.



암호화, 복호화

```ruby
require 'jwt'
class JsonWebToken
  def self.encode(payload)
    JWT.encode payload, nil, 'none'
  end

  def self.decode(token)
    JWT.decode token, nil, false
  end
end
```



(로그인)유저가 있는 상태에서 로그인 > email, password 입력 받음 -> 서버로 전송 -> jwt을 받아서 저장(login)

(로그인 된 상태)jwt 날렸을때 -> 저장된 jwt을 서버로 전송 -> 서버는 현재 요청을 보낸 client가 누군인지 파악(authenticate)



rails g model user email password_digest

Gemfile에서 gem 'bcrypt', '~> 3.1.7' comment out

model user.rb에서 has_secure_password 추가

u = User.find_by(email: "test@test.com")

!!u.authentication

=> true



```ruby
def auth_token
  @auth_token ||= request.headers.fetch("Authorization", "")
end
```

auth_token값이 ||= 뜻은 비어있으면 채우고 값이 들어있으면 그대로 진행



요청이 json, html로 올때 가고 분기처리를 해야한다

같은서버에서 application api, web server api를 사용하면 분기처리는 필수다

http://localhost:3000/posts.json
