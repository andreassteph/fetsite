class AddPriorityToThemen < ActiveRecord::Migration
  def change
    add_column :themen , :priority , :integer
  end
end
