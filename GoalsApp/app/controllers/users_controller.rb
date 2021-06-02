class UsersController < ApplicationController

    def new
        render :new
    end
    
    def create
        @user = User.new(user_params)
    end
    
    def show
        @user = User.find(params[:id])
        render :show
    end
    
    def destroy
    
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end
end