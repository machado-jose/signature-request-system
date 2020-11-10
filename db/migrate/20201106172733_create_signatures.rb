class CreateSignatures < ActiveRecord::Migration[5.1]
  def change
    create_table :signatures do |t|
      t.references :solicitation, foreign_key: true, null:false
      t.references :signatory, foreign_key: true, null: false
      t.string :url, null: false 
      t.string :signature_token, null: false
      t.boolean :is_signed, default: false
      t.boolean :denied, default: false
      t.text :justification

      t.timestamps
    end
  end
end
