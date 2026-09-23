class Rack::Attack
  throttle("login/ip", limit: 3, period: 1.minute) do |req|
    if req.path == "/login" && req.post?
      req.ip
    end
  end
end