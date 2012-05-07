require 'shopify_api'

#These credentials can be found under Manage Apps > Private Apps
KEY = "f127678300518a83996411f288f1cfcb"
PASSWORD = "b3e427d64b734e72d06e6dd72404a99c"
DOMAIN = "irenemachine"

#Staging theme ID found using ShopifyAPI::Theme.all
THEME_ID = "3010780"



watch('.*/.*.liquid') do |match|
  puts "Updating #{match[0].inspect}..."
  upload_template(match.to_s)
end

def upload_template(file)
  ShopifyAPI::Base.site = "https://#{KEY}:#{PASSWORD}@#{DOMAIN}.myshopify.com/admin"
  asset = ShopifyAPI::Asset.find(file, :params => {:theme_id => THEME_ID})
  asset.value = File.read(file)
  asset.save
end
