class PaymentsController < ApplicationController
  before_action :set_bill
  after_action :verify_authorized, except: [:new, :create]


  skip_before_action :authenticate_user!, only: [:new, :create]


  def create
    customer = Stripe::Customer.create(

      source: params[:payment][:stripe_token],
      email:  params[:payment][:stripe_email]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @bill.check_orders.cents,
      description:  "Thank you for paying",
      currency:     :eur
    )

    @bill.orders.each do |order|
      if order.status == "1"
        order.status = "paid"
        order.save!
      end
    end

    redirect_to bill_path(@bill)

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to bill_path(@bill)
  end

private

  def set_bill
    @bill = Bill.where(status: 'unpaid').find(params[:bill_id])
  end
end

