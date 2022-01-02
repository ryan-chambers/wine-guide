class MigrationsController < ApplicationController

  def kickoff
    logger.info "In migrations controller"

    @count = Wine.count_missing_wine

    logger.info "There are #{@count} records to be migrated"

    @wines = Wine.find_wines_to_migrate(5)

#    logger.info "Will migrate grape #{@wines[0].grapes[0].name}"

    @grape_names = @wines[0].grapes.map { |g| g.name}

    logger.info "Will migrate wine with grapes #{@grape_names}"

    respond_to do |format|
      # not JSON but who cares
      format.json { render :json => @wines}
    end
  end
end
