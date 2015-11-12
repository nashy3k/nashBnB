OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '543058142526672', '0d7ca0551711e4f8e6a14c7925e1b403', scope: 'public_profile,email', info_fields: 'id,name,link,first_name,last_name,email'

end