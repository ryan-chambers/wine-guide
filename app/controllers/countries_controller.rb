class CountriesController < ApplicationController
  def index
    @country = params[:country]

    if Country.is_country?(@country)
      logger.info "Found country #{@country}"
      respond_to do |format|
        format.json { render :json => Country::COUNTRIES[@country].regions}
      end
    else
      logger.info "Invalid country #{@country}"
      format.json { render :json => ''}
    end
  end
end
