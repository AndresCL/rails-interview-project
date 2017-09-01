class CreateTenantsrequests< ActiveRecord::Migration[5.1]
  def change
    create_table :tenantsrequests do |t|
      t.integer :tenant_id, null: false

      t.timestamps null: false
    end
  end
end
