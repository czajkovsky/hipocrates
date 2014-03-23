ActionMailer::Base.smtp_settings = {
  :address              => SecretConfig.mail.smtp_server,
  :port                 => SecretConfig.mail.port,
  :domain               => SecretConfig.domain,
  :user_name            => SecretConfig.mail.user_name,
  :password             => SecretConfig.mail.password,
  :authentication       => 'plain',
  :enable_starttls_auto => true
}

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_url_options[:host] = 'localhost:3000'
