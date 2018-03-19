class PaymentsController < ApplicationController
  before_action :set_order
  after_action :verify_authorized, except: :create


  skip_before_action :authenticate_user!, only: [:create]

  def create
    customer = Stripe::Customer.create(
        source: params[:stripeToken],
        email:  params[:stripeEmail]
      )

      # charge = Stripe::Charge.create(
      #   customer:     customer.id,   # You should store this customer id and re-use it.
      #   amount:       @bill.balance_cents,
      #   description:  "Thank you for paying",
      #   currency:     :eur
      # )

      # @order.update(payment: charge.to_json, status: 'paid')

      redirect_to bill_path(@bill)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to bill_path(@bill)
  end

private

  def set_order
    @bill = Bill.where(status: 'unpaid').find(params[:bill_id])
  end
end

