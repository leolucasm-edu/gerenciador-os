class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.string :email
      t.references :cliente, foreign_key: true

      t.timestamps
    end
  end
end
