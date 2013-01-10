class WinesController < ApplicationController
  def index
    # FIXME add pagination
    @wines = Wine.limit(50)

    respond_to do |format|
      format.html
      format.json { render :json => @wines}
    end
  end

  def show
    @wine = Wine.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @wine}
    end
  end

  def create
    @wine = Wine.new(params[:wine])

    @winery_name = params[:winery_name]

    @winery = Winery.find_by_name(@winery_name)

    if @winery
      logger.info "Found existing winery #{@winery}"
      @wine.winery = @winery
    else
      logger.info "Creating new winery #{@winery_name}"
      @winery = Winery.new
      @winery.name = @winery_name
      @winery.save
    end

    logger.info "Got wine #{@wine}"

    @wine.save

    if @wine.errors.any?
      flash[:notice] = 'Errors saving wine ' + @wine.errors.full_messages.join(', ')
      render :action => 'new'
    else
      redirect_to wine_path(@wine)
    end
  end

  def new
    @wine = Wine.new
    @winery_name = ''

    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @wine }
    end
  end
end
