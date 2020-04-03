class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :content
      t.date :end_date
      t.integer :priority
      t.integer :status

      t.timestamps
    end
  end
end
