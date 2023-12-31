module Users
  # Controller responsible for handling user sessions (login and logout).
  # This controller inherits from Devise::SessionsController and includes
  # RackSessionFix module for session management.
  class SessionsController < Devise::SessionsController
    include RackSessionFix
    respond_to :json
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end

    private

    def respond_with(resource, _opts = {})
      user_serializer = UserSerializer.new(resource)
      render json: {
        status: {
          code: 200,
          message: 'Logged in successfully'
        },
        user: user_serializer
      }, status: :ok
    end

    def respond_to_on_destroy
      if current_user
        render json: { status: 200, message: 'logged out successfully' }, status: :ok
      else
        render json: {
          status: 401,
          message: "Couldn't find an active session."
        }, status: :unauthorized
      end
    end
  end
end
