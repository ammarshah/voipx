class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_company, only: [:show, :edit]
  before_action :verify_company_admin, only: [:edit, :update]

  def index
    @companies = Company.all

    render json: @companies
  end

  def show
  end

  def edit
  end

  def update
    
  end


  private    
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:country_code, :phone_no)
    end

    def verify_company_admin
      redirect_to root_path, notice: "You are not authorized to access this page." unless current_user.is_company_admin_of(@company)
    end
end
