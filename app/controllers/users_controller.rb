class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :not_admin, except: [:non_auth]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end
  
  def non_auth

  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_url, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_url, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def not_admin
      unless current_user.admin? 
        redirect_to :action => "non_auth"
      end
    end
    # Only allow a trusted parameter "white list" through.
    def  user_params
      params.require(:user).permit(:id, :name, :password, :password_confirmation, :email)
    end
end
