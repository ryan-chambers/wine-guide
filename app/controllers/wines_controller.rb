class WinesController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]

  def index
    logger.info "searching for #{params[:term]}"

    if params[:term]
      logger.info "searching for #{params[:term]}"
      @wines = Wine.find_wines_by_winery_name params[:term]
    else
      @wines = Wine.filter_paginate(params[:grape_filter], :page => params[:page])
    end

#    logger.info "got wines #{@wines}"

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
    @grape_ids = params[:grape_ids]

    @winery = Winery.find_by_name(@winery_name)

    # FIXME this is a hack. Need to figure out how to embed grapes in wine form
    if(@grape_ids)
      @grape_ids.split('|').each do |grape_id|
        grape_id = grape_id.strip
        if ! grape_id.empty? and grape_id != ' '
          logger.info "Found grape_id <#{grape_id}>"
  
          @wine.grapes << Grape.find(grape_id)
        end
      end
    end

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
end
