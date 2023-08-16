# frozen_string_literal: true

ActiveRecord::Schema[7.0].define(version: 20_230_815_185_139) do
  enable_extension 'plpgsql'

  create_table 'aeroplanes', force: :cascade do |t|
    t.string 'name'
    t.string 'model'
    t.text 'description'
    t.decimal 'price'
    t.decimal 'booking_price'
    t.string 'image'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'reservations', force: :cascade do |t|
    t.date 'reservation_date'
    t.date 'returning_date'
    t.string 'city'
    t.bigint 'user_id', null: false
    t.bigint 'aeroplane_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['aeroplane_id'], name: 'index_reservations_on_aeroplane_id'
    t.index ['user_id'], name: 'index_reservations_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name'
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'jti', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['jti'], name: 'index_users_on_jti', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'reservations', 'aeroplanes'
  add_foreign_key 'reservations', 'users'
end
