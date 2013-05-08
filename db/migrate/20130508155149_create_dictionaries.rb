class CreateDictionaries < ActiveRecord::Migration
  def change
    create_table :dictionaries do |t|
      t.text :original
      t.text :grouped
      t.float :time_taken
      t.string :filename

      t.timestamps
    end
  end
end
