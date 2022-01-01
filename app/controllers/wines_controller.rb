class WinesController < ApplicationController
  before_action  :authenticate, :except => [:index, :show]

  def index
    logger.info "Got search params #{params[:term]}, #{params[:reviews_from]}, #{params[:reviews_to]}"

    if params[:term] or params[:reviews_from] or params[:reviews_to]
      logger.info "searching for #{params[:term]}, #{params[:reviews_from]}, #{params[:reviews_to]}"
      if WinesController.is_lcbo_code params[:term]
        logger.info "Searching for lcbo code #{params[:term]}"
        @wines = Wine.find_all_by_lcbo_code params[:term]
      else
        @wines = Wine.search_for_wine params[:term] || '', params[:reviews_from] || '', params[:reviews_to] || ''
      end
    else
      @wines = Wine.filter_paginate(params[:country_filter] || '', :page => params[:page])
    end

#    logger.info "got #{@wines}.length() wines"

    respond_to do |format|
      format.html
      format.json { render :json => @wines, :include => { :winery  => {:only => :name}, :grapes => { :only => :name} } }
    end
  end

  def show
    @wine = Wine.find(params[:id])

    logger.info "got winery #{@wine}"
    respond_to do |format|
      format.html
      format.json { render :json => @wine}
    end
  end

  def create
    @wine = Wine.new(wine_params)

    @winery_name = params[:winery_name]
    @grape_name = params[:grape_name]

    @winery = Winery.find_by_name(@winery_name)

    # logger.info "grape name is '#{@grape_name}'"
    @wine.grape_id = Grape.find_by_name(@grape_name).id

    # FIXME is this a hack too? According to Efficient Rails TDD on youtube it is
    if @winery
      logger.info "Found existing winery #{@winery}"
    else
      logger.info "Creating new winery #{@winery_name}"
      @winery = Winery.new
      @winery.name = @winery_name
      @winery.save
    end

    @wine.winery = @winery

    logger.info "Got winery #{@winery}"
    logger.info "Got wine #{@wine}"

    @wine.save

    if @wine.errors.any?
      if @wine.country and Country::is_country? @wine.country
        @regions = Country::COUNTRIES[@wine.country].regions << ''
      else
        @regions = []
      end
      err_msg = 'Errors saving wine ' + @wine.errors.full_messages.join(', ')
      flash[:notice] = err_msg
      logger.info "Could not save wine: #{err_msg}"
      render :action => 'new'
    else
      flash[:notice] = "The wine was saved."
      redirect_to wine_path(@wine)
    end
  end

  def self.is_lcbo_code(term)
    /\d{1,10}/ =~ term
  end

  def new
    @wine = Wine.new
    @winery_name = ''
    @grapes_ids = ''
    @regions = []

    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @wine }
    end
  end

  private

  def wine_params
    params.require(:wine).permit(:country, :lcbo_code, :other, :purchased_date, :region, :year, :grapes)
  end
end
