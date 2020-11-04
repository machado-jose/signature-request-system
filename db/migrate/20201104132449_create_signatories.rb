class CreateSignatories < ActiveRecord::Migration[5.1]
  def change
    create_table :signatories do |t|
      t.references :solicitation, foreign_key: true, null: false
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
