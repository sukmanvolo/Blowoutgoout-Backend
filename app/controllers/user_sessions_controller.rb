class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[index new create]

  def new
    @user = User.new
  end

  def create
    # @user = login(params[:email], params[:password])
    token = login_and_issue_token(params[:email], params[:password], params[:remember])

    respond_to do |format|
      if current_user
        format.html { redirect_back_or_to :users }
        format.json do
          render json: { user: serialize(current_user),
                         token: token }, status: :created
        end
      else
        format.html { flash.now[:alert] = 'Login failed' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    logout
    redirect_to(:users, notice: 'Logged out!')
  end
end
