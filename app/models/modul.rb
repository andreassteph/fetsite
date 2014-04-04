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
  attr_accessible :desc,:name, :depend, :studium_id, :modulgruppen

  has_and_belongs_to_many :lvas , :uniq=>true
  has_and_belongs_to_many :modulgruppen
  
  
  validates :modulgruppen, :presence=>true # Ein Modul muss zu einer Modulgruppe gehören
  validates :name, :presence=>true # Ein Modul muss einen Namen haben
  translates :desc,:depend,:name, :versioning =>true, :fallbacks_for_empty_translations => true
  def  self.update_multiple(hash)
    m= []
    if hash.is_a? Hash
    hash.each do |i,h|
      if i.to_i == 0 
        unless h["name"].empty?
          md=Modul.new(:name=>h["name"],:desc=>h["desc"],:depend=>h["depend"])
          md.modulgruppen=Modulgruppe.where(:id => h["modulgruppe_ids"].map(&:to_i))
          md.save
          m << md
        end
      else
        md=Modul.find(h["id"].to_i)
        md.name=h["name"]
        md.desc=h["desc"]
        md.depend=h["depend"]
        md.modulgruppen=Modulgruppe.where(:id => h["modulgruppe_ids"].map(&:to_i))
        m << md
      end
    end
    else 
      hash.each do |h|
      unless h["name"].empty?
          md=Modul.new(:name=>h["name"],:desc=>h["desc"],:depend=>h["depend"])
          md.modulgruppen=Modulgruppe.where(:id => h["modulgruppe_ids"].map(&:to_i))
          md.save
          m << md
        end
      end  
  end
    m
  end
end
