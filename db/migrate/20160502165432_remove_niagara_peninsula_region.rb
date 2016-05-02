class RemoveNiagaraPeninsulaRegion < ActiveRecord::Migration
  def change
    execute "update wines set region = 'VQA Niagara Peninsula' where region = 'VQA Niagara'"
  end
end
