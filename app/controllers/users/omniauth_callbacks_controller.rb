class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def slack
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: 'Slack') if is_navigational_format?
    else
      set_flash_message(:notice, 'すでに登録済みのメールアドレスか、登録情報に不備があります。')
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
