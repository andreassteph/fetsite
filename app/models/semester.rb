
# == Schema Information
#
# Table name: semesters
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  nummer     :integer
#  studium_id :integer
#  ssws       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Semester < ActiveRecord::Base
  attr_accessible :name, :nummer, :ssws, :lva_ids
  has_and_belongs_to_many :lvas
  belongs_to :studium, :foreign_key => "studium_id"
  validates :name, :presence => true
  validates :nummer, :presence => true
  class << self
    def batch_add(name, type, target)
      if type == "Bachelor"
        length = 6
      else
        length = 4
      end
      for i in 1..length
        semester =Semester.new()
        semester.name = i.to_s + ". " + name
        semester.nummer = i
        if i % 2 == 0
          semester.ssws = "SS"
        else
          semester.ssws = "WS"
        end
        semester.save
        target << semester
      end
      semester = Semester.new()
      semester.name = "Ohne Zuordnung"
      semester.nummer = 0
      semester.ssws = "WS"
      semester.save
      target << semester
    end

    def batch_destroy(studium)
      for m in studium.semester
        m.destroy
      end
    end
  end
end
