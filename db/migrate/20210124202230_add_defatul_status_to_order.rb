class AddDefatulStatusToOrder < ActiveRecord::Migration[6.0]
  def up
    change_column :orders, :status, :integer, limit: 2, default: 0
  end

  def down
    change_column :orders, :status, :integer, limit: 2
  end
end
