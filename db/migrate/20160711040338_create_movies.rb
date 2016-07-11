class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :starring
      t.string :date
      t.string :running_time
      t.string :director
      t.string :box_office
      t.string :budget
      t.string :image

      t.timestamps null: false
    end
  end
end
