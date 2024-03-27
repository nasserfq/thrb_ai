RailsCloudflareTurnstile.configure do |c|
	c.site_key =  Rails.application.credentials.CLOUDFLARE_TURNSTILE
	c.secret_key = Rails.application.credentials.CLOUDFLARE_SECRET_KEY
	c.fail_open = true
end