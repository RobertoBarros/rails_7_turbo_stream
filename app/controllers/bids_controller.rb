class BidsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    value = params[:bid_value]
    bid = Bid.create!(product: product, user: current_user, value: value)


    respond_to do |format|
      format.html { redirect_to product_path(product) }
      format.turbo_stream do
        bid.broadcast_prepend_to product

        product.broadcast_update_to product, html: view_context.number_to_currency(product.final_price), target: 'current-price'

        # product.broadcast_update_to product,
        #                            partial: 'products/product_info',
        #                            locals: {bid: Bid.new, current_user: nil}
      end

    end



  end
end
