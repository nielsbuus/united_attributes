class CreateDucks < ActiveRecord::Migration
  def change
    create_table :ducks do |t|
      t.string :name
      t.datetime :birthday
      t.decimal :weight
      t.decimal :top_speed
      t.decimal :height
      t.integer :lifespan

      t.timestamps
    end
  end
end
