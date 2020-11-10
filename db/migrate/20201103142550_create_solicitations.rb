class CreateSolicitations < ActiveRecord::Migration[5.1]
  def change
    create_table :solicitations do |t|
      t.boolean :is_canceled, default: false
      t.timestamps
    end
  end
end
