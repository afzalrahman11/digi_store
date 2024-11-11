class DebtorsController < ApplicationController
  before_action :set_debtor, only: [ :show, :update, :destroy ]

  def index
    @debtors = Debtor.all
    render json: @debtors
  end

  def show
    render json: @debtor
  end

  def create
    @debtor = Debtor.new(debtor_params)
    if @debtor.save
      render json: @debtor, status: :created
    else
      render json: @debtor.errors, status: :unprocessable_entity
    end
  end

  def update
    if @debtor.update(debtor_params)
      render json: @debtor
    else
      render json: @debtor.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @debtor.destroy
    head :no_content
  end

  private

  def set_debtor
    @debtor = Debtor.find(params[:id])
  end

  def debtor_params
    params.require(:debtor).permit(:name, :phone, :email, :total_debt)
  end
end
