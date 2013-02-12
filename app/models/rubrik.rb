class Rubrik < ActiveRecord::Base
  attr_accessible :desc, :name, :prio
  has_many :neuigkeiten
def moderator
end

def moderator=(id)
User.find(id).add_role(:newsmoderator, self)
end
end
