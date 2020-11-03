class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :name, null: false
      t.string :filename, null: false

      t.timestamps
    end
  end
end
