class CreateStrainDataSheets < ActiveRecord::Migration[6.0]
  def change
    create_table :strain_data_sheets do |t|

      t.timestamps
    end
  end
end
