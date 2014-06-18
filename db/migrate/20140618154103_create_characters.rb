class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :actor, null: false
      t.string :description
      t.integer :television_show_id

      t.timestamps
    end
  end
end
