class CreateDataSheets < ActiveRecord::Migration[6.0]
  def change
    create_table :data_sheets do |t|
      t.references :rack, foreign_key: true
      t.references :tray, foreign_key: true
      t.references :location, foreign_key: true
      t.string :status
      t.timestamps
    end
  end
end
