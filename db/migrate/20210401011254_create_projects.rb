class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.time :created_date
      t.time :due_date

      t.timestamps
    end
  end
end
