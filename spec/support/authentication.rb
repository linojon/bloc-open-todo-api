def with_authentication
  # user = 'testuser'
  # pw   = 'secret'
  # User.create username: user, password: pw
  # request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)

  Api::UsersController.any_instance.stub(:conditions_met) { true }
end

def unstub_authentication
  Api::UsersController.any_instance.unstub(:conditions_met)
end