class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    if user_exists?(sign_up_params[:email])
      render json: { error: 'Email already exits, please change' }
    else
      build_resource(sign_up_params)
      if resource.save
        sign_in(resource_name, resource)
        render json: resource
      else
        render json: { error: 'Something is wrong, try again' }
      end
      
    end
  end

  protected

  def user_exists?(email)
    User.exists?(email:)
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


end
