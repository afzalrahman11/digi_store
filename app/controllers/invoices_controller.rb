class InvoicesController < ApplicationController
  before_action :set_invoice, only: [ :show, :update, :destroy ]

  def index
    @invoices = Invoice.all
    render json: @invoices
  end

  def show
    render json: @invoice
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      render json: @invoice, status: :created
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  def update
    if @invoice.update(invoice_params)
      render json: @invoice
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @invoice.destroy
    head :no_content
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:payment_status, :date, :total_amount, :user_id, :debtor_id)
  end
end
