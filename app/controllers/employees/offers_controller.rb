class Employees::OffersController < ApplicationController

  def show

  end

  def edit

  end

  def new
    @offer = Offer.new
    @merchant_emails = User.where(role:"merchant").map {|t| [t.email, t.id]}
    @customer_emails = User.where(role:"customer").map {|t| [t.email, t.id]}
    #TODO this seems wrong and inefficient
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.options = JSON.parse(offer_params[:options])
    @offer.tags = offer_params[:tags].split(' ')
    @offer.image.attach offer_params[:image]

    #TODO the above code smells

    respond_to do |format|
      if @offer.save
        format.html { redirect_back fallback_location: :new, notice: "Offer was successfully created"}
        format.json {render :new, status: :createc, location: @user} #I don't know what this means
      else
        format.html {render :new}
        format.json {render json: @offer.errors, status: :unprocessable_entity}
      end
    end

  end

  def destroy

  end

  private

    def offer_params
      params.require(:offer).permit(:status,
                                    :description,
                                    :title,
                                    :tags,
                                    :options,
                                    :selected_option,
                                    :customer_id,
                                    :merchant_id,
                                    :image)
    end

end
