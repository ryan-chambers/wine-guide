class GrapeCreatorGenerator < Rails::Generators::NamedBase

  def create_grape_migration
    normalized_grape_name = file_name.split(/(\W)/).map(&:capitalize).join
    real_file_name = file_name.squish.tr(' ', '_')
    real_class_name = normalized_grape_name.squish.tr(' ', '')
    create_file "db/migrate/#{Time.now.utc.strftime("%Y%m%d%H%M%S")}_create_grape_#{real_file_name}.rb", <<-FILE
class CreateGrape#{real_class_name} < ActiveRecord::Migration
  def up
    Grape.create :name => "#{normalized_grape_name}"
  end
end
      FILE
  end
end
