class Membership < ActiveRecord::Base
  attr_accessible :fetprofile_id, :gremium_id, :start, :stop, :typ
  belongs_to :fetprofile
  belongs_to :gremium
end
