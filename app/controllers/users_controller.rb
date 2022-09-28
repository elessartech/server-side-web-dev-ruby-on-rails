# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @current_user = current_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |_format|
      if @user.save
        redirect_to user_url(@user), notice: 'User was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if !current_user || (current_user.id != @user.id)
      redirect_to users_url
    else
      respond_to do |format|
        if user_params[:username].nil? && (@user == current_user) && @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    if !current_user || (current_user.id != @user.id)
      redirect_to users_url
    else
      @user.destroy
      session[:user_id] = nil
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
