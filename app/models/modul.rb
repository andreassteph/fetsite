# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: moduls
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  desc       :text
#  depend     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Modul < ActiveRecord::Base
  attr_accessible :desc,:name, :depend, :studium_id, :modulgruppe_ids

  has_and_belongs_to_many :lvas 
  has_and_belongs_to_many :modulgruppen
  
  
   validates :modulgruppen, :presence=>true # Ein Modul muss zu einer Modulgruppe gehören
  validates :name, :presence=>true # Ein Modul muss einen Namen haben
  translates :desc,:depend,:name, :versioning =>true, :fallbacks_for_empty_translations => true

end
