class CreateTheorists < ActiveRecord::Migration[7.0]
  def change
    create_table :theorists do |t|
      t.string :stage_name
      t.string :main_theory
      t.string :sources
      t.float :price
      t.string :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
