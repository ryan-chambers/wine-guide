class RenameScoreToBottle < ActiveRecord::Migration
  def change
    rename_table :scores, :bottles
  end
end
