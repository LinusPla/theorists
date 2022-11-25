class AddPhotonumToTheorists < ActiveRecord::Migration[7.0]
  def change
    add_column :theorists, :photonum, :integer
  end
end
