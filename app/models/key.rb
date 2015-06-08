class Key < ActiveRecord::Base
  attr_accessible :expire, :is_valid,  :type, :user_id
  belongs_to :parent, :polymorphic => true
  belongs_to :user
  before_create :create_unique_identifier
  def create_unique_identifier
    begin
      self.uuid = SecureRandom.hex(10) # or whatever you chose like UUID tools
    end while self.class.exists?(:uuid => uuid)
  end
end
