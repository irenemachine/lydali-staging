require 'shopify_api'

#These credentials can be found under Manage Apps > Private Apps
KEY = "ee78540a20509605a59e61d82be0ae43"
PASSWORD = "61f08f9eadf0bf7557e6c957f79974cc"
DOMAIN = "lydali"

#Staging theme ID found using ShopifyAPI::Theme.all
THEME_ID = "3010764"

watch('.*/.*.liquid') do |match|
  puts "Updating #{match[0].inspect}..."
  upload_template(match.to_s)
end

watch('config/.*.') do |match|
  puts "Updating #{match[0].inspect}..."
  upload_template(match.to_s)
end

def upload_template(file)
  ShopifyAPI::Base.site = "https://#{KEY}:#{PASSWORD}@#{DOMAIN}.myshopify.com/admin"
  asset = ShopifyAPI::Asset.find(file, :params => {:theme_id => THEME_ID})
  asset.value = File.read(file)
  asset.save
end
