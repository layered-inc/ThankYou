# Read: https://techracho.bpsinc.jp/hachi8833/2018_07_13/59205/
if Rails.env.production?
  class Rack::Attack
    Rack::Attack.blocklist('bad-robots') do |req|
      req.ip if /\S+\.php/.match?(req.path)
    end
  end
end
