module IsLoggedIn
  include HasOauth
  
  def self.included( base)
    base.before_filter :is_logged_in
  end

  def is_logged_in
    @user = AccessToken.find_by_id( session[:user_id])
    if @user.nil?
      redirect_to home_index_url
    end
  end

  def is_superuser
    if @user.nil? || !@user.is_superuser
      redirect_to home_index_url
    end
  end  

end
