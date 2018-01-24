class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :verify_user, only: [:edit, :update]

  def show
  end

  def edit
    @first_login = true if params[:is_first_login]
    @user.company || @user.build_company
  end

  def update
    if @user.update(user_params)
      added_company = params[:user][:company_attributes].present? && @user.company_id.present?
      # flash[:notice] = added_company ? I18n.t("devise.registrations.update_needs_confirmation") : "Your profile has been updated, please #{view_context.link_to('click here', dashboard_path)} to continue"
      flash[:notice] = added_company ? I18n.t("devise.registrations.update_needs_confirmation") : "Your profile has been updated"
      redirect_to dashboard_path()
    else
      # retain company fields values on validation fail
      if @user.selected_company_id.present? && @user.company.nil?
        @user.company = Company.find_by_id(@user.selected_company_id)
      else
        @user.company || @user.build_company
      end
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def verify_user
      redirect_to root_path, alert: "You are not authorized to access this page." unless current_user == @user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :position, :about, :photo, :cover, :skype, :phone, :country_code, :facebook_url, :twitter_url, :linkedin_url, :company_id, :email, :selected_company_id, :add_company_bool, company_attributes: [:name, :country_code, :website, :phone_no])
    end
end
