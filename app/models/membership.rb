class Membership < ActiveRecord::Base
  attr_accessible :fetprofile_id, :gremium_id, :start, :stop, :typ
end
