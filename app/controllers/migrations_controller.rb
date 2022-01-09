class MigrationsController < ApplicationController
  include MigrationHelper

  def kickoff
    logger.info "In migrations controller, got migration count #{params[:count]}"

    @count = params[:count].to_i

    @toMigrate = @count > 0 && @count <= 100 ? @count : 5

    @remaining = Wine.count_missing_wine

    logger.info "There are #{@remaining} records to be migrated"

    Wine.find_wines_to_migrate(@toMigrate).map { |w| migrate_wine w}

    respond_to do |format|
      # not JSON but who cares
      format.json { render :json => @remaining}
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
