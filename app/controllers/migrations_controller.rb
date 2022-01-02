class MigrationsController < ApplicationController

  def kickoff
    logger.info "In migrations controller"

    @count = Wine.count_missing_wine

    logger.info "There are #{@count} records to be migrated"

    respond_to do |format|
      # not JSON but who cares
      format.json { render :json => @count}
    end
  end
end
