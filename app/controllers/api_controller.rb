class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  private

  def permission_denied?
    permission_denied_error unless conditions_met
  end

  def conditions_met
    false # default, override in api controller
  end

  def permission_denied_error
    error(403, 'Permission Denied')
  end

  def error(status, message = 'Something went wrong')
    response = {
      response_type: 'ERROR',
      message: message
    }
    render json: response.to_json, status: status
  end
end