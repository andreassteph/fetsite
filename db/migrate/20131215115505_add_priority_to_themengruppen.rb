class AddPriorityToThemengruppen < ActiveRecord::Migration
  def change
        add_column :themengruppen , :priority , :integer

  end
end
