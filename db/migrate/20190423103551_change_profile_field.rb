# frozen_string_literal: true

class ChangeProfileField < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      change_table :profiles, bulk: true do |t|
        dir.up do
          t.remove :delivery_address
          t.column :street, :string
          t.column :postal_code, :string
          t.column :city, :string
        end

        dir.down do
          t.string :delivery_address
          t.remove :street
          t.remove :postal_code
          t.remove :city
        end
      end
    end
  end
end
