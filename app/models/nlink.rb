class Nlink < ActiveRecord::Base
  attr_accessible :link_id, :link_type, :neuigkeit_id, :neuigkeit,:link, :sort, :title
  belongs_to :neuigkeit
  belongs_to :link, :polymorphic=>true
  validates :neuigkeit, :presence=>true
  validates :link, :presence=>true
  validates :link_id, :uniqueness=>{:scope=>[:neuigkeit_id]}


end
