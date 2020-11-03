class CreateSolicitations < ActiveRecord::Migration[5.1]
  def change
    create_table :solicitations do |t|
      t.references :user, foreign_key: true, null: false
      t.references :document, foreign_key: true, null: false
      t.string :description, null: false

      t.timestamps
    end
  end
end
