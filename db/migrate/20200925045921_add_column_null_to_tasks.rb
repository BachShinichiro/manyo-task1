class AddColumnNullToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :limit, :date, default: -> { 'NOW()' }, null: false
  end
end
