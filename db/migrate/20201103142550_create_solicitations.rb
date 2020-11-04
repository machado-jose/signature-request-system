class CreateSolicitations < ActiveRecord::Migration[5.1]
  def change
    create_table :solicitations do |t|
      t.string :description, null: false

      t.timestamps
    end
  end
end
