class RenameScoreToBottle < ActiveRecord::Migration[4.2]
  def change
    rename_table :scores, :bottles
  end
end
