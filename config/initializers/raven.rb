Raven.configure do |config|
  config.dsn = 'https://8102de896c714af192c7a5b2916ac665:1f45b282dda34dafbcab08f0a083a758@sentry.io/1265123'
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.environments = %w[production]
end
