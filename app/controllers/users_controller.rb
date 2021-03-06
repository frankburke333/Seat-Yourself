class UsersController < ApplicationController
  def new
     @user = User.new
   end

   def create
     @user = User.new(user_params)

     if @user.save
       UserMailer.welcome_email(@user).deliver_now
       flash[:notice] = "Signed up!"
       redirect_to restaurants_url
     else
       flash.now[:error] = 'Sorry, try again!'
       render :new
     end
   end

   def show
    @user = User.find(params[:id])
    @reservations = @user.reservations
    @restaurants = Restaurant.all
   end

   private
   def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation)
   end
end
