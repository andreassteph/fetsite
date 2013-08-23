# == Schema Information
#
# Table name: memberships
#
#  id            :integer          not null, primary key
#  fetprofile_id :string(255)
#  gremium_id    :string(255)
#  start         :date
#  stop          :date
#  typ           :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Membership < ActiveRecord::Base
  attr_accessible :fetprofile_id, :gremium_id, :start, :stop, :typ
  belongs_to :fetprofile
  belongs_to :gremium
end
