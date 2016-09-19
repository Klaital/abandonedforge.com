class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.where(email: params[:session][:email].downcase).first
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      flash[:success] = "Welcome to AbandonedForge, #{user.name}"
      redirect_to :controller => 'products', :action => 'index'
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
