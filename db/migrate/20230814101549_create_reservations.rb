# frozen_string_literal: true

# This migration creates the 'reservations' table for storing flight reservations.
class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date :reservation_date
      t.date :returning_date
      t.string :city
      t.references :user, null: false, foreign_key: true
      t.references :aeroplane, null: false, foreign_key: true

      t.timestamps
    end
  end
end
