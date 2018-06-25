Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	post 'authenticate', to: 'authentication#authenticate'
  post 'register', to: 'registration#register'
  post 'isvalid', to: 'authentication#is_token_valid'
  get 'exists', to: 'registration#email_exists'
  post '/delete', to: 'delete#deleteuser'

  get 'securityquestions', to: 'security_questions#get_security_questions'
  post 'validateanswers', to: 'security_questions#validate_security_answers'
  get 'user', to: 'userinfo#get_user_info'
  get 'user/token', to: 'userinfo#get_user_info_with_token'
  post 'fileupload', to: 'fileupload#upload_file'

  post '/createmeeting', to: 'meetings#createmeeting'
 
  post 'updateinfo', to: 'updateinfo#updateinfo'

  post '/joinmeeting', to: 'meetings#joinmeeting'

  get 'meeting/presenter', to: 'meetings#get_presenter_id'
  get '/download/apk', to: 'fileupload#downloadapk'
end
