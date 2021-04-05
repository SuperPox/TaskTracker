class UsersController < ApplicationController

    before_action(:set_user, except: [:create])
  
    def new
        @user = User.new
    end

    def show
        @user = User.find_by(id: params[:id])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            @errors = @user.errors.full_messages
            render :new
        end
    end

    def edit
        set_user
    end

    def update
        if @user.update(profile_params)
            redirect_to user_path(@user)
        else
            @errors = @user.errors.full_messages
            render :edit
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation)
    end

    def set_user
        @user = User.find_by(id: params[:id])
    end

    def profile_params
        params.require(:user).permit(:username, :password, :password_confirmation, :expertise)
    end

end