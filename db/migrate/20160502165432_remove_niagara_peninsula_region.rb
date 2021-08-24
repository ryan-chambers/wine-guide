class RemoveNiagaraPeninsulaRegion < ActiveRecord::Migration[4.2]
  def change
    execute "update wines set region = 'VQA Niagara Peninsula' where region = 'VQA Niagara'"
  end
end
