class ScoresController < ApplicationController
  def index
    @scores = Score.all

    respond_to do |format|
      format.html
      format.json { render :json => @scores}
    end
  end

  def show
    @score = Score.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @wine}
    end
  end

  def create
   @wine = Wine.find(params[:wine_id])
   @score = @wine.scores.create(params[:score]) do |score|
      if score.in_fridge
        score.score = 0
      end
    end

    if @score.errors.any?
      flash[:notice] = 'Errors saving score: ' + @score.errors.full_messages.join(', ')
    end

    redirect_to wine_path(@wine)
  end

  def edit
    @score = Score.find(params[:id])
  end

  def update
    @score = Score.find(params[:id])

    respond_to do |format|
      if @score.update_attributes(params[:score])
        format.html  { redirect_to(@score,
                      :notice => 'Score was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "show" }
        format.json  { render :json => @score.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
end
