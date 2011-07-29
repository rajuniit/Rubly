class CreateViews < ActiveRecord::Migration
  def self.up
    create_table :views do |t|
      t.references :link
      t.string :ip_address
      t.string :browser
      t.string :referer
      t.string :platform
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :views
  end
end
