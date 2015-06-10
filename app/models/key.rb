class Key < ActiveRecord::Base
  attr_accessible :expire, :is_valid,  :typ, 
  belongs_to :parent, :polymorphic => true
  belongs_to :user
  before_create :create_unique_identifier
  def create_unique_identifier
    begin
      self.uuid = SecureRandom.hex(10) # or whatever you chose like UUID tools
    end while self.class.exists?(:uuid => uuid)
  end
  def self.find_or_create(user, typ, parent=nil)
    if parent.nil? || !parent
      kk=Key.where(user_id: user.id, typ: typ, is_valid: true).first
      if kk.nil?
        kk=Key.new 
        kk.user=user 
        kk.typ = typ 
        kk.is_valid = true
      end
    else
      kk=Key.where(user_id: user.id, typ: typ, is_valid: true, parent_type: parent.class.to_s, parent_id: parent.id).first

      if kk.nil?
        kk=Key.new 
        kk.user=user 
        kk.typ = typ 
        kk.is_valid = true
kk.parent=parent

      end
    end
    kk
  end
end
