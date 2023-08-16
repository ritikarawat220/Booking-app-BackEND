# frozen_string_literal: true

# This migration creates the 'aeroplanes' table for storing information about airplanes.
class CreateAeroplanes < ActiveRecord::Migration[7.0]
  def change
    create_table :aeroplanes do |t|
      t.string :name
      t.string :model
      t.text :description
      t.decimal :price
      t.decimal :booking_price
      t.string :image

      t.timestamps
    end
  end
end
