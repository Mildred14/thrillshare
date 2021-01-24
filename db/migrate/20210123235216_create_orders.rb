class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :school, null: false, foreign_key: true, index: true
      t.text :recipient_ids, array: true, default: []
      t.text :gifts, array: true, default: []
      t.integer :status, limit: 2
      t.boolean :notify_delivery
      t.datetime :cancelled_at, index: true
      t.datetime :received_at, index: true
      t.datetime :shipped_at, index: true

      t.timestamps
    end
  end
end
