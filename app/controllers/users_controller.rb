class UsersController < ApplicationController

  # GET /users/register
  def register
    @user = User.new
  end

  # GET /users/login
  def login

  end

  # POST /users/create_session
  def create_session
    current_params = new_session_params
    if User.authenticate(current_params[:matric], current_params[:room_number])

      current_user = User.where(matric: current_params[:matric]).where(room_number: current_params[:room_number]).first
      session[:user] = current_user

      # go to their house sentence page
      redirect_to house_latest_path

    else
      redirect_to login_path, flash: { problem: "Matric card or room number is not registered!" }
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    #capitalise and upcase input
    @user.name = @user.name.try(:titleize)
    @user.matric.try(:upcase!)
    @user.room_number.try(:upcase!)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'User was successfully created! Please log in with your matric number and room number.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :register }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    def user_params
      params.require(:user).permit(:name, :matric, :room_number)
    end

    def new_session_params
      mod_params = params.permit(:matric, :room_number)
      mod_params[:matric].try(:upcase!)
      mod_params[:room_number].try(:upcase!)
      return mod_params
    end

end
