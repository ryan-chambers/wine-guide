class MigrationsController < ApplicationController

  def kickoff
    logger.info "In migrations controller"
    a = 1

    respond_to do |format|
      format.json { render :json => a}
    end
  end
end
