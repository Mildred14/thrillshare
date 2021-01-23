class AddForeignKeyToRecipients < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :recipients, :schools
  end
end
