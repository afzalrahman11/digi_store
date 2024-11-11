class InvoicesController < ApplicationController
  before_action :set_invoice, only: [ :show, :update, :destroy ]
  around_action :wrap_in_transaction, only: [ :create, :update, :destroy ]

  def index
    @invoices = Invoice.all
    render json: @invoices
  end

  def show
    render json: @invoice
  end

  def create
    debtor = add_debtor_if_needed(invoice_params)
    @invoice = Invoice.new(invoice_params.merge(debtor: debtor))

    if @invoice.save
      render json: @invoice, status: :created
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  def update
    previous_total = @invoice.total_amount
    if @invoice.update(invoice_params)
      update_debtor_total_debt(@invoice, previous_total)
      render json: @invoice
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @invoice.debt?                    # predicate method will allow to replace @invoice.payment_status == "debt"
      update_debtor_total_debt(@invoice, -@invoice.total_amount)
    end
    @invoice.destroy
    head :no_content
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:payment_status, :date, :total_amount, :user_id, :debtor_id, :debtor_name, :debtor_phone, :debtor_email)
  end

  # add debtor details if the amount is not paid
  def add_debtor_if_needed(params)
    return unless params[:payment_status] == "debt"
    debtor = Debtor.find_or_initialize_by(phone: params[:debtor_phone])
    debtor.name ||= params[:debtor_name]
    debtor.email ||= params[:debtor_email]
    debtor.total_debt ||= 0
    debtor.total_debt += params[:total_amount].to_f
    debtor.save!
    debtor
  end

  # update the debt amount for the debtor if an invoice is updated/deleted
  def update_debtor_total_debt(invoice, previous_amount)
    return unless invoice.debt?

    debtor = invoice.debtor
    if debtor
      debtor.total_debt += (invoice.total_amount - previous_amount).to_f
      debtor.save!
    end
  end

  def wrap_in_transaction
    ActiveRecord::Base.transaction do
      yield
    end
  end
end
