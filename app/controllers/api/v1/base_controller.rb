class Api::V1::BaseController < ApplicationController
  def to_json data, status, type, message
    render json: {
      data:  data,
      message: message,
      status: status,
      type: type
    }
  end
end