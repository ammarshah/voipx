class ReportsController < ApplicationController
  before_action :set_company, only: [:destroy]
  before_action :set_report, only: [:destroy]
  
  def destroy
    @report.destroy
    redirect_to edit_company_path(@company), notice: "D&B Report was successfully deleted."
  end


private
  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_report
    @report = @company.reports.find(params[:id])
  end
end