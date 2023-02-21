# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  def twitter
    callback_for(:twitter)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  private
  
  # コールバック時に行う処理
  #def callback_from(provider)
    #provider = provider.to_s

    #@user = User.find_for_oauth(request.env['omniauth.auth'])

    # persisted?でDBに保存済みかどうか判断
    #if @user.persisted?
      #flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      #sign_in_and_redirect @user, event: :authentication
    #else
      #session["devise.#{provider}_data"] = request.env['omniauth.auth']
      #redirect_to new_user_registration_url
    #end
  #end
end