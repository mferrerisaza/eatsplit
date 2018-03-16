class PaymentsController < ApplicationController
  before_action :set_order

  def create
    customer = Stripe::Customer.create(
        source: params[:stripeToken],
        email:  params[:stripeEmail]
      )

      charge = Stripe::Charge.create(
        customer:     customer.id,   # You should store this customer id and re-use it.
        amount:       @bill.balance_cents,
        description:  "Payment for dinner #{@bill.teddy_sku} for order #{@order.id}",
        currency:     EUR
      )

      @order.update(payment: charge.to_json, status: 'paid')
      redirect_to order_path(@order)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to bill_path(@bill)

  end

private

  def set_order
    @bill = Bill.where(state: 'unpaid').find(params[:bill_id])
  end
end


#pmt create method
# chnage stripe button design
#get data for stripe
