class ScoresController < ApplicationController
  def index
    @scores = Score.all

    respond_to do |format|
      format.html
      format.json { render :json => @scores}
    end
  end

  def create
    @wine = Wine.find(params[:wine_id])
    @score = @wine.scores.create(params[:score]) do |score|
      if score.in_fridge
        score.score = 0
      end
    end

    redirect_to wine_path(@wine)
  end
end
