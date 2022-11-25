class AddTheoryDescriptionToTheorists < ActiveRecord::Migration[7.0]
  def change
    add_column :theorists, :theory_description, :string
  end
end
