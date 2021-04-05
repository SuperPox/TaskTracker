class UsersController < ApplicationController

    before_action(:set_user, except: [:create])
    before_action(:require_login, except: [:new, :create])

  
    def new
        @user = User.new
    end

    def show
        @user = User.find_by(id: params[:id])
        update_user_ranks2(@user)
        @star = User.top_tasker
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

    def update_user_ranks2(user)
        @rankcount = 0
        @projectcount = 0
        user.projects.each do |p|
                @projectcount += 1
                p.tasks.each do |t|
                    if (t.assigned == user.id && t.task_status == 2)
                        @rankcount += 1
                    end
                end
            end
        user.rank = @rankcount/@projectcount
        user.save
    end
end