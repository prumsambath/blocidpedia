Rails.configuration.stripe = {
  publishable_key: ENV['strip_publishable_key'],
  secret_key: ENV['strip_secret_key']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
