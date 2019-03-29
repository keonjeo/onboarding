class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, if: Proc.new { |c| c.request.format == 'application/json' }

  before_action :set_user, only: [:show, :edit, :update, :destroy, :name]
  respond_to :json, :html

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    respond_to do |format|
      format.json { render :json => @users.as_json }
      format.html
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { render :show, status: :created, location: @user }
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { render :show, status: :ok, location: @user }
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  # GET /users/count
  # GET /users/count.json
  def count
    @users_count = User.count
  end

  # GET /users/1/name
  # GET /users/1/name.json
  def name
    @full_name = "#{@user.first_name}  #{@user.last_name}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :age,
        :gender,
        {
          address: [:country, :address_1, :address_2]
        }
      )
    end
end
