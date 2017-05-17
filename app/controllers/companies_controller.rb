class CompaniesController < ApplicationController
  respond_to :json

  def index
    @companies = Company.all

    render json: @companies
  end
end
