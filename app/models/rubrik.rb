class Rubrik < ActiveRecord::Base
  attr_accessible :desc, :name, :prio
  has_many :neuigkeiten, :class_name => "Neuigkeit"
  resourcify
def moderator
   u=User.with_role(:newsmoderator).first
   if !u.nil? 
     u.id
   end
end

def moderator=(id)
User.find(id).add_role(:newsmoderator, self)
end
end
