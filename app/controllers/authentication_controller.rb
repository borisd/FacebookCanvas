class AuthenticationController < ApplicationController
  protect_from_forgery :except => [:create, :canvas]
  
  def canvas
    redirect_to "/users/auth/facebook?signed_request=#{params[:signed_request]}"
  end

  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def destroy
    raise 'TODO: Implement'
  end
end
