class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :authentication_token
      add_column :users, google_token, :string
      add_column :users, google_refresh_token, :string
      t.timestamps
    end
  end
end
