# frozen_string_literal: true

# This migration adds a 'jti' (JWT token identifier) column to the 'users' table.
# The 'jti' column is used to store unique identifiers for JWT tokens issued to users.
class AddJtiToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :jti, :string, null: false
    add_index :users, :jti, unique: true
  end
end
