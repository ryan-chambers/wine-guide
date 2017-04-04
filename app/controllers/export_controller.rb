class ExportController < ApplicationController
  before_action :authenticate

  def export
    send_data WineScoreExporter.new.export_db,
      :type => 'text',
      :disposition => "attachment; filename=export_#{Date.today.strftime('%d_%b_%Y')}.txt"
  end
end
