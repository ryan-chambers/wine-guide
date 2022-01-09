class MigrationsController < ApplicationController
  include MigrationHelper

  def kickoff
    logger.info "In migrations controller"

    @count = Wine.count_missing_wine

    logger.info "There are #{@count} records to be migrated"

    Wine.find_wines_to_migrate(5).map { |w| migrate_wine w}

    respond_to do |format|
      # not JSON but who cares
      format.json { render :json => @count}
    end
  end

  def migrate_wine(wine)
    @grape_names = wine.grapes.map { |g| g.name}

    logger.info "Will migrate wine with grapes #{@grape_names}"

    wine.grapes = []
    g = grape_name(@grape_names)

    grape = Grape.find_by_name(g)

    logger.info "Migrating to grape #{grape.name} with id #{grape.id}"

    if (grape)
      wine.grape_id = grape.id
      wine.save!
    elsif
      logger.info "Oops, no grape found!"
    end
  end
end
