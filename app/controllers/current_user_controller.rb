# Controller responsible for handling requests related to the current user
class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  # Returns the current user's data as JSON.
  def index
    render json: current_user, serializer: UserSerializer
  end
end
