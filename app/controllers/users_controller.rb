class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
    
        if @user.save
          session[:id] = @user.id
          redirect_to '/login', notice: 'User created!'
        else
          render :new
        end
      end
    
      def destroy
        @user = User.find params[:id]
        @user.destroy
        redirect_to :users, notice: 'User deleted!'
      end
    
      private
    
      def user_params
        params.require(:user).permit(
          :name,
          :email,
          :password,
          :password_confirmation
        )
      end

end
