class ReviewsController < ApplicationController
    before_filter :authorize

    def create
        @product = Product.find(params[:product_id])
        @review = Review.new(review_params)
        @review.product = @product
        @review.user = current_user
        if @review.save
            redirect_to @product, notice: 'Success!'
        else
            redirect_to @product
        end
    end

    def destroy
        @user = User.find(current_user.id)
        @review = @user.reviews.find(params[:id])
        @product = Product.find(params[:product_id])
        if @review.destroy
            redirect_to @product
        else
            redirect_to @product
        end
    end

    private
    
    def review_params
      params.require(:review).permit(
        :description,
        :rating,
        :user_id,
        :product_id
      )
    end

end
