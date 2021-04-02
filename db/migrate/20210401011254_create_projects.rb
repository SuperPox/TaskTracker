class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :project_creator
      t.string :project_description
      t.integer :project_status
      t.time :created_date
      t.string :due_date

      t.timestamps
    end
  end
end
