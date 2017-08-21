class CountriesController < ApplicationController
  def index
    @country = params[:country]
    @region_partial = params[:region_partial]
    @regions = []
#    p "Got country #{@country}"
#    p "Got region #{@region_partial}"

    if Country.is_country?(@country)
#      logger.info "Found country #{@country}"
      if @region_partial
        @regions = Country::COUNTRIES[@country].regions.select { |r| r.downcase.include? @region_partial.downcase}
      else
        @regions = Country::COUNTRIES[@country].regions
      end
      respond_to do |format|
        format.json { render :json => @regions}
      end
    else
      logger.info "Invalid country #{@country}"
      respond_to do |format|
        format.json { render :json => ''}
      end
    end
  end
end
