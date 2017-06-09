class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_company, only: [:show, :edit, :update]
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
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end


  private    
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:country_code, :phone_no, :street_address, :state, :postal_code, :overview, :since)
    end

    def verify_company_admin
      unless current_user.is_company_admin_of(@company)
        redirect_to root_path, notice: "You are not authorized to access this page."
      end
    end
end
