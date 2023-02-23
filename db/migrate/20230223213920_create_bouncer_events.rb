class CreateBouncerEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :bouncer_events do |t|
      t.string :type
      t.references :user, polymorphic: true, index: true
      t.timestamps
    end
  end
end
