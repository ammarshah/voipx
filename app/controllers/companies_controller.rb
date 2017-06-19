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
    if @company.references.nil?
      3.times { @company.references.build }
    else
      (3-@company.references.count).times { @company.references.build }
    end
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
      params.require(:company).permit(:logo, :country_code, :phone_no, :street_address, :state, :postal_code, :overview, :since, product_ids: [], other_products_attributes: [:id, :name, :_destroy], reports_attributes: [:id, :name, :document, :_destroy], references_attributes: [:id, :contact_person, :name, :website, :email, :phone, :_destroy])
    end

    def verify_company_admin
      unless current_user.is_company_admin_of(@company)
        redirect_to root_path, notice: "You are not authorized to access this page."
      end
    end
end
