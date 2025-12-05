class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email]
    password = params[:password]

    # Potential SQL Injection vulnerability here by using an unsanitised query
    query = "SELECT * FROM users WHERE email = '#{email}' AND password = '#{password}' LIMIT 1"
    user = User.find_by_sql(query).first

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end
end
